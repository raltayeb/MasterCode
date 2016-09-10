//
//  DetailsController.swift
//  CodeChallenge
//
//  Created by Mohammed Ragab on 9/10/16.
//  Copyright © 2016 MasterWorks. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class DetailsController: UIViewController {

    var feed : Feeds!
    
    @IBOutlet weak var header: UILabel!
//    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var details: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        header.text = feed.Title
        details.text = feed.Description
        
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
