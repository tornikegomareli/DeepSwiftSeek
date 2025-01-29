//
//  DeepSeekService.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

import Foundation

@available(iOS 13.0.0, *)
public protocol DeepSeekService {
  func chatCompletions(
    @ChatMessageBuilder messages: () -> [ChatMessageRequest],
    model: DeepSeekModel,
    parameters: ChatParameters?
  ) async throws -> ChatCompletionResponse
}

@available(iOS 13.0.0, *)
public final class DeepSeekClient: DeepSeekService {
  private let configuration: Configuration
  private let session: URLSession
  
  public init(configuration: Configuration, session: URLSession = .shared) {
    self.configuration = configuration
    self.session = session
  }
  
  public func chatCompletions(messages: () -> [ChatMessageRequest], model: DeepSeekModel, parameters: ChatParameters?) async throws -> ChatCompletionResponse {
    guard let url = URL(string: "\(configuration.baseURL)/chat/completions") else {
      throw DeepSeekError.invalidUrl(message: "Invalid Url for DeepSeek completion endpoint")
    }
    
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
    
    let (data, response) = try await session.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw DeepSeekError.invalidFormat(message: "Invalid Response from the server")
    }
    
    guard (200...299).contains(httpResponse.statusCode) else {
      if let errorResponse = try? JSONDecoder().decode(DeepSeekErrorResponse.self, from: data) {
        throw DeepSeekError.from(errorResponse, statusCode: httpResponse.statusCode)
      }
      
      throw DeepSeekError.unknown(statusCode: httpResponse.statusCode, message: "Decoding error of the DeepSeek Response")
    }
    
    do {
      let decoder = JSONDecoder()
      return try decoder.decode(ChatCompletionResponse.self, from: data)
    } catch {
      throw DeepSeekError.unknown(statusCode: httpResponse.statusCode, message: "Decoding error of the DeepSeek Response")
    }
  }
}
