//
//  YahooLocal.swift
//  GourmetSearch
//
//  Created by 佐藤恒 on 2017/10/24.
//  Copyright © 2017年 佐藤恒. All rights reserved.
//

import Foundation

public struct Shop: CustomStringConvertible {
    public var gid: String? = nil
    public var name: String? = nil
    public var photoUrl: String? = nil
    public var yomi: String? = nil
    public var tel: String? = nil
    public var address: String? = nil
    public var lat: String? = nil
    public var lon: String? = nil
    public var catchCopy: String? = nil
    public var hasCoupon: String? = nil
    public var station: String? = nil
    
    public var description: String {
        get {
            var str = "\nGid: \(gid ?? "")\n"
            str += "Name: \(name ?? "")\n"
            str += "PhotoUrl: \(photoUrl ?? "")\n"
            str += "Yomi: \(yomi ?? "")\n"
            str += "Tel: \(tel ?? "")\n"
            str += "Address: \(address ?? "")\n"
            str += "Lat & Lon: (\(lat ?? ""), \(lon ?? ""))\n"
            str += "catchCopy: \(catchCopy ?? "")\n"
            str += "HasCoupon: \(hasCoupon ?? "")\n"
            str += "Station: \(station ?? "")\n"
            
            return str
        }
    }
}

public struct QueryCondition {
    public var query: String? = nil
    public var gid: String? = nil
    
    public enum Sort: String {
        case score = "score"
        case geo = "geo"
    }
    
    public var sort: Sort = .score
    public var lat: Double? = nil
    public var lon: Double? = nil
    public var dist: Double? = nil
    
    public var queryParams: [String: String] {
        get {
            var params = [String: String]()
            if let unwrapped = query {
                params["query"] = unwrapped
            }
            if let unwrapped = gid {
                params["gid"] = unwrapped
            }
            
            switch sort {
            case .score:
                params["sort"] = "score"
            case .geo:
                params["sort"] = "geo"
            }
            
            if let unwrapped = lat {
                params["lat"] = "\(unwrapped)"
            }
            if let unwrapped = lon {
                params["lon"] = "\(unwrapped)"
            }
            if let unwrapped = dist {
                params["dist"] = "\(unwrapped)"
            }
            
            params["device"] = "mobile"
            params["group"] = "gid"
            params["image"] = "true"
            params["gc"] = "01"
            
            return params
        }
    }
}
