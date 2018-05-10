//
//  DetailViewModel.swift
//  Country
//
//  Created by Quyen Trinh on 5/10/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailViewModel {

    var country : Variable<Country>
    
    init(_country: Variable<Country>) {
        self.country = _country
    }
    
}
