//
//  LocalDataSource.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/01.
//

import Foundation


class LocalDataSource {
    func seveCoordinate(city: String, lat: Double, lon: Double) {
        UserDefaults.standard.set([lat, lon], forKey: city)
    }
    
    func loadCoordinate(city: String) -> [Double] {
        return (UserDefaults.standard.value(forKey: city) as? [Double]) ?? []
    }
}
