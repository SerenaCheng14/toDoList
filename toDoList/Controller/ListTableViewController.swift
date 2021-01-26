//
//  ListTableViewController.swift
//  toDoList
//
//  Created by Serena on 2021/1/18.
//

import UIKit
import Firebase
import FirebaseAuth

class ListTableViewController: UITableViewController {
    
    var lists = [ResponseData.Record]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLists()
        
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC"){
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true, completion: nil)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchLists() {
        if let Key = Bundle.main.object(forInfoDictionaryKey: "AirTableApiKey"), let url = URL(string: "https://api.airtable.com/v0/appBMROjFH8zIPAcb/list?sort[0][field]=complete&sort[0][direction]=desc&sort[1][field]=deadline&sort[1][direction]=desc&sort[2][field]=priority&sort[2][direction]=desc") {
            var request = URLRequest(url: url)
            request.setValue("Bearer \(Key)", forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data,
                   let content = String(data: data, encoding: .utf8) {
                    let decoder = JSONDecoder()
                    do {
                        print(content)
                        let result = try decoder.decode(ResponseData.self, from: data)
                        self.lists = result.records
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("length of list : ", lists.count)
        return lists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListTableViewCell
        let list = lists[indexPath.row]
        
        cell.titleLabel.text = list.fields.title
        cell.deadlineLabel.text = list.fields.deadline
        
        if list.fields.priority == "0" {
            let image = UIImage(named: "low.jpg")
            cell.priorityView.image = image
        } else if list.fields.priority == "1"{
            let image = UIImage(named: "medium.jpg")
            cell.priorityView.image = image
        } else if list.fields.priority == "2"{
            let image = UIImage(named: "high.jpg")
            cell.priorityView.image = image
        }
        
        switch list.fields.complete {
        case "1":
            let image = UIImage(named: "completed.jpg")
            cell.completeView.image = image
        default:
            break
        }
       
        
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    @IBAction func unwindToListTableView(_ unwindSegue: UIStoryboardSegue) {
        print("press done")
        if let source = unwindSegue.source as? DetailTableViewController,
           let detail = source.detail {
            print(detail)
            let responseData = ResponseData.Record(fields: .init(complete: detail.complete, note: detail.note, title: detail.title, deadline: detail.deadline, priority: detail.priority))
            print("creatLists")
            creatLists(responseData: ResponseData(records: [responseData]))
            fetchLists()
//            lists.insert(responseData, at: 0)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
            
        }
    }
    
    func creatLists(responseData:ResponseData){
        
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: "AirTableApiKey"),
           let url = URL(string: "https://api.airtable.com/v0/appBMROjFH8zIPAcb/list") {
            
            var request = URLRequest(url: url)
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let encoder = JSONEncoder()
            print(responseData)
            request.httpBody = try? encoder.encode(responseData)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data,
                   let content = String(data: data, encoding: .utf8) {
                    print(content)
                }
            }.resume()
        }
    }
    
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


