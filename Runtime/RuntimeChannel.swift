//
//  RuntimeChannel.swift
//  Runtime
//
//  Created by Paul Young on 24/08/2014.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import Foundation
import JSONLib

struct RuntimeChannel: MessageChannel {
    let name: ChannelName = .Runtime
    let runtime: Runtime
    
    init(_ runtime: Runtime) {
        self.runtime = runtime
    }
    
    /**
        Runtime message topics.
    */
    enum Topic: String, MessageTopic {
        typealias Channel = RuntimeChannel
        
        case GetRuntime = "getruntime"
        case Runtime = "runtime"
        case Ports = "ports"
        case Packet = "packet"
    }
    
    /**
        - ProtocolRuntime: The runtime is able to expose the ports of its main graph using the Runtime protocol and transmit packet information to/from them.
        - ProtocolGraph: The runtime is able to modify its graphs using the Graph protocol.
        - ProtocolComponent: The runtime is able to list and modify its components using the Component protocol.
        - ProtocolNetwork: The runtime is able to control and introspect its running networks using the Network protocol.
        - ComponentSetSource: The runtime is able to compile and run custom components sent as source code strings.
        - ComponentGetSource: The runtime is able to read and send component source code back to client.
        - NetworkPersist: The runtime is able to "flash" a running graph setup into itself, making it persistent across reboots.
    */
    enum Capability: String {
        case ProtocolRuntime = "protocol:runtime"
        case ProtocolGraph = "protocol:graph"
        case ProtocolComponent = "protocol:component"
        case ProtocolNetwork = "protocol:network"
        case ComponentSetSource = "component:setsource"
        case ComponentGetSource = "component:getsource"
        case NetworkPersist = "network:persist"
    }
    
    func send(topic: RuntimeChannel.Topic, _ payload: JSON) {
        let message = Message(self, topic, payload)
        self.runtime.send(message)
    }
    
    func receive(message: Message<RuntimeChannel, RuntimeChannel.Topic>) {
        switch message.topic {
        case .GetRuntime:
            self.getRuntime()
        case .Runtime:
            println(".Runtime")
        case .Ports:
            println(".Ports")
        case .Packet:
            println(".Packet")
        }
    }
    
    /**
        Request the information about the runtime.
        
        When receiving this message the runtime will send a message with the `Runtime` topic and the following payload:
        
        - type: The type of the runtime, for example CocoaFlow.
        - version: The version of the runtime protocol that the runtime supports, for example 0.4
        - capabilities: A list of things that the runtime is able to do.
        - id: The runtime ID used with Flowhub Registry.
        - label: A human-readable description of the runtime.
        - graph: The ID of the currently configured main graph that is running on the runtime, if any.
    */
    private func getRuntime() {
        let capabilities: JSON = [
            JSValue(Capability.ProtocolRuntime.toRaw())
        ]
        
        let payload: JSON = [
            "type": "CocoaFlow",
            "version": 0.4,
            "capabilities": [],
            "id": "FIXME",
            "label": "Flow-based programming on Mac and iOS.",
            "graph": nil
        ]
        
        let message = Message(self, .GetRuntime, payload)
        self.send(.Runtime, payload)
    }
}
