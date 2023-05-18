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
    @IBOutlet weak var contentSearchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var viewModel: SearchCityViewModelPresentable!
    var viewModilBuilder: SearchCityViewModelPresentable.ViewModelBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = viewModilBuilder((
            searchText: searchTextField.rx.text.orEmpty.asDriver(), ()
        ))
    }


}

