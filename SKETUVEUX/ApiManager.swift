//
//  ApiManager.swift
//  toolboxApp
//
//  Created by rmbym on 24/10/2022.
//

import Foundation
import Alamofire

class ApiManager {
    
    init(){}
    // Singleton Pattern
    public static let shared = ApiManager()
    
    
    public func getRequest<T:Decodable>(to url: String, expecting model: T.Type, callbackFunc: @escaping (T?) -> ()) {
        AF.request(url,method: .get).validate().responseDecodable(of: model.self) { response in
            if let responseValue = response.value {
                callbackFunc(responseValue)
            }
        }
        print("End of function execution")
    }
    
}
//MARK: Examples of Get Requests
/*
//MARK: 1st Method - With Decodable
ApiManager.shared.getRequest(to: "https://api.chucknorris.io/jokes/random", expecting: Joke.self) { payload in
    if let realJoke = payload?.value {
        print("received")
        self.jokes.append(realJoke)
    }
}
//MARK: 2nd method - With JSONSerialization and too much casts
AF.request("https://api.chucknorris.io/jokes/random",method: .get).response { response in
    let test = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any]
    if let realJoke = test?["value"] as? String {
        print("received")
        self.jokes.append(realJoke)
    }
}
*/
