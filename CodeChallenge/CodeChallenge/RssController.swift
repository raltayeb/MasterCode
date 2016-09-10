//
//  RssController.swift
//  CodeChallenge
//
//  Created by Mohammed Ragab on 9/10/16.
//  Copyright © 2016 MasterWorks. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage
import Alamofire

class RssController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedFeed = Feeds()
    let myParser : XmlManager = XmlManager()
    
    @IBAction func goToRss(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRss()
    }
    func loadRss() {
        let myParser : XmlManager = XmlManager()
        myParser.start()
        reloadData()
       
    }
    
    func reloadData(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RssController.getFeeds(_:)), name: "getFeeds", object: nil)
    }
    func getFeeds(notification : NSNotification){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "getFeeds", object: nil)
        
        tableView.reloadData()
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return myFeed.count
        let realm = try! Realm()
        let feeds  = realm.objects(Feeds)
        return feeds.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RssCell
        let realm = try! Realm()
        let feeds  = realm.objects(Feeds)
        cell.lbl_title.text = feeds[indexPath.row].Title
        cell.lbl_title.lineBreakMode = .ByWordWrapping
        cell.lbl_title.numberOfLines = 0
        
        cell.lbl_description.text = feeds[indexPath.row].Description
        cell.lbl_description.lineBreakMode = .ByWordWrapping
        cell.lbl_description.numberOfLines = 0
        let font: UIFont = UIFont(name: "American Typewriter", size: 16)!
        cell.lbl_description.font = font

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let realm = try! Realm()
        let feeds  = realm.objects(Feeds)
        
        var textRectTitle = CGRect()
         var textRectDecs = CGRect()
        
        let textAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(16.0)]
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping
        
        let textStringTitle = feeds[indexPath.row].Title
        
        let textStringDecs = feeds[indexPath.row].Description
  
        
        
        textRectTitle = textStringTitle.boundingRectWithSize(CGSizeMake(300, 600), options: .UsesLineFragmentOrigin, attributes: textAttributes, context: nil)
        textRectDecs =  textStringDecs.boundingRectWithSize(CGSizeMake(300, 600), options: .UsesLineFragmentOrigin, attributes: textAttributes, context: nil)
        
        return textRectTitle.height + textRectDecs.height + 20
        
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        CellAnimator.animateCell(cell, withTransform: CellAnimator.TransformTilt, andDuration: 0.4)
    }
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        
        
        let realm = try! Realm()
        let feeds  = realm.objects(Feeds)
        
        selectedFeed = feeds[indexPath.row]
        
        return indexPath
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showDetail") {
            
            if let detailNav = segue.destinationViewController as? UINavigationController{
            let detail = detailNav.topViewController as! DetailsController
            detail.feed = selectedFeed
                print(detail.feed.ImageURL)
            }
            
        }
        
        
    }

    

}
