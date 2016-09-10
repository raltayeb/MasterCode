//
//  MainController.swift
//  GeneticAlgorithm
//
//  Created by Mohammed Ragab on 8/30/16.
//  Copyright © 2016 EvoSys. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let arr_headers = ["Intorducation","What I Used ?", "Who I am"]
    let arr_label = ["Code Challenge  its small Application written in Swift and Mixed with Objective-C for Master Code Interview","I Used All of This Ready Pods : \n Alamofire \n AlamofireImage\n RealmSwift \n IQKeyboardManagerSwift \n Sweet Alert\n FloatLabelTextField \n MBProgress written in Objective-C " ,"Name : Ragab Mohammed \nM : 0581888575 \nE : raltayeb@gmail.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arr_headers.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainCell
            cell.label.text = arr_label[indexPath.section]
            cell.label.lineBreakMode = .ByWordWrapping
            cell.label.numberOfLines = 0
            let font: UIFont = UIFont(name: "American Typewriter", size: 16)!
            cell.label.font = font
            return cell
        
        
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        CellAnimator.animateCell(cell, withTransform: CellAnimator.TransformTilt, andDuration: 0.4)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            var textRect = CGRect()
            let textString = arr_label[indexPath.section]
            let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .ByWordWrapping
            
            let textAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(16.0)]
            
            textRect = textString.boundingRectWithSize(CGSizeMake(300, 600), options: .UsesLineFragmentOrigin, attributes: textAttributes, context: nil)
            return textRect.height + 30
            
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arr_headers[section]
        
    }
    
    
    
    
}