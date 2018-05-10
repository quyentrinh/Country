//
//  SearchViewController.swift
//  Country
//
//  Created by Quyen Trinh on 5/10/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WSProgressHUD

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var searchController : UISearchController?
    
    fileprivate let bag = DisposeBag()
    var viewModel : SearchViewModel!
    
    var category : CATEGORY = .name
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
        
        bindUI()
        
        // fetching data
        searchController?.searchBar.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.tintColor = UIColor(red: 242.0/255.0, green: 37.0/255.0, blue: 90.0/255.0, alpha: 1.0)
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search Countries"
        
        searchController?.searchBar.scopeButtonTitles = ["Name", "Capital", "Currency", "Region"]
        searchController?.searchBar.delegate = self
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    func bindUI() {
        viewModel.isLoading
            .asObservable()
            .subscribe(onNext: { flag in
                if (flag) {
                    WSProgressHUD.show()
                } else {
                    WSProgressHUD.dismiss()
                }
            }).disposed(by: bag)
        
        viewModel
            .countryList
            .asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, event in
                let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
                cell.country = self?.viewModel.countryList.value[index]
                return cell
            }
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(Country.self)
            .subscribe(onNext: { [weak self] model in
                let detailVC = self?.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                let viewModel = DetailViewModel(_country: Variable(model))
                detailVC.viewModel = viewModel
                self?.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: bag)
        
        searchController?.searchBar.rx
            .text
            .map{ searchKey in
                return (self.category, searchKey)
            }
            .bind(to: viewModel.searchTuple)
            .disposed(by: bag)
        
        searchController?.searchBar.rx
            .cancelButtonClicked
            .map{ return (.all, "") }
            .bind(to: viewModel.searchTuple)
            .disposed(by: bag)
        
    }

}

extension SearchViewController : UISearchBarDelegate {    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.category = CATEGORY(rawValue: selectedScope)!
        viewModel.searchTuple.value = (self.category, searchBar.text)
    }
}











