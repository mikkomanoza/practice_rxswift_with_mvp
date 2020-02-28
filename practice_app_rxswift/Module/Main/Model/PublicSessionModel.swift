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
//    var phone: PhoneModel?
    
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
        
//        if let data = dict["phone"] as? [String:AnyObject] {
//            self.phone = PhoneModel.build(data)
//        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> PublicSessionModel {
        let session = PublicSessionModel()
        session.loadFromDictionary(dict)
        return session
    }
}

//class PhoneModel {
//    var mobile: String?
//    var home: String?
//    var office: String?
//
//    // MARK: Instance Method
//    func loadFromDictionary(_ dict: [String: AnyObject]) {
//        if let data = dict["mobile"] as? String {
//            self.mobile = data
//        }
//        if let data = dict["home"] as? String {
//            self.home = data
//        }
//        if let data = dict["office"] as? String {
//            self.office = data
//        }
//    }
//
//    // MARK: Class Method
//    class func build(_ dict: [String: AnyObject]) -> PhoneModel {
//        let phone = PhoneModel()
//        phone.loadFromDictionary(dict)
//        return phone
//    }
//}
