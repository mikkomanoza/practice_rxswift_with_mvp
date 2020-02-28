//
//  PublicSession.swift
//  ExerciseProject
//
//  Created by Joseph Mikko Mañoza on 14/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation

class PublicSessionModel {
    var id: Int?
    var sessionName: String?
    var description: String?
    var companyName: String?
    var gatheringType: String?
    var sessionType: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["id"] as? Int {
            self.id = data
        }
        if let data = dict["session_name"] as? String {
            self.sessionName = data
        }
        if let data = dict["description"] as? String {
            self.description = data
        }
        if let data = dict["company_name"] as? String {
            self.companyName = data
        }
        if let data = dict["gathering_type"] as? String {
            self.gatheringType = data
        }
        if let data = dict["session_type"] as? String {
            self.sessionType = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> PublicSessionModel {
        let session = PublicSessionModel()
        session.loadFromDictionary(dict)
        return session
    }
}
