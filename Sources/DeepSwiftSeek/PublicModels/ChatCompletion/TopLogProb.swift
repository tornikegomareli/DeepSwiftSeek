//
//  TopLogProb.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct TopLogProb: Codable {
    public let token: String
    public let logprob: Double
    public let bytes: [Int]
}