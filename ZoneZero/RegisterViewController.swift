//
//  ViewController.swift
//  ZoneZero
//
//  Created by Mustafa Berkay Kaya on 11.09.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    var userName = ""
    var email = ""
    var password = ""

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBOutlet weak var passwordAgainText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerButton.backgroundColor = UIColor.blue
        registerButton.layer.cornerRadius = registerButton.frame.height/2
        registerButton.setTitleColor(UIColor.white, for: .normal)
        
        registerButton.layer.shadowColor = UIColor.red.cgColor
        registerButton.layer.shadowRadius = 6
        
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
       
        
        if usernameText.text != "" && emailText.text != "" &&  passwordText.text != ""  &&
            passwordAgainText.text != "" {
            
            if passwordText.text != passwordAgainText.text {
                self.makeAlert(title: "Error", message: "Passwords do not match")
            }else {
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { auth, error in
                    if error != nil{
                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "")
                    }else {
                        let fireStore = Firestore.firestore()
                        let userDictionary = ["email" : self.emailText.text!,"username":self.usernameText.text!] as [String:Any]
                        fireStore.collection("UserInfo").addDocument(data: userDictionary) { error in
                            if error != nil{
                                //
                                print(error?.localizedDescription)
                            }
                        }
                        
                 
                        self.userName = self.usernameText.text!
                        self.email = self.emailText.text!
                        self.password = self.passwordText.text!
                        self.performSegue(withIdentifier: "toLoginVC", sender: nil)
                    }
                }
            }
          
            
        }else{
            self.makeAlert(title: "Error", message: "Make sure all fields are filled")
        }
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLoginVC" {
            let destinationVC = segue.destination as! LoginViewController
            destinationVC.name = userName
            destinationVC.email = email
            destinationVC.password = password
        }
    }
    
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

    


}

