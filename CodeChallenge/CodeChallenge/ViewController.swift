//
//  ViewController.swift
//  CodeChallenge
//
//  Created by Mohammed Ragab on 9/10/16.
//  Copyright © 2016 MasterWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, MBProgressHUDDelegate {

    let hud: MBProgressHUD = MBProgressHUD()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
   
    @IBAction func loginBtn(sender: UIButton) {
        if valid_input() {
            loadRss()
        }
    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userName.text = "admin@admin.com"
        password.text = "asdf1234"
        
        userName.borderStyle = .RoundedRect
        password.borderStyle = .RoundedRect
        
        self.hud.delegate = self
        self.view.addSubview(self.hud)
        hud.mode = .Indeterminate
        self.hud.hide(true)
        
    }
//    MARK:- Load Feeds
    func loadRss() {
        self.hud.show(true)
        let myParser : XmlManager = XmlManager()
        myParser.start()
        reloadData()
        
    }
    func reloadData(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RssController.getFeeds(_:)), name: "getFeeds", object: nil)
    }
    func getFeeds(notification : NSNotification){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "getFeeds", object: nil)
        self.hud.hide(true)
        signIn()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func signIn(){
        let vc : UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("RssController"))! as! RssController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    func valid_input() -> Bool{
            self.view.endEditing(true)
            var title = NSLocalizedString("Error!", comment: "")
            var subTitle = NSLocalizedString("Unknown Error", comment: "")
            if userName.text != "admin@admin.com" {
                title = NSLocalizedString("Error!", comment: "")
                subTitle = NSLocalizedString("Wrong User Name", comment: "")
            }else if password.text != "asdf1234" {
                title = NSLocalizedString("Error!", comment: "")
                subTitle = NSLocalizedString("Enter Correct Password", comment: "")
            }else{
                return true
            }
            SweetAlert().showAlert("\(title)!", subTitle: "\(subTitle)", style: AlertStyle.None)
            return false
            
        
    }

    
//    //    Mark:- textFieldDelegate
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        return true
//    }
//    func textFieldDidEndEditing(textField: UITextField) {
//        if let text = textField.text {
//            switch textField {
//            case userName:
//                mobileUser.ClientCode = text
//                
//            case password:
//                mobileUser.UserName = text
//                
//            
//                
//            default:
//                break
//            }
//        }
//        
//        
//    }
//    func textFieldDidBeginEditing(textField: UITextField) {
//        
//    }
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }

    
    

}

