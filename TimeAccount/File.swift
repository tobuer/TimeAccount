//
//  File.swift
//  TimeAccount
//
//  Created by tobuer on 2017/1/11.
//  Copyright © 2017年 tobuer. All rights reserved.
//

import Foundation



class Cost_item:NSCoding{
    enum Cost_type{
        case inCost
        case outCost
    }
    var number: Double
    var cost_type: Cost_type
    var kind: Int
//    var kind_in: Cost_in_kind
//    var kind_out: Cost_out_kind
    
    init(cost_type: Cost_type,number: Double,kind: Int){
        self.kind=kind
        self.cost_type=cost_type
        self.number=number
    }
    
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.cost_type = (decoder.decodeObject(forKey: "cost_type") as? Cost_type)!
        self.kind = (decoder.decodeObject(forKey: "kind") as? Int)!
        self.number = (decoder.decodeObject(forKey: "number") as? Double)!
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(cost_type, forKey:"cost_type")
        coder.encode(kind, forKey:"kind")
        coder.encode(number, forKey:"number")
    }
    
    
    //static var db:SQLiteDB! = SQLiteDB.sharedInstance
}
