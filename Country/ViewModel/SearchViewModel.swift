//
//  SearchViewModel.swift
//  Country
//
//  Created by Quyen Trinh on 5/10/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import ObjectMapper

enum CATEGORY : Int {
    case all = 0
    case name
    case capital
    case currency
    case region
}

class SearchViewModel {
    let bag = DisposeBag()
    
    // MARK: - Input
    
    // MARK: - Output
    var countryList : Variable<[Country]>
    
    var searchText : Variable<String?>
    
    var isLoading :Variable<Bool>
    
    var category : Variable<CATEGORY>
    
    init() {
        countryList = Variable<[Country]>([])
        searchText = Variable<String?>("")
        isLoading = Variable<Bool>(false)
        category = Variable<CATEGORY>(.all)
        
        bindOutPut()
    }
    
    
    func bindOutPut() {
    
        searchText
            .asObservable()
            .flatMap{ [weak self] value -> PrimitiveSequence<SingleTrait, Response> in
                self?.isLoading.value = true
                return (self?.searchCountry(withKey: value!))!
            }.subscribe(onNext: { [weak self] response in
                self?.isLoading.value = false
                guard let data = self?.dataFromResponse(response) else {
                    self?.countryList.value.removeAll()
                    return
                }
                self?.countryList.value = data
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    //MARK: - Help
    
    func dataFromResponse(_ response : Response) -> [Country]? {
        let json = try? response.mapJSON()
        guard let countries = json as? Array<[String: Any]> else {return nil}
        var result = Array<Country>()
        for country in countries {
            let _country = Country(JSON: country)
            result.append(_country!)
        }
        return result
    }
    
    
    func searchCountry(withKey key: String) -> Single<Response> {
        if key.count == 0 {
            return APIProvider.shared.getAllCountry()
        }
        switch self.category.value {
            case .all:
                return APIProvider.shared.getAllCountry()
            case .name:
                return APIProvider.shared.getCountryByName(key)
            case .capital:
                return APIProvider.shared.getCountryByCapital(key)
            case .currency:
                return APIProvider.shared.getCountryByCurrency(key)
            case .region:
                return APIProvider.shared.getCountryByRegion(key)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
