//
//  LoginViewController.swift
//  PokeApp
//
//  Created by Damir Kopljar on 7/8/16.
//  Copyright © 2016 Damir Kopljar. All rights reserved.
//

import UIKit
import MBProgressHUD
class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
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
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.labelText = "Loading"
        performSelector(#selector(LoginViewController.hideLoadingHUD), withObject: nil, afterDelay: 3.0)
        
       
    }
    
    func hideLoadingHUD(){
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        let homeVC = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as? HomeViewController
        self.navigationController?.pushViewController(homeVC!, animated: true)
    }

    @IBAction func SignUpHandler(sender: AnyObject) {
        let regVC = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController") as? RegisterViewController
        self.navigationController?.pushViewController(regVC!, animated: true)
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
