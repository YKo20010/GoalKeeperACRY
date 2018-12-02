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
    
    private static let baseURL = "http://104.196.28.226/api/"
    private static let localBaseURL = "http://localhost:5000/api/"
    private static let goalsURL = "http://104.196.28.226/api/goals/"
    ///api/goals/
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
    ///api/goal/{id}/checkpoints/
    static func getCheckpoints(id: Int, _ didGetCheckpoints: @escaping([Checkpoint]) -> Void) {
        let getCURL = "\(localBaseURL)goal/\(id)/checkpoints/"
        Alamofire.request(getCURL, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let i = try? jsonDecoder.decode(CheckpointsResponse.self, from: data) {
                    didGetCheckpoints(i.results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    static func postGoal(goal: Goal) -> Void {
        let postGURL = "\(localBaseURL)goals/"
        let parameters: Parameters = [
            "name": goal.name,
            "user": goal.user,
            "date": goal.date,
            "description": goal.description,
            "startDate": goal.startDate,
            "endDate": goal.endDate
        ]
        print(parameters)
        Alamofire.request(postGURL, method: .post, parameters: parameters, encoding: URLEncoding.default).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    ///api/goal/{id}/
    static func editGoal(id: Int, goal: Goal) -> Void {
        let editGID = "\(localBaseURL)goal/\(id)/"
        let parameters: Parameters = [
            "name": goal.name,
            "user": goal.user,
            "date": goal.date,
            "description": goal.description,
            "startDate": goal.startDate,
            "endDate": goal.endDate
        ]
        print(parameters)
        Alamofire.request(editGID, method: .post, parameters: parameters).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    ///api/goal/{id}/checkpoint/
    static func postCheckpoint(id: Int, checkpoint: Checkpoint) -> Void {
        let createCID = "\(localBaseURL)goal/\(id)/checkpoint/"
        let parameters: Parameters = [
            "name": checkpoint.name,
            "date": checkpoint.date,
            "isFinished": checkpoint.isFinished,
            "startDate": checkpoint.startDate,
            "endDate": checkpoint.endDate
        ]
        print(parameters)
        Alamofire.request(createCID, method: .post, parameters: parameters, encoding: URLEncoding.default).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    ///api/goal/{id}/
    static func deleteGoal(id: Int) -> Void {
        let idURL = "\(localBaseURL)goal/\(id)/"
        Alamofire.request(idURL, method: .delete)
    }
    ///api/goal/{goal_id}/checkpoint/{checkpoint_id}/
    static func deleteCheckpoint(id: Int, ckptID: Int) -> Void {
        let ckptIDURL = "\(localBaseURL)goal/\(id)/checkpoint/\(ckptID)/"
        Alamofire.request(ckptIDURL, method: .delete)
    }
    
    
    
    
    
}
