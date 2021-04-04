//
//  Country.swift
//  IOS-Final-Assignment
//
//  Created by anthony Doss on 2021-03-28.
//

import Foundation

struct Country : Codable {
    
    public var country :String
    public var updated :Double
    public var cases :Double
    public var deaths :Double
    public var active :Double
    public var recovered :Double
  
    var countryInfo: CountryInfo
    
}

struct CountryInfo : Codable {
    
    public var _id :Int
    public var iso2 :String
    public var iso3 :String
    public var lat :Double
    public var long :Double
    public var flag :String
}
