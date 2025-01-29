//
//  DeepSeekService.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

@available(iOS 13.0.0, *)
public protocol DeepSeekService {
  func chatCompletions(
    @ChatMessageBuilder messages: () -> [ChatMessageRequest],
    model: DeepSeekModel,
    parameters: ChatParameters?
  ) async throws -> ChatCompletionResponse
}
