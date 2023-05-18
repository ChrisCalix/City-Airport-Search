//
//  SearchCityViewController.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit
import RxSwift
import RxDataSources

final class SearchCityViewController: UIViewController, Storyboardable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentSearchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var viewModel: SearchCityViewModelPresentable!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

