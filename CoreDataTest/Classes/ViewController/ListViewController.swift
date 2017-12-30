//
//  ListViewController.swift
//  CoreDataTest
//
//  Created by Robert Shrestha on 12/28/17.
//  Copyright © 2017 robert. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableview:UITableView!
    var users = [User]()
    var listViewModel = ListViewModel()
    override func viewWillAppear(_ animated: Bool) {
        //Load the data
        fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func trashBtnPressed(_ sender: Any) {
        self.listViewModel.resetAllRecords(in: "User")
        fetchData()
    }
    func reload(){
        self.tableview.reloadData()
    }
    func fetchData(){
        self.listViewModel.fetchData(completion: {(msg,status,error) in
            if error == nil{
                self.reload()
            }else{
                
            }
            
        })
    }
    
}
extension ListViewController:UITableViewDelegate,UITableViewDataSource{
    
    //MARK: - TableView Delegate and Data Source Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return listViewModel.listViewNumberOfSection()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the row is \(self.listViewModel.listViewNumberOfRowInSection())")
        return listViewModel.listViewNumberOfRowInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        configureCell(cell: cell, forRowAtIndexPath: indexPath)
        return cell
    }
    func configureCell(cell: UITableViewCell, forRowAtIndexPath indexPath:IndexPath){
        cell.textLabel?.text = self.listViewModel.userNameForItemAtIndexPath(indexPath: indexPath)
        cell.detailTextLabel?.text = self.listViewModel.phoneForItemAtIndexPath(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.listViewModel.deleteData(user: self.listViewModel.userForItemAtIndexPath(indexPath: indexPath))
            fetchData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        vc.incomingUser = self.listViewModel.userForItemAtIndexPath(indexPath: indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
