//
//  RuntimeSpec.swift
//  Runtime
//
//  Created by Paul Young on 23/08/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Runtime
import JSONLib

class RuntimeSpec: QuickSpec {
    
    override func spec() {
        
        describe("Runtime") {
            
            describe("when receiving a message") {
            
                context("on an invalid channel") {
                    
                    it("should raise an exception") {
                        let fakeMessageSender = FakeMessageSender()
                        let runtime = Runtime(fakeMessageSender)
                        
                        expect {
                            runtime.receive("invalid", "_", [:])
                        }.to(raiseException(named: "Invalid message channel"))
                    }
                }
            }
        }
    }
}
