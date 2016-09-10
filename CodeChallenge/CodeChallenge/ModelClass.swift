//
//  ModelClass.swift
//  CodeChallenge
//
//  Created by Mohammed Ragab on 9/10/16.
//  Copyright © 2016 MasterWorks. All rights reserved.
//

import UIKit
import RealmSwift
import SystemConfiguration

class ModelClass: NSObject {

    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}
class Feeds:Object {
    
    dynamic var Title = ""
    dynamic var Description = ""
    dynamic var ImageURL = ""
    
//    var Image = UIImage()

    
}

//class Details {
//    var Title = ""
//    var Description = ""
//    var Image = UIImage()
//    
//}
