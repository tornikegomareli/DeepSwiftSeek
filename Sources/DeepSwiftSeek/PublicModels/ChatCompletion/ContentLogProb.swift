//
//  ContentLogProb.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct ContentLogProb: Codable {
    public let token: String
    public let logprob: Double
    public let bytes: [Int]
    public let topLogprobs: [TopLogProb]
    
    enum CodingKeys: String, CodingKey {
        case token
        case logprob
        case bytes
        case topLogprobs = "top_logprobs"
    }
}