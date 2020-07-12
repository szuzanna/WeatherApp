//
//  MasterViewController.swift
//  ExtendedWeatherApp
//
//  Created by Student on 17/06/2020.
//  Copyright © 2020 Zuzanna Smiech. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    var locationList = [
        ("London", "44418",[]),
    ("San Francisco", "2487956",[]),
    ("Moscow", "2122265",[])
    ]
    var flag:Int! = 0
    var weatherToDisp:[(String,String)] = []
    var dateOfMeasurement: [[String:Any]] = []
    //var managedObjectContext: NSManagedObjectContext? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let group1 = DispatchGroup()
        //group1.enter()
        //DispatchQueue.main.async {
            self.fromIDGetWether()
            //group1.leave()
        //}
            //if self.flag != tmp{
        //group1.notify(queue: .main) {
            //self.flag = 1
            //self.tableView.reloadData()
                //self.flag = tmp
            //}
        //}
        //fromIDGetWether()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func fromIDGetWether(){
        //let group2 = DispatchGroup()
        //group2.enter()
        for location in self.locationList{
            let getWeatherFromCityID = URL(string: "https://www.metaweather.com/api/location/" + location.1)!
            
            let getWeatherDetails = URLSession.shared.dataTask(with: getWeatherFromCityID){data,response,error in guard let data = data else {return}
            let allJsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
                
            let weather = (((allJsonResponse!) as! [String:Any])["consolidated_weather"]) as! [Any]
                //group2.enter()
                DispatchQueue.main.async() {
                    self.dateOfMeasurement = weather as! [[String:Any]]
                    self.weatherToDisp.append(((NSString(format: "%.1f", (self.dateOfMeasurement[0]["the_temp"] as! Double))as String), self.dateOfMeasurement[0]["weather_state_abbr"] as! String))
                    self.tableView.reloadData()
                    self.flag += 1
                    //return 1
                    //group2.leave()
                }
            }
            getWeatherDetails.resume()
        }
        
        //group2.notify(queue: .global){
        //group2.wait()
        
       // }
        //return nil
    }
    
    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locationList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cellIdentifier = "City"
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath) 
        let pngUrl : URL!
        // Configure the cell...
        cell.tag = indexPath.row
        
        cell.textLabel?.text = locationList[indexPath.row].0
        if flag != self.locationList.count {
            cell.detailTextLabel?.text = "0"
            pngUrl = URL(string: "https://www.metaweather.com/static/img/weather/ico/c.ico")!
        }else {
            cell.detailTextLabel?.text = weatherToDisp[indexPath.row].0
            pngUrl = URL(string: "https://www.metaweather.com/static/img/weather/ico/" + weatherToDisp[indexPath.row].1 + ".ico" )!
        }
        
        let getImage = URLSession.shared.dataTask(with: pngUrl!, completionHandler: {data, response, error in DispatchQueue.main.async {
            guard let data = data else {return}
            cell.imageView!.image = UIImage(data: data)
            }})
        getImage.resume()
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedLocation = locationList[indexPath.row].0
        let locationId = locationList[indexPath.row].1
        
        performSegue(withIdentifier: "switchToWeather ", sender: <#Any?#>)
    }
 */
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){//UITableViewCell) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        /*if segue.destination is LocationWeatherController{
            if sender is UITableViewCell{
                let next_vc = segue.destination as? LocationWeatherController
                next_vc?.id = sender as! String//locationList[UITableViewCell(sender!).tag].1 ?? "15015370"
                //next_vc?.city = locationList[sender.tag].0
            }
        }*/
        if let next_vc = segue.destination as? LocationWeatherController{
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
                //let next_vc = segue.destination as? LocationWeatherController
                next_vc.id = locationList[indexPath.row].1
                next_vc.city = locationList[indexPath.row].0//sender as! String//locationList[UITableViewCell(sender!).tag].1 ?? "15015370"
                //next_vc?.city = locationList[sender.tag].0
            }
        }

    }
    

}
