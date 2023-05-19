//
//  SearchCityViewController.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit
import RxSwift
import RxDataSources

class SearchCityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var contentSearchView: UIView!{
        didSet {
            contentSearchView.backgroundColor = UIColor.primaryColor
        }
    }
    
    var viewModelBuilder: SearchCityViewModelPresentable.ViewModelBuilder!
    private let bag = DisposeBag()
    private var viewModel: SearchCityViewModelPresentable!
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<CityItemsSection> { _, tableView, indexPath, item in
        let cityCell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        cityCell.configure(using: item)
        return cityCell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = viewModelBuilder((
            searchText: searchTextField.rx.text.orEmpty.asDriver(),
            citySelect: tableView.rx.modelSelected(CityViewModel.self).asDriver()
        ))
        setupUI()
        setupBinding()
    }
}

private extension SearchCityViewController {
    func setupUI() {
        tableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        self.title = "Airports"
    }
    
    func setupBinding() {
        viewModel.output?.cities
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}

