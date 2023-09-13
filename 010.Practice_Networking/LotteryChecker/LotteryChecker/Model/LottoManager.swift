//
//  LottoDataManager.swift
//  PracticeNetworking
//
//  Created by Roen White on 2023/08/09.
//

import Foundation

struct LottoManager {

    private let lottoURL: String = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    
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
