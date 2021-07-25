//
//  NetworkService.swift
//  FckingGreatAdvice
//
//  Created by Mac on 12.07.2021.
//

import Foundation
import UIKit

class NetworkService {
    
    private init() {}
    
    static let shared = NetworkService()
    
    public func getData(completion: @escaping (ModelAdvice) -> Void) {
        
        let url = URL(string: "http://fucking-great-advice.ru/api/random")
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                
                let json = try decoder.decode(ModelAdvice.self, from: data)
                
                DispatchQueue.main.async {
                    completion(json)
                }
//                print(String(decoding: data, as: UTF8.self))
            } catch {
                print(error)
            }
        }.resume()
}
}
