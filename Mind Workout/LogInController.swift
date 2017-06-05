//
//  LogInController.swift
//  Mind Workout
//
//  Created by Tomasz Fejcak on 05/06/2017.
//  Copyright © 2017 Tomasz Fejcak. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth

class LogInController: UIViewController {
    
    private let TOSUBJECT_SEGUE = "DriverVC"
    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logIn(_ sender: AnyObject) {
        
        if(isValidEmail(testStr: emailTextBox.text!) && isValidPassword(testStr: passwordTextBox.text!))
        {
            AuthProvider.Instance.login(withEmail: emailTextBox.text!, password: passwordTextBox.text!, loginHandler: {(message) in
                if message != nil {
                    self.alertTheUser(title: "Problem with authentication", message: message!);
                }
                else {
                        self.performSegue(withIdentifier: self.TOSUBJECT_SEGUE, sender: nil)
                }
            })
        }
        else {
            alertTheUser(title: "Email and the password are requiered", message: "Please enter credential in the text fields");
        }
    }
    
    @IBAction func signUp(_ sender: AnyObject) {
        if(isValidEmail(testStr: emailTextBox.text!) && isValidPassword(testStr: passwordTextBox.text!))
        {
            AuthProvider.Instance.signup(withEmail: emailTextBox.text!, password: passwordTextBox.text!, loginHandler: {(message) in
                if message != nil {
                    self.alertTheUser(title: "Problem with creation a new user", message: message!);
                }
                else {
                    print("User created")
                    self.performSegue(withIdentifier: self.TOSUBJECT_SEGUE, sender: nil)
                }
            })
        }
        else {
            alertTheUser(title: "Email and the password are requiered", message: "Please enter credential in the text fields");
        }
    }
    
    
    
    
    
    private func alertTheUser(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert,animated: true,completion: nil)
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func isValidPassword(testStr:String) -> Bool {
        
        let passRegEx = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
        let passTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        
        return passTest.evaluate(with: testStr)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
