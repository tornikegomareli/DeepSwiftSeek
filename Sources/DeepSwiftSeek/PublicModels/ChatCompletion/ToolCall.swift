//
//  ToolCall.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct ToolCall: Codable {
    public let id: String
    public let type: String
    public let function: FunctionCall
}