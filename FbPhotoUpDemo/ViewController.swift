//
//  ViewController.swift
//  FbPhotoUpDemo
//
//  Created by Equinox on 21/11/2561 BE.
//  Copyright © 2561 Equinox. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var LogUI: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LogUI.layer.cornerRadius = 0.07 * LogUI.bounds.size.width
    }
    
    
    @IBAction func LogAnoAct(_ sender: Any) {
        Auth.auth().signInAnonymously { (user, error) in
            if error == nil{
                print("LOGIN WTH ANONYMOUSLY SUCCESS !!!")
                self.performSegue(withIdentifier: "ToLogedView", sender: nil)
                print(user)
            }else{
                print("ERROR ERROR ERROR LOGIN WTH ANONYMOUSLY ERROR !!!")
            }
        }
    }
    
    
    
    
    
    
    
}

