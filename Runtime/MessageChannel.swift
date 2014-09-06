//
//  MessageChannel.swift
//  Runtime
//
//  Created by Paul Young on 23/08/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import Foundation
import JSONLib

protocol MessageChannel {
    
    var runtime: Runtime { get }
    init(_ runtime: Runtime)
    
    var name: ChannelName { get }
    typealias Topic: MessageTopic
    
    func send(topic: Topic, _ payload: JSON)
    func receive(message: Message<Self, Topic>)
}
