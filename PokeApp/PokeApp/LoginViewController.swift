//
//  LoginViewController.swift
//  PokeApp
//
//  Created by Damir Kopljar on 7/8/16.
//  Copyright © 2016 Damir Kopljar. All rights reserved.
//

import UIKit
import SVProgressHUD
import Unbox
import Alamofire
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonHandler(sender: AnyObject) {
        
        if validateUserInput(){
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            let attributes = ["email":email, "password":password]
            
            let params:[String:[String:AnyObject]] = ["data": ["type": "session", "attributes":attributes]]
            
            SVProgressHUD.show()
            
            Alamofire.request(.POST, "https://pokeapi.infinum.co/api/v1/users/login", parameters: params, encoding: .JSON).validate().responseJSON { (response) in
                switch response.result {
                case .Success:
                    SVProgressHUD.showSuccessWithStatus("")
                    
                    if let data = response.data {
                        do {
                            let user: User = try Unbox(data)
                            self.pushHomeView(user)
                        } catch _ {
                            let alert = UIAlertController(title: "Sorry!", message: "Please try again later", preferredStyle: .Alert)
                            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                            alert.addAction(okAction)
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Sorry!", message: "Please try again later", preferredStyle: .Alert)
                        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                        alert.addAction(okAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                case .Failure(let error):
                    SVProgressHUD.showErrorWithStatus("\(error.localizedDescription)")
                }
            }
            
        }
    }
    
    func pushHomeView(user:User){
        let homeVC = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        homeVC.userData = user
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
    

    @IBAction func SignUpHandler(sender: AnyObject) {
        let regVC = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController") as? RegisterViewController
        self.navigationController?.pushViewController(regVC!, animated: true)
    }
    
    func validateUserInput() -> Bool {
        if emailTextField?.text?.characters.count==0 || passwordTextField?.text?.characters.count==0{
            let alert = UIAlertController(title: "Error!", message: "Please enter valid username and password and email", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
            return false
        }else if (!Util.isValidEmail(emailTextField.text!)){
            return false
        } else{
            return true
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
