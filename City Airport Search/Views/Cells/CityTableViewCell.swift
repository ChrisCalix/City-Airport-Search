//
//  CityTableViewCell.swift
//  City Airport Search
//
//  Created by Sonic on 18/5/23.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(using viewModel: CityViewPresentable) {
        cityLabel.text = viewModel.city
        locationLabel.text = viewModel.location
    }
    
}
