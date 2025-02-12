//
//  MainService.swift
//  Picknic-iOS-Jieun
//
//  Created by 황지은 on 2020/12/17.
//

import Foundation
import Alamofire

struct MainService {
    
    static let shared = MainService()
    
    func getMain(completion: @escaping (NetworkResult<Any>) -> (Void)){
       
        let url = APIConstants.mainURL
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default, headers: header)
        
        
        dataRequest.responseData {(response) in
            switch response.result { case .success:
                guard let statusCode = response.response?.statusCode else { return
                }
                guard let data = response.value else {
                    return
                }
                completion(judgeMainData(status: statusCode, data: data))
            case .failure(let err): print(err)
                completion(.networkFail) }
        }
    }
    
    
    
    private func judgeMainData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<EntireData>.self, from: data) else {
            return .pathErr }
        switch status {
        case 200:
            print("나 성공이야")
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail }
    }
}
