//
//  Usage.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct Usage: Codable {
  public let completionTokens: Int
  public let promptTokens: Int
  public let promptCacheHitTokens: Int
  public let promptCacheMissTokens: Int
  public let totalTokens: Int
  public let completionTokensDetails: CompletionTokensDetails
  
  enum CodingKeys: String, CodingKey {
    case completionTokens = "completion_tokens"
    case promptTokens = "prompt_tokens"
    case promptCacheHitTokens = "prompt_cache_hit_tokens"
    case promptCacheMissTokens = "prompt_cache_miss_tokens"
    case totalTokens = "total_tokens"
    case completionTokensDetails = "completion_tokens_details"
  }
}
