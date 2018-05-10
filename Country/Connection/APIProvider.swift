//
//  APIProvider.swift
//  Country
//
//  Created by Quyen Trinh on 5/10/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa


private let API_KEY = "BnYZCJ27tYmshELogTZ7VlBkXBdgp18Hb1PjsnYmaWPelcA1Ea"

class APIProvider {
    static let shared = APIProvider()
    
    let provider : MoyaProvider<MashapeService>
    
    private init() {
        provider = MoyaProvider<MashapeService>()
    }
    
    //MARK: -Public method
    
    func getAllCountry() -> Single<Response> {
        return provider.rx.request(.all)
    }
    
    func getCountryByName(_ name: String) -> Single<Response> {
        return provider.rx.request(.name(name))
    }
    
    func getCountryByCapital(_ capital: String) -> Single<Response> {
        return provider.rx.request(.capital(capital))
    }
    
    func getCountryByCurrency(_ currency: String) -> Single<Response> {
        return provider.rx.request(.currency(currency))
    }
    
    func getCountryByRegion(_ region: String) -> Single<Response> {
        return provider.rx.request(.region(region))
    }
}


enum MashapeService {
    case all                                            //https://restcountries-v1.p.mashape.com/all
    case name(_ : String)                               //https://restcountries-v1.p.mashape.com/name/{name}
    case capital(_ : String)                            //https://restcountries-v1.p.mashape.com/capital/{capital}
    case currency(_ : String)                           //https://restcountries-v1.p.mashape.com/currency/{currency}
    case region(_ : String)                             //https://restcountries-v1.p.mashape.com/region/{region}
}

extension MashapeService : TargetType {
    var baseURL: URL {
        return URL(string: "https://restcountries-v1.p.mashape.com")!
    }
    
    var path: String {
        switch self {
        case .all:
            return "/all"
        case .name(let value):
            return "/name/\(value)"
        case .capital(let value):
            return "/capital/\(value)"
        case .currency(let value):
            return "/currency/\(value)"
        case .region(let value):
            return "/region/\(value)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "SampleData".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["X-Mashape-Key": API_KEY, "Accept": "application/json"]
    }
    
    
}
