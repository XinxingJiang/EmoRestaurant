//
//  LoginViewController.swift
//  EmoRestaurant
//
//  Created by YUE on 2/3/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // for fast log in
    var autoLogin = false
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    // MARK: - Model
    
    var username: String?
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: UITextField! {
        didSet {
            usernameTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }            
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // auto fill username from NSUserDefault
        username = defaults.objectForKey(UserDefault.Username) as? String
        // move cursor to proper field automatically
        if username == nil {
            usernameTextField.becomeFirstResponder()
        } else {
            usernameTextField.text = username
            passwordTextField.becomeFirstResponder()
        }
        // make login button unclickable
        loginButton.enabled = false
        loginButton.setStyle(borderWidth: 1.0, borderColor: UIColor.blueColor().CGColor, backgroundColor: UIColor.blueColor(), titleColor: UIColor.whiteColor())
        // test only
        if autoLogin {
            usernameTextField.text = "123"
            passwordTextField.text = "123"
            login()
        }        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    // MARL: - Login
    
    @IBAction func login() {
        let username = usernameTextField.text
        let password = passwordTextField.text
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) in
            if error == nil {
                // save username to NSUserDefaults
                self.defaults.setValue(username, forKey: UserDefault.Username)
                self.performSegueWithIdentifier(Constants.SegueIdentifier, sender: nil)
            } else {
                var errorMessage: String
                switch error.code {
                case Error.NetworkErrorCode:
                    errorMessage = Error.NetworkErrorMessage
                case Error.InvalidLoginParameterErrorCode:
                    errorMessage = Error.InvalidLoginParameterErrorMessage
                default:
                    errorMessage = Error.UnknownErrorMessage
                }
                let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Back", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let SegueIdentifier = "Login Finish"
    }
    
    // MARK: - Text Field Delegate
    
    // when click return at username textfield, move cursor to password textfield; when click return at password field, hide keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            if loginButton.enabled {
                login()
            }
        }
        return true
    }
    
    // The text field calls this method BEFORE the user types a new character in the text field or deletes an existing character.
    // determine whether login button is clickable
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let textAfterEdit = NSString(string: textField.text!).stringByReplacingCharactersInRange(range, withString: string)
        if textAfterEdit.isEmpty {
            loginButton.enabled = false
        } else if textField == usernameTextField {
            loginButton.enabled = !(passwordTextField.text!.isEmpty)
        } else if textField == passwordTextField {
            loginButton.enabled = !(usernameTextField.text!.isEmpty)
        }
        return true
    }
}
