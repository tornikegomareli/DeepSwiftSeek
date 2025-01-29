//
//  StreamOptions.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct StreamOptions: Codable {
  var includeUsage: Bool
  
  enum CodingKeys: String, CodingKey {
    case includeUsage = "include_usage"
  }
}
