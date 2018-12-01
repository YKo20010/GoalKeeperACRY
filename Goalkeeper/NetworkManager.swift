//
//  NetworkManager.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/27/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    private static let goalsURL = "http://104.196.28.226/api/goals/"
    
    static func getGoals(_ didGetGoals: @escaping ([Goal]) -> Void) {
        Alamofire.request(goalsURL, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let i = try? jsonDecoder.decode(GoalsResponse.self, from: data) {
                    didGetGoals(i.results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    static func postGoal(goal: Goal) -> Void {
        let parameters: Parameters = [
            "name": goal.name,
            "date": goal.date,
            "description": goal.description,
            "startDate": goal.startDate,
            "endDate": ""
        ]
        print(parameters)
        Alamofire.request(goalsURL, method: .post, parameters: parameters, encoding: URLEncoding.default).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    
    }
}
