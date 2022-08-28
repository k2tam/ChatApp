//
//  CacheService.swift
//  ChatApp
//
//  Created by k2 tam on 27/08/2022.
//

import Foundation
import SwiftUI

class CacheService{
    
    //Stores the Image componetns with URL string as key
    private static var imageCache = [String : Image]()
    
    
    ///Return image for given key.Nil means image doesn't exist in cache
    static func getImage(forKey: String) -> Image? {
        
        
        return imageCache[forKey]
    }
    
    
    ///Stores the image component in cache with given key
    static func setImage(image: Image, forKey: String){
        imageCache[forKey] = image
    }
}
