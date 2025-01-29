//
//  ChatMessageBuilder.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

import Foundation

@resultBuilder
public struct ChatMessageBuilder {
  public static func buildBlock(_ components: ChatMessageRequest...) -> [ChatMessageRequest] {
    components
  }
  
  public static func buildArray(_ components: [[ChatMessageRequest]]) -> [ChatMessageRequest] {
    components.flatMap { $0 }
  }
  
  public static func buildOptional(_ component: [ChatMessageRequest]?) -> [ChatMessageRequest] {
    component ?? []
  }
}
