//
//  DateHelper.swift
//  ChatApp
//
//  Created by k2 tam on 22/08/2022.
//

import Foundation

class DateHelper{
    
    static func chatTimeStampFrom(date: Date?) -> String{
         
        guard date != nil else{
            return ""
        }
        
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        
        return df.string(from: date!)
    }
}
