//
//  HomeViewController.swift
//  weather-app
//
//  Created by ios.kwon on 2023/06/01.
//

import UIKit
import ReactorKit
import SnapKit
import RxDataSources
import Reusable
import SnapKit

class HomeViewController: UIViewController, StoryboardView {
    
    // MARK: - Outlets
    
    let contentTable: UITableView! = {
        let table = UITableView()
        return table
    }()
    
    
    
    // MARK: - Properties
    
    typealias Reactor = HomeViewReactor
    
    var disposeBag = DisposeBag()
    
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setLayout()
    }

    
    
    // MARK: - Bindings
    
    func bind(reactor: HomeViewReactor) {
        reactor.state.map { $0.datas }
            .filter { !$0.isEmpty }
            .subscribe (onNext: { datas in
                print(" 🙈 [HomeViewModel - fetch] success! \n \(datas)")
            })
            .disposed(by: disposeBag)
    }
    
    
    
    // MARK: - Mothods

    private func setLayout() {
        self.view.addSubview(contentTable)
        contentTable.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
}

