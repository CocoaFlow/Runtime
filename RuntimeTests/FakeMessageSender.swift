//
//  FakeMessageSender.swift
//  Runtime
//
//  Created by Paul Young on 05/09/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import Foundation
import MessageTransfer
import JSONLib

struct FakeMessageSender: MessageSenderWithReceiver {
    
    typealias Verification = (channel: String, topic: String, payload: JSON?) -> Void
    
    private let verify: Verification
    var messageReceiver: MessageReceiver?
    
    init(_ verify: Verification = { (channel, topic, payload) in }) {
        self.verify = verify
    }
    
    func send(channel: String, _ topic: String, _ payload: JSON?) {
        self.verify(channel: channel, topic: topic, payload: payload)
    }
}
