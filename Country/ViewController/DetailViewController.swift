//
//  DetailViewController.swift
//  Country
//
//  Created by Quyen Trinh on 5/10/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    fileprivate let bag = DisposeBag()
    var viewModel : DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func bindUI() {
        viewModel
            .country
            .asObservable()
            .map {$0.name}
            .subscribe(onNext: { [weak self] value in
                self?.navigationItem.title = value
            })
            .disposed(by: bag)
    }

}
