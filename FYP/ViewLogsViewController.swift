//
//  ViewLogsViewController.swift
//  FYP
//
//  Created by Sandeep Walia on 03/02/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit

class ViewLogsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list = ["Milk", "Cheese", "Bread"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as! ViewLogsViewControllerTableViewCell
        
        let row = indexPath.row
        let task = self.list[row]
        
        cell.date.text = task
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
