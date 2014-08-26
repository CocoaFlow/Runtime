//
//  FakeTransport.swift
//  Runtime
//
//  Created by Paul Young on 24/08/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import Runtime
import JSONLib

struct FakeTransport: Transport {
    
    typealias Verification = (channel: String, topic: String, payload: JSON) -> Void
    
    private var verify: Verification
    
    init(_ verify: Verification = { (channel, topic, payload) in }) {
        self.verify = verify
    }
    
    func send(channel: String, _ topic: String, _ payload: JSON) {
        self.verify(channel: channel, topic: topic, payload: payload)
    }
}
