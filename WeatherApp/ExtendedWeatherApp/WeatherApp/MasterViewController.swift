//
//  MasterViewController.swift
//  ExtendedWeatherApp
//
//  Created by Student on 17/06/2020.
//  Copyright © 2020 Zuzanna Smiech. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var locationList = [
        ("Osaka", "15015370"),
    ("Hudston", "2424766"),
    ("Moscow", "2122265")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        // Configure the cell...
        cell.tag = indexPath.row
        cell.detailTextLabel?.text = "12C"
        cell.textLabel?.text = locationList[indexPath.row].0
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
    //override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
       // return true
    //}
    

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
