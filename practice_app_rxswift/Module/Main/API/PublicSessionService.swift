//
//  PublicSessionService.swift
//  ExerciseProject
//
//  Created by Joseph Mikko Mañoza on 14/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation

class PublicSessionService {
    public func callAPIGetPublicSession(onSuccess successCallback: ((_ session: [PublicSessionModel]) -> Void)?, onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
    
        APICallManager.instance.callAPIGetPublicSession (
            onSuccess: { (session) in
                successCallback?(session)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}

