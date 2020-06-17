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
    
    @IBAction func onClickNextButton(_ sender: UIButton){
        self.currentPage += 1
        if self.currentPage == self.dateOfMeasurement.count - 1 {
            self.NextButt.isEnabled = false
        }
        
        self.PrevButt.isEnabled = true
        self.updateUIData(self.currentPage)
    }
    
    @IBAction func onClickPrevButt(_ sender: Any){
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
        let url = URL(string: "https://www.metaweather.com/api/location/search/?query=Warsaw")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in guard let data = data else {return}
            
            let json_ = try? JSONSerialization.jsonObject(with: data, options: [])
            let unwrap_json = json_!
            let array_json = unwrap_json as! [Any]
            let casted_json = array_json[0] as! [String:Any]
            
            let woeid = String((casted_json["woeid"] as! Int))
            let url_for_city = URL(string: "https://www.metaweather.com/api/location/" + woeid)!
            
            let locTask = URLSession.shared.dataTask(with: url_for_city){(data,response,error) in guard let data = data else {return}
                let jsonRs = try? JSONSerialization.jsonObject(with: data, options: [])
            
                let un_json = jsonRs!
                let cast_json = un_json as! [String:Any]
            
                let weather = cast_json["consolidated_weather"]!
                let weather_ = weather as! [Any]
            
                DispatchQueue.main.async {
                    self.dateOfMeasurement = weather_ as! [[String:Any]]
                    self.updateUIData(0)
                
                }
            }
            locTask.resume()
        }
        task.resume()
    }
    
    
    func updateUIData(_ pageNumber: Int){
        if (pageNumber < self.dateOfMeasurement.count && pageNumber >= 0){
            let day = self.dateOfMeasurement[pageNumber]
            
            self.Location.text = "Warsaw"
            self.Date.text = (day["applicable_date"] as! String)
            self.Status.text = (day["weather_state_name"] as! String)
            self.WindDir.text = (day["wind_direction_compass"] as! String)
            self.Preasure.text = (NSString(format: "%.1f", (day["air_pressure"] as! Double))as String) + " mbar"
            self.MinTemp.text = (NSString(format: "%.1f", (day["min_temp"] as! Double))as String) + " C"
            self.MaxTemp.text = (NSString(format: "%.1f", (day["max_temp"] as! Double))as String) + " C"
            self.WindSpeed.text = (NSString(format: "%.1f", (day["wind_speed"] as! Double))as String) + " mph"
            self.Rain.text = (NSString(format: "%.1f", (day["humidity"] as! Double))as String) + " %"

            let url = URL(string: "https://www.metaweather.com/static/img/weather/png/" + (day["weather_state_abbr"] as! String) + ".png")
            
            let session = URLSession.shared.dataTask(with: url!, completionHandler: {data, response, error in DispatchQueue.main.async {
                guard let data = data else {return}
                
                self.WeatherImg.image = UIImage(data: data)
                }})
            session.resume()
        }
    }
    
}


