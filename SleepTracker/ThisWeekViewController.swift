//
//  ViewController.swift
//  SleepTracker
//
//  Created by Sebastian Lopez on 4/28/21.
//

import UIKit

class ThisWeekViewController: UITableViewController {

    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //will eventually put 7 for a week worth of cells
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SleepItem", for: indexPath)
        return cell
    }

}

