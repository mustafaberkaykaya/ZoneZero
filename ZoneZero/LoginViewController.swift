//
//  LoginViewController.swift
//  ZoneZero
//
//  Created by Mustafa Berkay Kaya on 11.09.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBOutlet weak var checkBox1: UIButton!
    
    @IBOutlet weak var checkbox2: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    var flag1 = false
    var flag2 = false 
    
    var name = ""
    var email = ""
    var password = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        checkbox2.isHidden = true
        label2.isHidden = true

        
        loginButton.backgroundColor = UIColor.blue
        loginButton.layer.cornerRadius = loginButton.frame.height/2
        loginButton.setTitleColor(UIColor.white, for: .normal)
        
        loginButton.layer.shadowColor = UIColor.red.cgColor
        loginButton.layer.shadowRadius = 6
        
        print(email)
        print(password)
    }
    
 
    @IBAction func loginButton(_ sender: Any) {
        if usernameText.text == name && passwordText.text == password {
            Auth.auth().signIn(withEmail: email, password: password) { authdata, error in
                if error != nil {
                    
                }else{
                    self.performSegue(withIdentifier: "toMovieList", sender: nil)
                }
            }
        }else if usernameText.text == "" || passwordText.text == ""{
            self.makeAlert(title: "Error", message: "Please make sure the required fields are filled")
        }
        else {
            self.makeAlert(title: "Error", message: "Values are incorrect. Please try again.")
        }
    }
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let retryButton = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: {_ in
            self.usernameText.text = ""
            self.passwordText.text = ""
            
        } )
        alert.addAction(cancelButton)
        alert.addAction(retryButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func check1Button(_ sender: Any) {
        if flag1 == false {
            checkBox1.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            checkbox2.isHidden = false
            label2.isHidden = false
            flag1 = true
        }else if flag1 == true{
            checkBox1.setBackgroundImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            flag1 = false
            checkbox2.isHidden = true
            label2.isHidden = true
        }
    }
    
    
    @IBAction func check2Button(_ sender: Any) {
        if flag2 == false {
            checkbox2.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flag2 = true
        }else if flag2 == true {
            checkbox2.setBackgroundImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            flag2 = false
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
