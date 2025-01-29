//
//  ChatMessageRequest.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


//
//  ChatMessage.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

public struct ChatMessageRequest: Codable {
  public let role: MessegingRole
  public let content: String
  public var trimmed: Bool = false
}
