//
//  PublicSessionViewController.swift
//  ExerciseProject
//
//  Created by Joseph Mikko Mañoza on 14/02/2020.
//  Copyright © 2020 Joseph Mikko Mañoza. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class PublicSessionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = PublicSessionPresenter(publicSessionService: PublicSessionService())
    var publicSessionToDisplay = [PublicSessionViewData]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        presenter.attachView(view: self)
        presenter.getPublicSession()
    }
    
    private func bindData() {
        let objArr: Observable<[PublicSessionViewData]> = Observable.just(publicSessionToDisplay)
        objArr.bind(to: tableView.rx.items(cellIdentifier: "PublicSessionCell")) {_, session, cell in
            cell.textLabel?.text = session.sessionName
        }.disposed(by: disposeBag)
    }
    
    private func didSelectItem() {
        self.tableView.rx.modelSelected(PublicSessionViewData.self).subscribe(onNext: { (session) in
            debugPrint(session.sessionName)
        }, onError: { (error) in
            debugPrint(error.localizedDescription)
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}

extension PublicSessionViewController: PublicSessionView {
    
    func startLoading() {
    }
      
    func finishLoading() {
    }
    
    func setPublicSession(session: [PublicSessionViewData]) {
        publicSessionToDisplay = session
        tableView.isHidden = false
        bindData()
        didSelectItem()
        tableView.reloadData()
    }
    
    func setEmptyPublicSession() {
        tableView.isHidden = true
    }
}
