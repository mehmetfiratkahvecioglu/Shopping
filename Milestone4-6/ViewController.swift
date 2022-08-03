//
//  ViewController.swift
//  Milestone4-6
//
//  Created by Fırat Kahvecioğlu on 3.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet var tableView: UITableView!
    var shopList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shop List"
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
     let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItems = [shareButton,addButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func share()  {
        let text = shopList.joined(separator:"\n")
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func refreshData(){
        shopList.removeAll()
        tableView.reloadData()
        
    }
    
    @objc func addItem(){
        
        let addItemAlert = UIAlertController(title: "Add Item", message: "Add some stuff", preferredStyle: .alert)
        
        addItemAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: {  [weak self,weak addItemAlert] (_) in
            let textField = addItemAlert?.textFields![0] // Force unwrapping because we know it exists.
            
            guard let item = textField?.text else{
            return
            }
            
            self?.submit(item)
            
            
            
            
            
        }))
        addItemAlert.addAction(.init(title: "Cancel", style: .destructive, handler: nil))
        
        addItemAlert.addTextField(configurationHandler: nil)
        
        self.present(addItemAlert, animated: true, completion: nil)
        
        
    }
    
    func submit(_ item: String) {
           let item = item
           shopList.insert(item, at: 0)
           let indexPath = IndexPath(row: 0, section: 0)
           tableView.insertRows(at: [indexPath], with: .automatic)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        cell.textLabel?.text = shopList[indexPath.row]
        
        return cell
        
    }
    


}

