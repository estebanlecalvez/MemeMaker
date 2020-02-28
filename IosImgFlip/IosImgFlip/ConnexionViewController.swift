//
//  ConnexionViewController.swift
//  IosImgFlip
//
//  Created by Service Informatique on 28/02/2020.
//  Copyright © 2020 MDS. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ConnexionViewController:UIViewController{
    @IBOutlet weak var identifier: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
            GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func onConnectClick(_ sender: Any) {
        
    }
    
    
}
