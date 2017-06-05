//
//  subjectViewController.swift
//  Mind Workout
//
//  Created by Tomasz Fejcak on 31/05/2017.
//  Copyright © 2017 Tomasz Fejcak. All rights reserved.
//

import Foundation
import UIKit

class MathViewController : UIViewController {

    @IBOutlet weak var taskStateSwitch: UISwitch!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var taskContent: UILabel!
    @IBOutlet weak var subjectName: UILabel!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after load
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func taskFinished(_ sender: UISwitch) {
        if(taskStateSwitch.isOn){
            finishBtn.isEnabled = true;
        }
        else
        {
            finishBtn.isEnabled = false;
        }
    }
    @IBAction func taskDone(_ sender: Any) {
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        if AuthProvider.Instance.logOut(){
        dismiss(animated: true, completion: nil)
        }
        else {
            alertTheUser(title: "Could not logout", message: "We have some troubles with loggin out, please try again later")
        }
    }
 
    private func alertTheUser(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert,animated: true,completion: nil)
    }
    
    
}

