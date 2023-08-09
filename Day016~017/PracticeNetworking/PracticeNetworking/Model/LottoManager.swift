//
//  LottoDataManager.swift
//  PracticeNetworking
//
//  Created by Roen White on 2023/08/09.
//

import Foundation

struct LottoManager {

    private let lottoURL: String = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    
    func fetchLotto(drawingNumber: Int, completion: @escaping (Lotto?) -> ()) {
        let urlString = "\(lottoURL)&drwNo=\(drawingNumber)"
        performRequest(with: urlString) { lotto in
            completion(lotto)
        }
    }
    
    private func performRequest(with urlString: String, completion: @escaping (Lotto?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
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
            
            let lotteryNumber = [lottoData.drwtNo1, lottoData.drwtNo2, lottoData.drwtNo3, lottoData.drwtNo4, lottoData.drwtNo5, lottoData.drwtNo6]
            
            let lotto = Lotto(drawingNumber: lottoData.drwNo, drawingDate: lottoData.drwNoDate, loteryNumber: lotteryNumber, bonusNumber: lottoData.bnusNo)
            
            return lotto
        } catch {
            print("Fail Parsing")
            return nil
        }
    }
}
