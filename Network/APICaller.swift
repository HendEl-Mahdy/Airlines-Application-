//
//  APICaller.swift
//  AirlinesApplication
//
//  Created by admin user on 18/07/2024.
//

import Foundation

class APICaller{
    
        static func getAirlinesData(
            completionHandler: @escaping (_ result: Result<[InputData],AppError>)
        -> Void) {
            guard let url = URL(string: Constants.apiURL) else{
                completionHandler(.failure(.invalidURLError))
                return
            }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { dataResponse, response, error in
                if error ==  nil, let data = dataResponse, let resultData = try? JSONDecoder().decode([InputData].self, from: data){
                    completionHandler(.success(resultData))
                }else{
                    completionHandler(.failure(.parsingError))
                }
            }
            task.resume()
        }
    
}
