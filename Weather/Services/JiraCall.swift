//
//  JiraCall.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 25/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import Combine
import Foundation

class JiraCall: ObservableObject {
    
    func login(email: String){
    
        let url = URL(string: "https://jira.atlassian.net/rest/api/latest/user?username=\(email.split(separator: "@")[0])")

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
        
    }
    
    func getPhoto(){
        
    }
    
    
}
