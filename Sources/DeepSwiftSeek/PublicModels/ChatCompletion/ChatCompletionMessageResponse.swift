//
//  ChatCompletionMessageResponse.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct ChatCompletionMessageResponse: Codable, Sendable {
  public let content: String
  public let reasoningContent: String?
  public let toolCalls: [ToolCall]?
  public let role: String?
  
  enum CodingKeys: String, CodingKey {
    case content
    case reasoningContent = "reasoning_content"
    case toolCalls = "tool_calls"
    case role
  }
}
