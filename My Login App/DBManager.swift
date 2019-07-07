//
//  DBManager.swift
//  My Login App
//
//  Created by Tilakkumar Gondi on 07/07/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class DBManager:NSObject {
    static let shared = DBManager()
    
    private override init() {}
    
    
    
    func saveUser(data user:UserData) {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedcontext = appdelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "BusData", in: managedcontext)!
        
        let userData = NSManagedObject(entity: entity, insertInto: managedcontext) as! User
        
        userData.first_name = user.first_name
        userData.last_name = user.last_name
        userData.date_of_birth = user.dob
        userData.email = user.email
        userData.phone = user.phone
        userData.password = user.password
        
        do {
            try managedcontext.save()
        } catch let error as NSError {
            print("Could not save: \(error.localizedDescription)")
        }
    }
    
    func fetchfromDB() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let ctxt = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do{
            let userProfile = try ctxt.fetch(fetchRequest)
            return userProfile
            
        }catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetchUser() -> UserData{
        
        let userInfo = self.fetchfromDB()
        
        var fetcheduser:UserData?
    
        for userProfile in userInfo {
            let user = userProfile as! User
            fetcheduser = UserData(
                            first_name: user.first_name,
                            last_name: user.last_name,
                            phone: user.phone,
                            email: user.email,
                            date_of_birth: "",
                            dob: user.date_of_birth!,
                            password: user.password,
                            imageUrl: "")
            
        }
        
        return fetcheduser!
    }
}
