//
//  PublicSessionPresenter.swift
//  ExerciseProject
//
//  Created by Joseph Mikko Mañoza on 14/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation

// MARK: - Setup View Data

struct PublicSessionViewData {
    let sessionName: String
    let sessionDescription: String
    let companyName: String
    let gatheringType: String
    let sessionType: String
}

// MARK: - Setup View with Object Protocol

protocol PublicSessionView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setPublicSession(session: [PublicSessionViewData])
    func setEmptyPublicSession()
}

// MARK: - Setup Presenter

class PublicSessionPresenter {
    
    private let publicSessionService: PublicSessionService
    weak private var publicSessionView : PublicSessionView?
    
    init(publicSessionService: PublicSessionService) {
        self.publicSessionService = publicSessionService
    }
    
    func attachView(view: PublicSessionView) {
        publicSessionView = view
    }
    
    func detachView() {
        publicSessionView = nil
    }
    
    func getPublicSession() {
        self.publicSessionView?.startLoading()
        
        publicSessionService.callAPIGetPublicSession(onSuccess: { (session) in
        
            self.publicSessionView?.finishLoading()
            
            if (session.count == 0) {
                self.publicSessionView?.setEmptyPublicSession()
            } else {
                let mappedSession = session.map {
                    return PublicSessionViewData(sessionName: "\($0.sessionName!)", sessionDescription: "\($0.description!)", companyName: "\($0.companyName!)", gatheringType: "\($0.gatheringType!)", sessionType: "\($0.sessionType!)")
                }
                
                self.publicSessionView?.setPublicSession(session: mappedSession)
            }
            
        }) { (errorMessage) in
            debugPrint(errorMessage)
            self.publicSessionView?.finishLoading()
        }
    }
}
