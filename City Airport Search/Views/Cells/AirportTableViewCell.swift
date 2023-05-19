//
//  AirportTableViewCell.swift
//  City Airport Search
//
//  Created by Sonic on 19/5/23.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(using viewModel: AirportViewPresentable) {
        airportNameLabel.text = viewModel.name
        distanceLabel.text = viewModel.formattedDistance
        countryLabel.text = viewModel.address
        lengthLabel.text = viewModel.runwayLength
        self.selectionStyle = .none
    }
}
