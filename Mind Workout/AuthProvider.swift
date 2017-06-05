//
//  AuthProvider.swift
//  Mind Workout
//
//  Created by Tomasz Fejcak on 05/06/2017.
//  Copyright © 2017 Tomasz Fejcak. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


typealias LoginHandler = (_ msg : String?) -> Void;

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid email address, please provide a real email address";
    static let WRONG_PASSWORD = "Wrong password, please try again";
    static let PROBLEM_CONNECTING = "Problem connecting to database"
    static let USER_NOT_FOUND = "User not found, please register"
    static let EMAIL_ALREADY_EXIST = "Email already in use, please use different email"
    static let WEAK_PASSWORD = "Password should be at least 6 digits long"
}


class AuthProvider {
    private static let _instance = AuthProvider();
    
    static var Instance : AuthProvider{
        return _instance;
    }
    
    func login(withEmail: String, password: String, loginHandler : LoginHandler?)
    {
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: {
            (user,error) in
            
            //we cannot sign in
            if error != nil {
                 self.handleErorrs(err: error! as NSError, loginHandler: loginHandler)
            }
            //we can sign in
            else
            {
                loginHandler?(nil)
            }
        });
    }
    func signup(withEmail: String, password: String, loginHandler : LoginHandler?)
    {
        Auth.auth().createUser(withEmail: withEmail, password: password, completion: {
            (user,error) in
            
            //we cannot sign up
            if error != nil {
                self.handleErorrs(err: error! as NSError, loginHandler: loginHandler)
            }
                //we can sign up
            else
            {
                if user?.uid != nil
                {
                    //store the user in database
                    
                    //log in the user
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler)
                }
            }
        });
    }
    
    func logOut() -> Bool {
        if Auth.auth().currentUser != nil {
            do{
                try Auth.auth().signOut();
                return true;
            } catch {
                return false
            };
        }
        return true
    }
    private func handleErorrs(err: NSError, loginHandler : LoginHandler?)
    {
        if let errCode = AuthErrorCode(rawValue: err.code)
        {
            switch errCode {
            case .wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD)
                break;
            case .invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL)
                break;
            case .userNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND)
                break;
            case .emailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_EXIST)
                break;
            case .weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD)
                break;
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING)
                break;
                
            }
        }
    }
}
