//
//  NewEntryViewController.swift
//  SleepTracker
//
//  Created by Sebastian Lopez on 5/7/21.
//

import UIKit

class NewEntryViewController: UITableViewController {
    
    var totalSleepQualityPercentage: Int?
    
    var moods = ["very good", "energetic", "normal", "sad", "drowsy"]
    var moodSelected: String = "none"
    let longings = ["no delay", "15 mins", "30 mins", "1hr", "2 hrs or more"]
    var longingSelected: String = "none"
    
    
    @IBOutlet weak var sleepHours: UITextField!
    @IBOutlet weak var snoringToggle: UISwitch!
    @IBOutlet weak var moodPickerView: UIPickerView!
    @IBOutlet weak var midnightWakes: UITextField!
    @IBOutlet weak var longingPickerView: UIPickerView!
    
    
    @IBOutlet weak var logDate: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        moodPickerView.delegate = self
        moodPickerView.dataSource = self
        
        longingPickerView.delegate = self
        longingPickerView.dataSource = self
        
        
        
    }

    // MARK: - Table view data source
    
    
    
    
    func calcLongingScore() -> Double{
        var totalLonging: Int
        if longingSelected == "no delay"{
            totalLonging = 10
        }else if longingSelected == "15 mins"{
            totalLonging = 8
        }else if longingSelected == "30 mins"{
            totalLonging = 6
        }else if longingSelected == "1 hr"{
            totalLonging = 4
        }else if longingSelected == "2 hrs"{
            totalLonging = 2
        }else{
            totalLonging = 0
        }
        return Double(totalLonging) * 0.2
    }
 
    
    func calcMidwakeScore() -> Double{
        let wakeAmount: String = midnightWakes.text!
        let conve = Int(wakeAmount) ?? 0
        var totalMidwakeScore: Int
        
        if conve <= 1{
            totalMidwakeScore = 10
        }else if 2...3 ~= conve{
            totalMidwakeScore = 5
        }else{
            totalMidwakeScore = 3
        }
        return Double(totalMidwakeScore) * 0.2// pls delete
    }
    
    func calcMoodScore() -> Double{
        var totalMood: Int
        if moodSelected == "very good"{
            totalMood = 10
        }else if moodSelected == "energetic"{
            totalMood = 8
        }else if moodSelected == "normal"{
            totalMood = 6
        }else if moodSelected == "sad"{
            totalMood = 4
        }else if moodSelected == "drowsy"{
            totalMood = 2
        }else{
            totalMood = 0
        }
        return Double(totalMood) * 0.4
    }
    func calcSnoringScore() -> Double{
        var totalSnoring: Int
        if snoringToggle.isOn{
            totalSnoring = 0
        }else{
            totalSnoring = 10
        }
        return Double(totalSnoring) * 0.1
    }
    
    func calcHoursScore() -> Double{
        let hoursSlept: String = sleepHours.text!
        let conv = Int(hoursSlept) ?? 0
        var totalSleepScore: Int

        if 9...10 ~= conv{
            totalSleepScore = 10
        }else if 7...8 ~= conv{
            totalSleepScore = 8
        }else if 5...7 ~= conv{
            totalSleepScore = 6
        }else if 3...5 ~= conv{
            totalSleepScore = 4
        }else if conv < 3{
            totalSleepScore = 2
        }else{
            totalSleepScore = 0
        }
        return Double(totalSleepScore) * 0.1
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let add = calcHoursScore() + calcSnoringScore() + calcMoodScore() + calcLongingScore() + calcMidwakeScore()
        totalSleepQualityPercentage = Int(add * 10)
        
        let destVC = segue.destination as! ThisWeekViewController
        destVC.totalSleep = totalSleepQualityPercentage!
        
        //temp!
        let formatter = DateFormatter()
        formatter.calendar = logDate.calendar
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: logDate.date)
        destVC.totalDate = dateString
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewEntryViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return moods.count
        }else{
            return longings.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return moods[row]
        }else{
            return longings[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            moodSelected = moods[row]
        }else{
            longingSelected = longings[row]
        }
        
    }
    
}
