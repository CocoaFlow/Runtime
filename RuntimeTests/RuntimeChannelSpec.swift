//
//  RuntimeChannelSpec.swift
//  Runtime
//
//  Created by Paul Young on 24/08/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Runtime
import JSONLib

class RuntimeChannelSpec: QuickSpec {
    
    override func spec() {
        
        describe("Runtime channel") {
            
            describe("when receiving a message") {
                
                context("with an invalid topic") {
                        
                    it("should raise an exception") {
                        let fakeMessageSender = FakeMessageSender()
                        let runtime = Runtime(fakeMessageSender)
                        
                        expect {
                            runtime.receive("runtime", "invalid", [:])
                        }.to(raiseException(named: "Invalid topic in message on runtime channel"))
                    }
                }
                    
                context("with a topic of getruntime") {
                    
                    it("should send a message to the transport with information about the runtime") {
                        var messageChannel: String!
                        var messageTopic: String!
                        var messagePayload: JSON?
                        
                        let fakeMessageSender = FakeMessageSender { (channel, topic, payload) in
                            messageChannel = channel
                            messageTopic = topic
                            messagePayload = payload
                        }
                        
                        let runtime = Runtime(fakeMessageSender)
                        runtime.receive("runtime", "getruntime", nil)
                        
                        let expectedPayload: JSON = [
                            "type": "CocoaFlow",
                            "version": 0.4,
                            "capabilities": [],
                            "id": "FIXME",
                            "label": "Flow-based programming on Mac and iOS.",
                            "graph": nil
                        ]
                        
                        expect(messageChannel).to(equal("runtime"))
                        expect(messageTopic).to(equal("runtime"))
                        expect(messagePayload).to(equal(expectedPayload))
                    }
                }
            }
        }
    }
}
