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
    try serializeRequest(
      endpoint: "chat/completions",
      method: "POST",
      body: parameters?.withMessages(messages)
    )
  }
  
  public func serializeFIMCompletionRequest(
    messages: [ChatMessageRequest],
    model: DeepSeekModel,
    parameters: ChatParameters?
  ) throws -> URLRequest {
    try serializeRequest(
      endpoint: "beta/completions",
      method: "POST",
      body: parameters?.withMessages(messages)
    )
  }
  
  public func serializeModelsRequest() throws -> URLRequest {
    try serializeRequestWithoutBody(
      endpoint: "models",
      method: "GET"
    )
  }
  
  private func serializeRequestWithoutBody(
    endpoint: String,
    method: String
  ) throws -> URLRequest {
    try createBaseRequest(endpoint: endpoint, method: method)
  }
  
  private func createBaseRequest(
    endpoint: String,
    method: String
  ) throws -> URLRequest {
    guard let url = URL(string: "\(configuration.baseURL)/\(endpoint)") else {
      throw DeepSeekError.invalidUrl(message: "Invalid URL for \(endpoint) endpoint")
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue("Bearer \(configuration.apiKey)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    return request
  }

  private func serializeRequest<T: Encodable>(
    endpoint: String,
    method: String,
    body: T?
  ) throws -> URLRequest {
    guard let url = URL(string: "\(configuration.baseURL)/\(endpoint)") else {
      throw DeepSeekError.invalidUrl(message: "Invalid URL for \(endpoint) endpoint")
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue("Bearer \(configuration.apiKey)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if let body = body {
      let encoder = JSONEncoder()
      encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
      let encodedData = try encoder.encode(body)
      
      if let jsonString = String(data: encodedData, encoding: .utf8) {
        print("Request Body JSON:\n\(jsonString)")
      }
      
      request.httpBody = encodedData
    }
    
    return request
  }
}
