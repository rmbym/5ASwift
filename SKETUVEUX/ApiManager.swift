//
//  ApiManager.swift
//  SKETUVEUX
//
//  Created by rmbym on 28/10/2022.
//

import Foundation
import UIKit
import Alamofire

class ApiManager {

    init() {}
    //Singleton Pattern
    public static let shared = ApiManager()

    public func getRequest<T:Decodable>(to url: String, excpeting model: T.Type, callbackFunc: @escaping(T?) -> ()){
        AF.request(url, method: .get).validate().responseDecodable(of: model.self) {
            response in
            if let responseValue = response.value {
                callbackFunc(responseValue)
            }
            print("End of function execution")
        }
    }
    
}