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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

   

    
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
