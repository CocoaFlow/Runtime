//
//  Runtime.swift
//  Runtime
//
//  Created by Paul Young on 23/08/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import Foundation
import Transport
import JSONLib

//public struct Runtime { // FIXME: Use a class as a workaround for the circular dependency issue in init
final public class Runtime {

    private let transport: Transport!
    private let runtime: RuntimeChannel!
    
     public init(_ transport: Transport) {
        self.transport = transport
        self.runtime = RuntimeChannel(self)
    }
    
    /**
        Send a message to the transport.
    
        :param: message
    */
    func send<T: MessageChannel, U: MessageTopic where T.Topic == U>(message: Message<T, U>) {
        let channel = message.channel.name.toRaw()
        let topic = message.topic.toRaw()
        let payload = message.payload
        self.transport.send(channel, topic, payload)
    }
    
    /**
        Receive a message from the transport.

        :param: channel
        :param: topic
        :param: payload
    */
    public func receive(channel: String, _ topic: String, _ payload: JSON) {
        // TODO: Clean this up. See: http://natashatherobot.com/swift-unwrap-multiple-optionals/
        if let maybeChannel = ChannelName.fromRaw(channel) {
            switch maybeChannel {
            case .Runtime:
                if let maybeTopic = RuntimeChannel.Topic.fromRaw(topic) {
                    let message = Message(self.runtime, maybeTopic, [:])
                    self.runtime.receive(message)
                } else {
                    NSException(name: "Invalid topic in message on runtime channel", reason: nil, userInfo: nil).raise()
                }
            case .Graph:
                println(".Graph")
            case .Component:
                println(".Component")
            case .Network:
                println(".Network")
            }
        } else {
            NSException(name: "Invalid message channel", reason: nil, userInfo: nil).raise()
        }
    }
}
