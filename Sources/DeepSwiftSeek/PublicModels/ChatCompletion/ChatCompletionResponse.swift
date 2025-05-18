//
//  ChatCompletionResponse.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

public struct ChatCompletionResponse: Codable {
  public let id: String
  public let choices: [ChoiceResponse]
  public let created: Int
  public let model: String
  public let systemFingerprint: String
  public let object: String
  public let usage: Usage?
  
  enum CodingKeys: String, CodingKey {
    case id
    case choices
    case created
    case model
    case systemFingerprint = "system_fingerprint"
    case object
    case usage
  }
}
