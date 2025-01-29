//
//  DeepSeekRequestSerializer.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

import Foundation

@available(iOS 15.0, *)
public struct DeepSeekRequestSerializer: Sendable {
  private let configuration: Configuration
  
  public init(configuration: Configuration) {
    self.configuration = configuration
  }
  
  public func serializeChatMessageRequest(
    messages: [ChatMessageRequest],
    model: DeepSeekModel,
    parameters: ChatParameters?
  ) throws -> URLRequest {
    guard let url = URL(string: "\(configuration.baseURL)/chat/completions") else {
      throw DeepSeekError.invalidUrl(message: "Invalid Url for DeepSeek completion endpoint")
    }
    
    // Create request with common headers
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Bearer \(configuration.apiKey)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let requestBody = parameters
    
    do {
      request.httpBody = try JSONEncoder().encode(requestBody)
    } catch {
      throw DeepSeekError.encodingError(error)
    }
    
    return request
  }
}
