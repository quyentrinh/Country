//
//  Country.swift
//  Country
//
//  Created by Quyen Trinh on 5/10/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import ObjectMapper

class Country: Mappable {
    var name: String?
    var topLevelDomain: [String]?
    var alpha2Code: String?
    var alpha3Code: String?
    var callingCodes: [String]?
    var capital: String?
    var altSpellings: [String]?
    var region: String?
    var subregion: String?
    var population: Int = 0
    var latlng: [Double]!
    var demonym: String?
    var area: Double?
    var gini: Double?
    var timezones: [String]?
    var borders: [String]?
    var nativeName: String?
    var numericCode: String?
    var currencies: [String]?
    var languages: [String]?
    var translations: [String]?
    var relevance: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        topLevelDomain <- map["topLevelDomain"]
        alpha2Code <- map["alpha2Code"]
        alpha3Code <- map["alpha3Code"]
        callingCodes <- map["callingCodes"]
        capital <- map["capital"]
        altSpellings <- map["altSpellings"]
        region <- map["region"]
        subregion <- map["subregion"]
        population <- map["population"]
        latlng <- map["latlng"]
        demonym <- map["demonym"]
        area <- map["area"]
        gini <- map["gini"]
        timezones <- map["timezones"]
        borders <- map["borders"]
        nativeName <- map["nativeName"]
        numericCode <- map["numericCode"]
        currencies <- map["currencies"]
        languages <- map["languages"]
        translations <- map["translations"]
        relevance <- map["relevance"]
    }
    
}

