//
//  ChatParameters.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct ChatParameters: Codable {
  let frequencyPenalty: Double?
  let maxTokens: Int?
  let presencePenalty: Double?
  let responseFormat: ResponseFormat?
  let stop: [String]?
  let stream: Bool?
  let streamOptions: StreamOptions?
  let temperature: Double?
  let topP: Double?
  let tools: [Tool]?
  let toolChoice: ToolChoice?
  let logprobs: Bool?
  let topLogprobs: Int?
  
  enum CodingKeys: String, CodingKey {
    case frequencyPenalty = "frequency_penalty"
    case maxTokens = "max_tokens"
    case presencePenalty = "presence_penalty"
    case responseFormat = "response_format"
    case stop
    case stream
    case streamOptions = "stream_options"
    case temperature
    case topP = "top_p"
    case tools
    case toolChoice = "tool_choice"
    case logprobs
    case topLogprobs = "top_logprobs"
  }
}
