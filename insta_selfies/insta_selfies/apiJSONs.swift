//
//  apiJSONs.swift
//  insta_selfies
//
//  Created by Mac on 7/20/15.
//  Copyright (c) 2015 Jenson. All rights reserved.
//

import Foundation

protocol apiJSON_Delegate_sw {
    func objectProcessComplete(processedObjects: NSArray, withNextURL nextURL:NSURL)
    func objectProcessFail(processingError: NSURL)
}

class apiJSONs {
    var executeQueue: dispatch_queue_t
    
    func parseDataWith(data: NSData) {
        weak var thisParser: apiJSONs = self;
        
        if self.executeQueue == nil {
            executeQueue = dispatch_queue_create("parser queue", nil)
        }
        
        dispatch_async( self.executeQueue, {
            var results: NSMutableArray = []
            var nextURL: NSURL
            
            var parseError: NSError
            
            let selfieDict: NSDictionary = NSJSONSerialization.JSONObject
        })
    }
}