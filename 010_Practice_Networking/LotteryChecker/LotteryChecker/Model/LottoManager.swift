//
//  LottoDataManager.swift
//  PracticeNetworking
//
//  Created by Roen White on 2023/08/09.
//

import Foundation
import RxSwift

struct LottoManager {

    private let lottoURL: String = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    
    func fetchLotto(drawingNumber: String) -> Single<Lotto> {
        let urlString = "\(lottoURL)&drwNo=\(drawingNumber)"
        return performRequest(with: urlString)
    }
    
    // MARK: Single
    /// RxSwift의 Trait 중 하나로 Swift의 Result와 비슷함
    /// 여러 elements를 지속적으로 방출하지 않고, 단 하나의 element 혹은 error를 방출함
    /// 따라서 첫 번째 방출 이후에는 (그게 element든 error든) 더 이상 이벤트가 발생하지 않음! → 자동으로 구독 종료
    private func performRequest(with urlString: String) -> Single<Lotto> {
        guard let url = URL(string: urlString) else {
            return Single<Lotto>.error(LottoError.urlError)
        }
        
        return Single<Lotto>.create { single in
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error {
                    single(.failure(error))
                    return
                }
                
                guard let data = data, let lotto = self.parseJSON(data) else {
                    single(.failure(LottoError.jsonParsingError))
                    return
                }
                
                DispatchQueue.main.async {
                    single(.success(lotto))
                }
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    func fetchLotto(drawingNumber: String, completion: @escaping (Lotto?) -> ()) {
        let urlString = "\(lottoURL)&drwNo=\(drawingNumber)"
        performRequest(with: urlString) { lotto in
            DispatchQueue.main.async { completion(lotto) }
        }
    }
    
    private func performRequest(with urlString: String, completion: @escaping (Lotto?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            if error != nil {
                print(#function, "error :", error!)
                completion(nil)
                return
            }
            
            guard let data, let lotto = self.parseJSON(data) else {
                completion(nil)
                return
            }
            
            completion(lotto)
        }
        
        task.resume()
    }
    
    private func parseJSON(_ jsonData: Data) -> Lotto? {
        let decoder = JSONDecoder()
        
        do {
            let lottoData = try decoder.decode(LottoData.self, from: jsonData)
            
            let lotto = Lotto(from: lottoData)
            return lotto
        } catch {
            print("Fail Parsing")
            return nil
        }
    }
}
