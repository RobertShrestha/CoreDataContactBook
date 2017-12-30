//
//  ListViewModel.swift
//  CoreDataTest
//
//  Created by Robert Shrestha on 12/28/17.
//  Copyright © 2017 robert. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ListViewModel:NSObject{
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users = [User]()
    
    //MARK: - Core Data Methods
    
    func fetchData(completion:@escaping (String?,Bool,_ error:NSError?)->()){
        do{
            try users = context.fetch(User.fetchRequest())
        }catch{
            print(error)
            completion("",false,error as NSError)
        }
        completion("",true,nil)
        //locationArray = locationArray.sorted(by: { $0.id < $1.id })
        //print(locationArray[1].id,locationArray[1].lat,locationArray[1].long)
//        for user in users{
//            print(user.name as Any)
//            
//        }
    }
    func searchData(searchString:String){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "name == %d",searchString)
        do{
            let result = try context.fetch(request)
            if result.count > 0{
                let name = (result[0] as AnyObject).value(forKey: "name") as! String
                //deleteData(location: result[0] as! Location)
                print("search result is \(name)")
            }else{
                print("EMpty")
            }
        }catch{
            print(error)
        }
        
    }
    func deleteData(user:User){
        context.delete(user)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func resetAllRecords(in entity : String)
    {
        
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    func createData(name:String,phone:String){
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        print(phone)
        newUser.setValue(name, forKey: "name")
        newUser.setValue(Int64(phone), forKey: "phone")
        do{
            try context.save()
        }
        catch{
            print(error)
        }
        
        
    }
    func updateData(user:User){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let username = result.value(forKey: "name") as? String{
                        if let phone = result.value(forKey: "phone") as? Int64{
                        if username == user.name && phone == user.phone{
                            result.setValue(user.name, forKey: "name")
                            result.setValue(user.phone, forKey: "phone")
                            do{
                                try context.save()
                            }catch{
                                print(error)
                            }
                        }
                    }
                }
            }
        }
        }catch{
            print(error)
        }
    }




    
    
    
    //MARK: - TableView methods
    func listViewNumberOfSection()->Int{
        return 1
    }
    func listViewNumberOfRowInSection()->Int{
        return users.count
    }
    func userNameForItemAtIndexPath(indexPath:IndexPath)->String{
        return users[indexPath.row].name ?? ""
    }
    func phoneForItemAtIndexPath(indexPath:IndexPath)->String{
        return "\(users[indexPath.row].phone)"
    }
    func userForItemAtIndexPath(indexPath:IndexPath)->User{
        return users[indexPath.row]
    }
    
}
