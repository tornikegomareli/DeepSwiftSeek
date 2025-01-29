//
//  ChoiceResponse.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct ChoiceResponse: Codable {
  public let finishReason: String
  public let index: Int
  public let message: ChatCompletionMessageResponse
  public let logprobs: LogProbs?
  
  enum CodingKeys: String, CodingKey {
    case finishReason = "finish_reason"
    case index
    case message
    case logprobs
  }
}
