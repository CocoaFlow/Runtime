//
//  Message.swift
//  Runtime
//
//  Created by Paul Young on 23/08/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import JSONLib

//struct Message<T: MessageChannel, U: MessageTopic where T.Topic == U/*, U.Channel == T*/> {
struct Message<T: MessageChannel, U: MessageTopic where T.Topic == U> {
    
    let channel: T
    let topic: U
    let payload: JSON
    
    init(_ channel: T, _ topic: U, _ payload: JSON) {
        self.channel = channel
        self.topic = topic
        self.payload = payload
    }
}
