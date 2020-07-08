//
//  ViewController.swift
//  WeatherApp
//
//  Created by Student on 27/05/2020.
//  Copyright © 2020 Zuzanna Smiech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Author_data: UITextField!
    @IBOutlet weak var WeatherImg: UIImageView!
    //dane pogodowe
    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var Date: UITextField!
    @IBOutlet weak var Status: UITextField!
    @IBOutlet weak var MinTemp: UITextField!
    @IBOutlet weak var MaxTemp: UITextField!
    @IBOutlet weak var Rain: UITextField!
    @IBOutlet weak var WindDir: UITextField!
    @IBOutlet weak var WindSpeed: UITextField!
    @IBOutlet weak var Preasure: UITextField!
    
    @IBOutlet weak var NextButt: UIButton!
    @IBOutlet weak var PrevButt: UIButton!
    var currentPage : Int = 0
    var dateOfMeasurement: [[String:Any]] = []
    
    @IBAction func NextDay(_ sender: UIButton){
        self.currentPage += 1
        if self.currentPage == self.dateOfMeasurement.count - 1 {
            self.NextButt.isEnabled = false
        }
        
        self.PrevButt.isEnabled = true
        self.updateUIData(self.currentPage)
    }
    
    @IBAction func PrevDay(_ sender: Any){
        self.currentPage -= 1
        if self.currentPage == 0 {
            self.PrevButt.isEnabled = false
        }
        
        self.NextButt.isEnabled = true
        self.updateUIData(self.currentPage)    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //downloadWeather()
        //updateUIData()
        let getCityUrl = URL(string: "https://www.metaweather.com/api/location/search/?query=Warsaw")!
        let getCityID = URLSession.shared.dataTask(with: getCityUrl) {(data, response, error) in guard let data = data else {return}
            
            let jsonLocation = try? JSONSerialization.jsonObject(with: data, options: [])
            let dictLocation = ((jsonLocation!) as! [Any])[0] as! [String:Any]
            
            let woeid = String((dictLocation["woeid"] as! Int))
            let getWeatherFromCityID = URL(string: "https://www.metaweather.com/api/location/" + woeid)!
            
            let getWeatherDetails = URLSession.shared.dataTask(with: getWeatherFromCityID){(data,response,error) in guard let data = data else {return}
                let allJsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
            
                let weather = (((allJsonResponse!) as! [String:Any])["consolidated_weather"]) as! [Any]
            
                DispatchQueue.main.async {
                    self.dateOfMeasurement = weather as! [[String:Any]]
                    self.updateUIData(0)
                
                }
            }
            getWeatherDetails.resume()
        }
        getCityID.resume()
    }
    
    
    func updateUIData(_ pageNumber: Int){
        if (pageNumber < self.dateOfMeasurement.count ){
            let currentDay = self.dateOfMeasurement[pageNumber]
            
            self.Location.text = "Warsaw"
            self.Date.text = (currentDay["applicable_date"] as! String)
            self.Status.text = (currentDay["weather_state_name"] as! String)
            self.WindDir.text = (currentDay["wind_direction_compass"] as! String)
            self.Preasure.text = (NSString(format: "%.1f", (currentDay["air_pressure"] as! Double))as String) + " mbar"
            self.MinTemp.text = (NSString(format: "%.1f", (currentDay["min_temp"] as! Double))as String) + " C"
            self.MaxTemp.text = (NSString(format: "%.1f", (currentDay["max_temp"] as! Double))as String) + " C"
            self.WindSpeed.text = (NSString(format: "%.1f", (currentDay["wind_speed"] as! Double))as String) + " mph"
            self.Rain.text = (NSString(format: "%.1f", (currentDay["humidity"] as! Double))as String) + " %"

            let pngUrl = URL(string: "https://www.metaweather.com/static/img/weather/png/" + (currentDay["weather_state_abbr"] as! String) + ".png")
            
            let getImage = URLSession.shared.dataTask(with: pngUrl!, completionHandler: {data, response, error in DispatchQueue.main.async {
                guard let data = data else {return}
                
                self.WeatherImg.image = UIImage(data: data)
                }})
            getImage.resume()
        }
    }
    
}


