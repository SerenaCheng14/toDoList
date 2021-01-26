//
//  DetailTableViewController.swift
//  toDoList
//
//  Created by Serena on 2021/1/23.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var detail: ResponseData.Field?
    
    
    
    @IBOutlet weak var completedSwitch: UISwitch!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var noteTextField: UITextField!
    
//    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM dd, YYYY"
//        let dateString = dateFormatter.string(from: sender.date)
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("prepare")
        var complete = ""
        if completedSwitch.isOn {
            complete = "1"
        } else {
            complete = "0"
        }
//        var priority = ""
//        switch prioritySegmentedControl.selectedSegmentIndex {
//        case 0:
//            priority = "0"
//        case 1:
//            priority = "1"
//        case 2:
//            priority = "2"
//        default:
//            break
//        }
        let priority = "\(prioritySegmentedControl.selectedSegmentIndex)"
        let title = titleTextField.text ?? ""
        let note = noteTextField.text ?? ""
//        let deadline = "\(UIDatePicker.self)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let deadline = dateFormatter.string(from: deadlineDatePicker.date)
        
        detail = ResponseData.Field(complete: complete, note: note, title: title, deadline: deadline, priority: priority)
        //        print(detail)
        print("prepare done")
        
        
        
    }
    
    

}
