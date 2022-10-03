//
//  NetworkManager.swift
//  Alamofire Table
//
//  Created by Александр Пархамович on 1.10.22.
//

import Foundation
import UIKit
import Alamofire

final class NetworkManager {
    
    static let instance = NetworkManager()
    
    enum Constants {
        static let baseURL = "https://jsonplaceholder.typicode.com"
    }
    enum EndPoints {
        static let posts = "/posts/"
    }
    
    private init() { }

    func loadPosts(completionHandler: @escaping (_ data: [PostModel])-> Void ) {
        AF.request(Constants.baseURL + EndPoints.posts).response { response in
            switch response.result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode([PostModel].self, from: data!)
                    completionHandler(jsonData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
