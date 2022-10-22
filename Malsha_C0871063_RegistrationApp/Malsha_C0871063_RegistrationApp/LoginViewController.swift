//
//  ViewController.swift
//  Malsha_C0871063_RegistrationApp
//
//  Created by Malsha Lambton on 2022-10-22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var selectionSegment: UISegmentedControl!
    
    @IBOutlet weak var loginStackView: UIStackView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerStackView: UIStackView!
    
    @IBOutlet weak var modifyView: UIView!
    
    @IBOutlet weak var loginUserNameText: UITextField!
    
    @IBOutlet weak var loginPasswordText: UITextField!
    
    @IBOutlet weak var registerUsernameText: UITextField!
    
    @IBOutlet weak var registerPasswordText: UITextField!
    
    @IBOutlet weak var registerLastNameText: UITextField!
    @IBOutlet weak var registerFirstNameText: UITextField!
    
    @IBOutlet weak var registerEmailText: UITextField!
    
    @IBOutlet weak var userDetailTextView: UITextView!
    
    @IBOutlet weak var modifyUserNameText: UITextField!
    
    @IBOutlet weak var modifyPasswordText: UITextField!
    
    @IBOutlet weak var modifyFirstNameText: UITextField!
    
    @IBOutlet weak var modifyLastNameText: UITextField!
    
    @IBOutlet weak var modifyEmailText: UITextField!
    
    @IBOutlet weak var userSelection: UISegmentedControl!
    
    let userPassword = ["test":"test"]
    
    var registeredUser : [RegisteredUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyView.isHidden = true
        loginStackView.isHidden = false
        registerStackView.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginSelection(_ sender: Any) {
        
        switch userSelection.selectedSegmentIndex {
          case 0:
            modifyView.isHidden = true
            loginStackView.isHidden = false
            registerStackView.isHidden = true
          case 1 :
            modifyView.isHidden = true
            loginStackView.isHidden = true
            registerStackView.isHidden = false

          default:
              break
          }

    }
    @IBAction func loginButtonClicked() {
        
        let userName = loginUserNameText.text ?? ""
          let passWord = loginPasswordText.text ?? ""
        if let registeredUser = registeredUser.first(where: {$0.userName == userName}) {
            let result = validateUser(user: [userName:passWord])
            if result {
                modifyView.isHidden = false
                loginStackView.isHidden = true
                registerStackView.isHidden = true
                loginButton.isEnabled = false
                loginUserNameText.text = ""
                loginPasswordText.text = ""
                
                modifyUserNameText.text = registeredUser.userName
                modifyPasswordText.text = registeredUser.password
                modifyFirstNameText.text = registeredUser.firstName
                modifyLastNameText.text = registeredUser.lastName
                modifyEmailText.text = registeredUser.email
                userDetailTextView.text = registeredUser.description
            }else{
                //show an alert
                showAlert(title: "Login Error", actionTitle: "OK", message: "Invalid User Details", preferredStyle: .alert)
                loginUserNameText.text = ""
                loginPasswordText.text = ""
                
            }
        }else{
            showAlert(title: "Login Error", actionTitle: "OK", message: "User not registerd. Please reister", preferredStyle: .alert)
            loginUserNameText.text = ""
            loginPasswordText.text = ""
        }
    }
    
    @IBAction func registerButtonClicked() {
        
        if  registerUsernameText.text == ""{
            showAlert(title: "Register Error", actionTitle: "OK", message: "Please provide your username", preferredStyle: .alert)
                return
        }else if registerPasswordText.text == ""{
            showAlert(title: "Register Error", actionTitle: "OK", message: "Please provide your password", preferredStyle: .alert)
                return
        }else if registerFirstNameText.text == ""{
            showAlert(title: "Register Error", actionTitle: "OK", message: "Please provide your first name", preferredStyle: .alert)
                return
        }else if registerLastNameText.text == ""{
            showAlert(title: "Register Error", actionTitle: "OK", message: "Please provide your last name", preferredStyle: .alert)
                return
        }else if registerEmailText.text == ""{
            showAlert(title: "Register Error", actionTitle: "OK", message: "Please provide your email", preferredStyle: .alert)
                return
        }else if registeredUser.contains(where: { $0.userName == registerUsernameText.text }){
            showAlert(title: "Register Error", actionTitle: "OK", message: "This username has been taken", preferredStyle: .alert)
            registerUsernameText.text = ""
        }else{
            let user = RegisteredUser(userName: registerUsernameText.text!, password: registerPasswordText.text!, firstName: registerFirstNameText.text!, lastName: registerLastNameText.text!, email: registerEmailText.text!)
            registeredUser.append(user)
            showAlert(title: "Register Success", actionTitle: "OK", message: "You have been successfully registered", preferredStyle: .alert)
            registerUsernameText.text = ""
            registerPasswordText.text = ""
            registerFirstNameText.text = ""
            registerLastNameText.text = ""
            registerEmailText.text = ""
        }
    
    }
    
    @IBAction func saveButtonClicked() {
        
        if modifyPasswordText.text == ""{
            showAlert(title: "Modify Error", actionTitle: "OK", message: "Please provide your password", preferredStyle: .alert)
                return
        }else if modifyFirstNameText.text == ""{
            showAlert(title: "Modify Error", actionTitle: "OK", message: "Please provide your first name", preferredStyle: .alert)
                return
        }else if modifyLastNameText.text == ""{
            showAlert(title: "Modify Error", actionTitle: "OK", message: "Please provide your last name", preferredStyle: .alert)
                return
        }else if modifyEmailText.text == ""{
            showAlert(title: "Modify Error", actionTitle: "OK", message: "Please provide your email", preferredStyle: .alert)
                return
        }else {
            
            let alert = UIAlertController(title:"Modify User" , message:"Are you sure?" , preferredStyle: .alert)
            let action = UIAlertAction(title: "No Way!", style: .cancel)
            
            let save = UIAlertAction(title: "Yes, I'm Sure!", style: .default , handler:  {_ in
                if let row = self.registeredUser.firstIndex(where: {$0.userName == self.modifyUserNameText.text}) {
                    let user = RegisteredUser(userName: self.modifyUserNameText.text!, password: self.modifyPasswordText.text!, firstName: self.modifyFirstNameText.text!, lastName: self.modifyLastNameText.text!, email: self.modifyEmailText.text! )
                    self.registeredUser[row] = user
                    self.userDetailTextView.text = self.registeredUser[row].description
                }
                self.modifyUserNameText.text = ""
                self.modifyPasswordText.text = ""
                self.modifyFirstNameText.text = ""
                self.modifyLastNameText.text = ""
                self.modifyEmailText.text = ""
                
            })
            alert.addAction(action)
            alert.addAction(save)
            present(alert, animated: true)
        }

    }

    @IBAction func modifyButtonClicked() {
        modifyPasswordText.isEnabled = true
        modifyFirstNameText.isEnabled = true
        modifyLastNameText.isEnabled = true
        modifyEmailText.isEnabled = true
        modifyUserNameText.isEnabled = false
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        modifyView.isHidden = true
        loginStackView.isHidden = false
        registerStackView.isHidden = true
        loginButton.isEnabled = true
    }
    
    private func validateUser(user : [String:String]) -> Bool{
        let userName = Array(user.keys)[0]
        let password = user[userName]
        
        if let registeredUser = registeredUser.first(where: {$0.userName == userName}) {
            if registeredUser.password == password {
                return true
            }else{
                return false
            }
        } else {
            return false
        }
    }
    
    private func showAlert(title : String, actionTitle : String, message : String, preferredStyle : UIAlertController.Style){
        
        let alert = UIAlertController(title:title , message:message , preferredStyle: preferredStyle)
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    
}

