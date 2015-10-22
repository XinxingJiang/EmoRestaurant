//
//  WelcomeViewController.swift
//  EmoRestaurant
//
//  Created by Xinxing Jiang on 3/4/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.setStyle(borderWidth: 0.0, borderColor: UIColor.grayColor().CGColor, backgroundColor: UIColor.grayColor(), titleColor: UIColor.whiteColor())
        loginButton.setStyle(borderWidth: 0.0, borderColor: UIColor.blueColor().CGColor, backgroundColor: UIColor.blueColor(), titleColor: UIColor.whiteColor())
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }
    
    // MARK: - Navigation
    @IBAction func goBackToWelcome(segue: UIStoryboardSegue) {
        
    }
}
