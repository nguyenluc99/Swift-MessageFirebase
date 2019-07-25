//
//  ViewController.swift
//  LoginFirebase
//
//  Created by Luc Nguyen on 7/22/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase


class ViewController: UIViewController {

    let ref = Database.database().reference()
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtn(_ sender: Any) {
        let uid = UserDefaults.standard.string(forKey: "uid") ?? ""
        if uid == "" {
            if let name = tfName.text, !name.isEmpty  {
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        print(error)
                    } else {
                        let uid = (result?.user.uid)
                        UserDefaults.standard.set(uid!, forKey: "uid")
                        UserDefaults.standard.set(name, forKey: "username")
                        self.ref.child("Users").child(uid!).child("username").setValue(name)
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        } else {
            let name = UserDefaults.standard.string(forKey: "username") ?? ""
            self.ref.child("Users").child(uid).child("username").setValue(name)
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
}

