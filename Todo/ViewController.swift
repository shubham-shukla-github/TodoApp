//
//  ViewController.swift
//  Todo
//
//  Created by Shubham Shukla on 25/06/23.
//

import UIKit

class ViewController: UIViewController {

    
    var items = [Item]()
    let defaults = UserDefaults.standard
  
    let fileToWrite = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   

  
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        loadData()
      
    }
    func  loadData (){
        do{
            let data = try Data(contentsOf: fileToWrite!)
            
            let decoder = PropertyListDecoder()
            items = try decoder.decode([Item].self, from: data)
//            tableView.reloadData()
        }
       catch
        {
           print("error getting data")
        }
        
       
    
    }
    @IBAction func addTodo(_ sender: UIBarButtonItem) {
        var textFeild  = UITextField()
        let alert  = UIAlertController(title: "Add Todo", message: nil, preferredStyle: .alert)

        let action  = UIAlertAction(title: "Add", style: .default) { [self] action in
         
            print("action in swift")
            print(textFeild.text!)
            let newItem  = Item(t : textFeild.text! , d: false)
            self.items.append(newItem)
            
            self.saveItems()
        }
        alert.addAction(action)
        alert.addTextField { feild in
            feild.placeholder  = "add feild"
            textFeild = feild
            
           
        }
        present(alert, animated: true)
    }
    func saveItems(){
        let encoder = PropertyListEncoder()
          do{
              let data =  try encoder.encode(self.items)
              try data.write(to: fileToWrite!)
              
          }
          catch {
              print("caught some error")
          }
          self.tableView.reloadData()
    }
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].task
        cell.accessoryType = items[indexPath.row].done == true ? .checkmark : .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row \(indexPath.row)")

        items[indexPath.row].done = !items[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
 
    
}
