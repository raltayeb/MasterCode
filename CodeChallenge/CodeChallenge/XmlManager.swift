//
//  XmlManager.swift
//  CodeChallenge
//
//  Created by Mohammed Ragab on 9/10/16.
//  Copyright © 2016 MasterWorks. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class XmlManager: NSObject, NSXMLParserDelegate {
    
   
    var xmlParser: NSXMLParser!
   
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title = NSMutableString()
    var desc = NSMutableString()
    var imgURL = NSMutableString()
    
    // initilise parser
    func start() -> AnyObject {
        startParse()
        return self
    }
    
    func startParse() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
            print("deleted")
        }
        let urlString = NSURL(string: "http://rss.cnn.com/rss/edition.rss")
        let rssUrlRequest:NSURLRequest = NSURLRequest(URL:urlString!)
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(rssUrlRequest, queue: queue) {
            (response, data, error) -> Void in
            //3
            self.xmlParser = NSXMLParser(data: data!)
            self.xmlParser.delegate = self
            
            self.xmlParser.shouldProcessNamespaces = false
            self.xmlParser.shouldReportNamespacePrefixes = false
            self.xmlParser.shouldResolveExternalEntities = false
            
            self.xmlParser.parse()
            
            let strData1 = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(strData1)
            
        }
        
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title = NSMutableString()
            title = ""
            desc = NSMutableString()
            desc = ""
            imgURL = NSMutableString()
            imgURL = ""
        }
    }

    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("title") {
            title.appendString(string)
        } else if element.isEqualToString("description") {
            desc.appendString(string)
        }else if element.isEqualToString("enclosure") {
            imgURL.appendString(string)
        }else if element.isEqualToString("media:thumbnail"){
            imgURL.appendString(string)
        }
    }

    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("item") {
            if !title.isEqual(nil) {
                elements.setObject(title, forKey: "title")
            }
            if !desc.isEqual(nil) {
                elements.setObject(desc, forKey: "description")
            }
            if !imgURL.isEqual(nil) {
                elements.setObject(imgURL, forKey: "image")
            }
            
            let feed : Feeds = Feeds()
            feed.Title = String(title)
            feed.Description = String(desc)
            feed.ImageURL = String(imgURL)
            let realm = try! Realm()
            try! realm.write {
                realm.add(feed)
            }
//            arr_feeds.append(elementName)
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser){
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    print(self.arr_feeds.count)
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("getFeeds", object: nil)
                    
        //            self.titlesTableView.reloadData()
                })
            }
    
    
    
}