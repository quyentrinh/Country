//
//  CountryCell.swift
//  Country
//
//  Created by Quyen Trinh on 5/10/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var imvFlag: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhoneCode: UILabel!
    
    var country: Country! {
        didSet {
            if let _country = country {
                lblName.text = _country.name
                if let phoneCode = _country.callingCodes?.first {
                    lblPhoneCode.text = phoneCode.count == 0 ? "" : "+\(phoneCode)"
                }
                if let flag = Utilities.image(forCountryCode: _country.alpha2Code) {
                    imvFlag.image = flag
                }
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
