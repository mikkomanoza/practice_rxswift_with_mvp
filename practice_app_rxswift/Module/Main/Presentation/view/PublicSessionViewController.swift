//
//  PublicSessionViewController.swift
//  ExerciseProject
//
//  Created by Joseph Mikko Mañoza on 14/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation
import UIKit

class PublicSessionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let presenter = PublicSessionPresenter(publicSessionService: PublicSessionService())
    var publicSessionToDisplay = [PublicSessionViewData]()
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        activityIndicator.hidesWhenStopped = true
        
        presenter.attachView(view: self)
        presenter.getPublicSession()
    }
}

extension PublicSessionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PublicSessionCell", for: indexPath)
        cell.textLabel?.text = publicSessionToDisplay[indexPath.row].sessionName
        cell.detailTextLabel?.text = publicSessionToDisplay[indexPath.row].sessionDescription
        print("\(publicSessionToDisplay[indexPath.row].companyName)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        publicSessionToDisplay.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension PublicSessionViewController: PublicSessionView {
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
      
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setPublicSession(session: [PublicSessionViewData]) {
        publicSessionToDisplay = session
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func setEmptyPublicSession() {
        tableView.isHidden = true
    }
}
