//
//  APICallManager.swift
//  ExerciseProject
//
//  Created by Joseph Mikko Mañoza on 13/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

let userToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImIyMDY1YTVhYTlkNDdhYTU3OTVmNTFmMWUwNzQ2ZGE2YWZkMWNjNzViYzdhZjY3Njc4YzRhMmMyNWEyNjU5NTAzZmM0MmIwZTk0NmJiM2I5In0.eyJhdWQiOiI1IiwianRpIjoiYjIwNjVhNWFhOWQ0N2FhNTc5NWY1MWYxZTA3NDZkYTZhZmQxY2M3NWJjN2FmNjc2NzhjNGEyYzI1YTI2NTk1MDNmYzQyYjBlOTQ2YmIzYjkiLCJpYXQiOjE1ODE3NTk4NDEsIm5iZiI6MTU4MTc1OTg0MSwiZXhwIjoxNjEzMzgyMjQxLCJzdWIiOiI1MTQiLCJzY29wZXMiOltdfQ.RIf823tWb8BaIAYmtoeh-13EAyGHcc31NwuwMibNOffnqDpgSBllczriNeB1sFJ4xkzzp35tCL2_NhsZ3CTvNyNe2kYuOaMCUr9Y2_tliEywqYnkkK8eahMyl4FGMCwe34iOhv7JiDlNa-F7_6CgFOJy-MTYe13YTNlhK828dGJbFZYUrsaDhWMLBhKIt3ycSKo1QDbX8zJe_MrD7OMKumDUjajqYd92DtW3dmAFouCidGhkMR2-EIHLvmx1kJ_JWs4SO8ZXZBkrl7gFALRWFcqlcfc38oa_DblbeKwLvnh7J4-4_FXfVUy32uv8NJSRd4KO3ZewJdFbOuc-uhaN3yWmd_aInC1Vb2nxQ7Q3_Ei33Tm8Ky1H6s9VzpE-QMxoKSAtaJplLaxUFhVd-yKj1F-oJ-iX-yqu1h4A9CabcmcatK0QGP2cSqYJzm3W47usM0bDLVx1D3tzfae8XRG-8eyxE01nPuWAjbNvTyT6AiXvpKXrCbpjw2dncVmUAFoaUL-aPijIyAGMsO4xFrZ3TeIM86gyPMzMMeJ4Y6NmhW3CmVfJcOv_qc-O82b_ZqKwg6_1wwO6LjYhCzIJIj2i2by4SeUKyP75UeT8UjdzMrZmB8X32gsc72dqPYrSaVK2dcrsY1Mwz3WswHKhEd9llXBq5tLO72LVcFySIBVlJfU"

let API_BASE_URL = "http://developers.studenttriangle.com"

class APICallManager {
    
    let header: HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(userToken)"]
    let params: [String: Any] = ["keyword": "", "timezone": "Asia/Manila"]
    
    static let instance = APICallManager()
    
    enum RequestMethod {
        case get
        case post
    }
    
    enum Endpoint: String {
        case PublicSession = "/api/workspace/user/session/session-list"
    }
    
    // MARK: Public Session API
    func callAPIGetPublicSession(onSuccess successCallback: ((_ session: [PublicSessionModel]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        // Build URL
        let url = API_BASE_URL + Endpoint.PublicSession.rawValue
        
        print("ito ang url: \(url)")
        
        // call API
        self.createRequest(
            url, method: .post, headers: header, parameters: params, encoding: JSONEncoding.default,
            onSuccess: {(responseObject: JSON) -> Void in
                
                let statusCode = responseObject["status"].intValue
                
                switch statusCode {
                case 200:
                    // Create dictionary
                    if let responseDict = responseObject["data"]["data"].arrayObject {
                       let publicSessionDict = responseDict as! [[String:AnyObject]]
    
                        // Create object
                        var data = [PublicSessionModel]()
                        for item in publicSessionDict {
                            let single = PublicSessionModel.build(item)
                            print("single 1: \(single)")
                            data.append(single)
                        }
    
                        // Fire callback
                        successCallback?(data)
                    } else {
                        failureCallback?("An error has occured.")
                    }
                    break
                case 204:
                    failureCallback?("An error has occured. statusCode == 204")
                    break
                case 400...500:
                    failureCallback?("An error has occured. statusCode == 400...500")
                    break
                default:
                    failureCallback?("An error has occured.")
                }
            },
            onFailure: {(errorMessage: String) -> Void in
                failureCallback?(errorMessage)
            }
        )
    }
    
    // MARK: Request Handler
    // Create request
    func createRequest(
        _ url: String,
        method: HTTPMethod,
        headers: [String: String],
        parameters: [String: Any],
        encoding: JSONEncoding,
        onSuccess successCallback: ((JSON) -> Void)?,
        onFailure failureCallback: ((String) -> Void)?
        ) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback {
                    // Return
                    callback(error.localizedDescription)
                }
            }
        }
    }
}
