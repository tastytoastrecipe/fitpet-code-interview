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
import weathers_domain
import logger

class HomeViewController: UIViewController, StoryboardView {
    
    // MARK: - Outlets
    
    let contentTable: UITableView! = {
        let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.register(WeatherCell.self, forCellReuseIdentifier: String(describing: WeatherCell.self))
        table.rowHeight = WeatherCell.cellHeight
        return table
    }()
    
    
    
    // MARK: - Properties
    
    typealias Reactor = HomeViewReactor
    
    var disposeBag = DisposeBag()
    
    var dataSource: RxTableViewSectionedReloadDataSource<WeatherSection>!
    
    
    
    // MARK: - Life Cycles
    
    init() {
        super.init(nibName: nil, bundle: nil)
        bindTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
    }

    
    
    // MARK: - Bindings
    
    func bind(reactor: HomeViewReactor) {
        reactor.state.map { $0.datas }
            .filter { !$0.isEmpty }
            .bind(to: contentTable.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindTable() {
        dataSource = RxTableViewSectionedReloadDataSource<WeatherSection>(
            configureCell: { dataSource, tableView, indexPath, item in
                showLog(logType: .weather, title: "CELL", "\(item)")
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherCell.self), for: indexPath) as! WeatherCell
                cell.setContent(data: item)
                return cell
            })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
          return dataSource.sectionModels[index].header
        }
    }
    
    
    
    // MARK: - Mothods

    private func setLayout() {
        self.view.addSubview(contentTable)
        contentTable.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
}

