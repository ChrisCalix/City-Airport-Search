//
//  AirportsViewController.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AirportsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private var viewModel: AirportsViewPresentable!
    var viewModelBuilder: AirportsViewPresentable.viewModelBuilder!
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<AirportItemsSection> { _, tableView, indexPath, item in
        let airportCell = tableView.dequeueReusableCell(withIdentifier: AirportTableViewCell.identifier, for: indexPath) as! AirportTableViewCell
        airportCell.configure(using: item)
        return airportCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = viewModelBuilder(())
        setupUi()
        setupBinding()
    }
}

private extension AirportsViewController {
    func setupUi() {
        tableView.register(UINib(nibName: AirportTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AirportTableViewCell.identifier)
    }
    
    func setupBinding() {
        viewModel.output.airports
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        viewModel.output.title
            .drive(self.rx.title)
            .disposed(by: bag)
    }
}
