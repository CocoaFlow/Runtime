//
//  MessageTopic.swift
//  Runtime
//
//  Created by Paul Young on 23/08/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

protocol MessageTopic: RawRepresentable {
    
    class func fromRaw(raw: String) -> Self?
    func toRaw() -> String
}
