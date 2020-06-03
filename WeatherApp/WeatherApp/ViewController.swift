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
    
    @IBOutlet weak var WeatherTable: UITableView!
    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var WeatherImg: UIImageView!
    @IBOutlet weak var Date: UITextField!
    
    var url : URL!
    var dataTask : URLSessionDataTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadWeather()
        updateUIData()
    }
    
    func downloadWeather(){
        
    }
    
    func updateUIData(){
        
    }
    
}


