//
//  File.swift
//  ExtendedWeatherApp
//
//  Created by Student on 08/07/2020.
//  Copyright © 2020 Zuzanna Smiech. All rights reserved.
//

import Foundation

class UploadeWeather {
    
    func getWeatherForLocation(locationId: String, cb: @escaping (_: [Any])-> Void){
        let url = URL(string: "https://www.metaweather.com/api/location/" + locationId)!
    
        let urlSession = URLSession.shared.dataTask(with: url){(data,response,error) in guard let data = data else {return}
            let allJsonResponse = try? JSONSerialization.jsonObject(with:data, options: [])
            
            let weather = (((allJsonResponse!) as! [String: Any])["consolidated_weather"]) as! [Any]
            
            cb(_: weather)
        }
        urlSession.resume()
        
    }
    
    func getIdForRequestedLocation(){
        
    }
}
