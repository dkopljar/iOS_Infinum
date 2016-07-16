//
//  HomeViewController.swift
//  PokeApp
//
//  Created by Damir Kopljar on 7/10/16.
//  Copyright © 2016 Damir Kopljar. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Unbox


class HomeViewController: UIViewController {
    var userData: User!
    var pokeResponse: PokemonResponse!
    @IBOutlet weak var tableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.tableFooterView = UIView(frame: CGRect.zero)
        tableView!.tableFooterView?.hidden = true
        let headers = [
            "Authorization": " Token token=\(userData.authToken), email=\(userData.email)"]
        
        SVProgressHUD.show()
        Alamofire.request(.GET, "https://pokeapi.infinum.co/api/v1/pokemons", encoding: .JSON, headers:headers).validate().responseJSON { (response) in
            switch response.result {
            case .Success:
                SVProgressHUD.showSuccessWithStatus("")
                
                if let data = response.data {
                    do {
                        let pokeResponseData: PokemonResponse = try Unbox(data)
                        self.pokeResponse = pokeResponseData
                        self.tableView?.reloadData()
                    } catch _ {
                        let alert = UIAlertController(title: "Sorry!", message: "Please try again later!", preferredStyle: .Alert)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Do any additional setup after loading the view.
}





extension HomeViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pokeResponse == nil{
            return 0
        }else{
            return self.pokeResponse.pokemons.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier") as UITableViewCell!
        
        cell.textLabel?.text = pokeResponse.pokemons[indexPath.row].name
        
        return cell
    }
    
}
/**
 extension HomeViewController: UITableViewDelegate {
 
 func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 tableView.deselectRowAtIndexPath(indexPath, animated: true)
 
 print(indexPath)
 }
 
 }**/
