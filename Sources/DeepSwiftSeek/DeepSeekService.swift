//
//  DeepSeekService.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

import Foundation

// TODO: Reasoning model, chain of thoughts.
// TODO: Create Facade for Chats and Contexts and History
// TODO: Make API cleaner and simpler to use
// TODO: Builder
// TODO: Example SwiftUI App.

@available(iOS 15.0, *)
public protocol DeepSeekService {
  func chatCompletions(
    @ChatMessageBuilder messages: () -> [ChatMessageRequest],
    model: DeepSeekModel,
    parameters: ChatParameters
  ) async throws -> ChatCompletionResponse
  
  func chatCompletionStream(
    @ChatMessageBuilder messages: () -> [ChatMessageRequest],
    model: DeepSeekModel,
    parameters: ChatParameters
  ) async throws -> AsyncThrowingStream<String, Error>
}

/// TODO: Need to add streaming support
@available(iOS 15.0, *)
public final class DeepSeekClient: DeepSeekService, Sendable {
  private let configuration: Configuration
  private let session: URLSession
  private let serializer: DeepSeekRequestSerializer
  
  public init(configuration: Configuration, session: URLSession = .shared) {
    self.configuration = configuration
    self.session = session
    self.serializer = DeepSeekRequestSerializer(configuration: configuration)
  }
  
  @available(iOS 15.0, *)
  public func chatCompletionStream(
    messages: () -> [ChatMessageRequest],
    model: DeepSeekModel,
    parameters: ChatParameters
  ) async throws -> AsyncThrowingStream<String, any Error> {
    let streamParameters = parameters.withStream(true)
    
    let request = try serializer.serializeChatMessageRequest(
      messages: messages(),
      model: model,
      parameters: streamParameters
    )
    
    return AsyncThrowingStream { @Sendable continuation in
      Task {
        do {
          let (bytes, response) = try await session.bytes(for: request)
          
          guard let httpResponse = response as? HTTPURLResponse else {
            continuation.finish(throwing: DeepSeekError.invalidFormat(message: "Invalid Response from the server"))
            return
          }
          
          guard (200...299).contains(httpResponse.statusCode) else {
            var errorData = Data()
            for try await byte in bytes {
              errorData.append(byte)
            }
            
            if let errorResponse = try? JSONDecoder().decode(DeepSeekErrorResponse.self, from: errorData) {
              continuation.finish(throwing: DeepSeekError.from(errorResponse, statusCode: httpResponse.statusCode))
            } else {
              continuation.finish(throwing: DeepSeekError.unknown(statusCode: httpResponse.statusCode, message: "Unknown streaming error"))
            }
            return
          }
          
          for try await line in bytes.lines {
            guard !line.isEmpty else { continue }
            
            if line.contains("[DONE]") {
              continuation.finish()
              return
            }
            
            let jsonString = line.hasPrefix("data: ") ? String(line.dropFirst(6)) : line
            
            if let data = jsonString.data(using: .utf8),
               let streamResponse = try? JSONDecoder().decode(ChatCompletionResponse.self, from: data)
            {
              let content = streamResponse.choices[0].message.content
              continuation.yield(content)
            }
          }
          
          continuation.finish()
        } catch {
          continuation.finish(throwing: error)
        }
      }
    }
  }
  
  public func chatCompletions(
    messages: () -> [ChatMessageRequest],
    model: DeepSeekModel,
    parameters: ChatParameters
  ) async throws -> ChatCompletionResponse {
    let request = try serializer.serializeChatMessageRequest(
      messages: messages(),
      model: model,
      parameters: parameters
    )
    
    do {
      let (data, response) = try await session.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw DeepSeekError.invalidFormat(message: "Invalid Response from the server")
      }
      
      guard (200...299).contains(httpResponse.statusCode) else {
        throw DeepSeekError.from(statusCode: httpResponse.statusCode, message: nil)
      }
      
      return try JSONDecoder().decode(ChatCompletionResponse.self, from: data)
    } catch {
      if let deepSeekError = error as? DeepSeekError {
        throw deepSeekError
      }
      throw DeepSeekError.unknown(statusCode: 0, message: error.localizedDescription)
    }
  }
}
