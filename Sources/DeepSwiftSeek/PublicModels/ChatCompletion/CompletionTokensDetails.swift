//
//  CompletionTokensDetails.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct CompletionTokensDetails: Codable {
    public let reasoningTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case reasoningTokens = "reasoning_tokens"
    }
}