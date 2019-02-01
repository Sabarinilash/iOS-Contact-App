//
//  ListOfContactsModel.swift
//  Ios_Sabari_Nilash_Contacts_app
//


import Foundation
import UIKit

class list_ContactModel: NSObject {
    
    var gender: String?
    var email: String?
    var phone: String?
    var cell: String?
    var country: String?
    
    var Name: name?
    var Location: location?
    var Picture: picture?

    
    func initData(random: [String:Any]) {
        
        self.gender = list_ContactModel.null(value: random["gender"] as AnyObject) as? String
        self.email = list_ContactModel.null(value: random["email"] as AnyObject) as? String
        self.phone = list_ContactModel.null(value: random["phone"] as AnyObject) as? String
        self.cell = list_ContactModel.null(value: random["cell"] as AnyObject) as? String
        self.country = list_ContactModel.null(value: random["country"] as AnyObject) as? String
        
        self.Name = name.init(ramdom:list_ContactModel.null(value:(random["name"] as AnyObject)) as? [String : Any] ?? ["" : ""])
        self.Location = location.init(ramdom:list_ContactModel.null(value:(random["location"] as AnyObject)) as? [String : Any] ?? ["" : ""])

        self.Picture = picture.init(ramdom:list_ContactModel.null(value:(random["picture"] as AnyObject)) as? [String : Any] ?? ["" : ""])

    }
    
    
    class func null(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return " " as AnyObject
        } else {
            return value
        }
    }
}

class name: NSObject {
    var title: String?
    var first: String?
    var last: String?
    
    init(ramdom: [String:Any]) {
        super.init()
        self.title = list_ContactModel.null(value:ramdom["title"] as AnyObject) as? String
        self.first = list_ContactModel.null(value:ramdom["first"] as AnyObject) as? String
        self.last = list_ContactModel.null(value:ramdom["last"] as AnyObject) as? String
    }
}
class location: NSObject {
    var street: String?; var city: String?; var state: String?; var postcode: String?
    
    init(ramdom: [String:Any]) {
        super.init()
        self.street = list_ContactModel.null(value:ramdom["street"] as AnyObject) as? String
        self.city = list_ContactModel.null(value:ramdom["city"] as AnyObject) as? String
        self.state = list_ContactModel.null(value:ramdom["state"] as AnyObject) as? String
        self.postcode = list_ContactModel.null(value:ramdom["postcode"] as AnyObject) as? String
    }
}


class picture: NSObject {
    var large: String?; var medium: String?; var thumbnail: String?
    
    init(ramdom: [String:Any]) {
        super.init()
        self.large = list_ContactModel.null(value:ramdom["large"] as AnyObject) as? String
        self.medium = list_ContactModel.null(value:ramdom["medium"] as AnyObject) as? String
        self.thumbnail = list_ContactModel.null(value:ramdom["thumbnail"] as AnyObject) as? String
    }
}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if (hex.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}




