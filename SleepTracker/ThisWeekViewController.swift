//
//  ViewController.swift
//  SleepTracker
//
//  Created by Sebastian Lopez on 4/28/21.
//

import UIKit

class ThisWeekViewController: UITableViewController {
    
    let vc = NewEntryViewController()
    var totalSleep = 0
    var totalDate = ""
    var totalEmoji = ""
    
    var cellDate: [String] = []
    var cellPercentage: [Int] = []
    var cellEmoji: [String] = []
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue){
        print("cancelled")
    }
    
    
    @IBAction func saveAndUnwind(_ sender: UIStoryboardSegue){
        cellPercentage.append(totalSleep)
        cellDate.append(totalDate)
        if 90...100 ~= totalSleep{
            totalEmoji = "π€©"
        }else if 80...90 ~= totalSleep{
            totalEmoji = "π"
        }else if 70...80 ~= totalSleep{
            totalEmoji = "βΊοΈ"
        }else if 60...70 ~= totalSleep{
            totalEmoji = "π"
        }else if 50...60 ~= totalSleep{
            totalEmoji = "π"
        }else if 40...50 ~= totalSleep{
            totalEmoji = "π"
        }else if 30...40 ~= totalSleep{
            totalEmoji = "π"
        }else if 20...30 ~= totalSleep{
            totalEmoji = "π"
        }else if 10...20 ~= totalSleep{
            totalEmoji = "π"
        }else{
            totalEmoji = "π₯±"
        }
        cellEmoji.append(totalEmoji)
        
        self.tableView.reloadData()
        
        //print(totalSleep, "%")
        
        //update cell with new append
        //or push to cell
        
        //retain the quality percentage and display it
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellPercentage.count //will eventually put 7 for a week worth of cells
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SleepItem", for: indexPath) as! CustomCell
        let friend = cellPercentage[indexPath.row]
        let finalSend1 = String(friend) + "%"
        let finalSend2 = cellDate[indexPath.row]
        let finalSend3 = cellEmoji[indexPath.row]
        
        cell.percentageLabel.text = finalSend1
        cell.dateLabel.text = finalSend2
        cell.emojiLabel.text = finalSend3
        return cell //just to display a cell
    }

}


