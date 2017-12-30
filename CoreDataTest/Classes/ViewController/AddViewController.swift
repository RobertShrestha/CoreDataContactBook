//
//  AddViewController.swift
//  CoreDataTest
//
//  Created by Robert Shrestha on 12/28/17.
//  Copyright © 2017 robert. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var phoneTxtField: UITextField!
    @IBOutlet var nameTxtField: UITextField!
    var listViewModel = ListViewModel()
    var incomingUser:User? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newUser = incomingUser{
        self.nameTxtField.text = newUser.name
        self.phoneTxtField.text = String(newUser.phone)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        if let newUser = incomingUser{
            newUser.name = self.nameTxtField.text!
            newUser.phone = Int64(self.phoneTxtField.text!)!
            self.listViewModel.updateData(user: newUser)
            self.navigationController?.popViewController(animated: true)
        }else{
            if (phoneTxtField.text?.characters.count)! > 0 && (nameTxtField.text?.characters.count)! > 0{
                listViewModel.createData(name:nameTxtField.text!,phone: phoneTxtField.text!)
                self.navigationController?.popViewController(animated: true)
            }else{
                let alert = UIAlertController(title: "Error", message: "Please enter required field", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }



}
