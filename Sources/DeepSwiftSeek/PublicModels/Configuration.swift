//
//  Configuration.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

import Foundation

public struct Configuration: Sendable {
  let apiKey: String
  let baseURL: URL
  let timeout: TimeInterval
  let defaultHeaders: [String: String]
  
  public init(
    apiKey: String,
    baseURL: URL = URL(string: "https://api.deepseek.com/v1")!,
    timeout: TimeInterval = 60,
    defaultHeaders: [String: String] = [:]
  ) {
    self.apiKey = apiKey
    self.baseURL = baseURL
    self.timeout = timeout
    self.defaultHeaders = defaultHeaders
  }

}
