//
//  MessageTopic.swift
//  Runtime
//
//  Created by Paul Young on 23/08/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import Foundation

protocol MessageTopic: RawRepresentable {
    
//    typealias Channel: MessageChannel  // FIXME - causes crash
    class func fromRaw(raw: String) -> Self?
    func toRaw() -> String
}
