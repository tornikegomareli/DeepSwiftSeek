//
//  DeepSeekError.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

import Foundation

public enum DeepSeekError: LocalizedError {
  case invalidFormat(message: String?)
  case invalidUrl(message: String?)
  case authenticationFailed(message: String?)
  case insufficientBalance(message: String?)
  case invalidParameters(message: String?)
  case rateLimitReached(message: String?)
  case serverError(message: String?)
  case serverOverloaded(message: String?)
  case unknown(statusCode: Int, message: String?)
  case encodingError(Error)
  
  public var errorDescription: String? {
    switch self {
    case .invalidFormat(let message):
      return message ?? "Invalid request body format. Please modify your request body according to the API documentation."
    case .invalidUrl(let message):
      return message ?? "Invalid URL construction. Please check the base URL configuration."
    case .authenticationFailed(let message):
      return message ?? "Authentication failed. Please check your API key or create a new one."
    case .insufficientBalance(let message):
      return message ?? "Insufficient balance. Please check your account balance and add funds if necessary."
    case .invalidParameters(let message):
      return message ?? "Invalid parameters in request. Please check the API documentation for correct parameter usage."
    case .rateLimitReached(let message):
      return message ?? "Rate limit reached. Please pace your requests or consider using alternative providers."
    case .serverError(let message):
      return message ?? "Server error occurred. Please retry after a brief wait."
    case .serverOverloaded(let message):
      return message ?? "Server is currently overloaded. Please retry after a brief wait."
    case .unknown(let statusCode, let message):
      return message ?? "Unknown error occurred with status code: \(statusCode)"
    case .encodingError(let error):
      return "Failed to encode request: \(error.localizedDescription)"
    }
  }
  
  public var failureReason: String? {
    switch self {
    case .invalidFormat:
      return "Invalid request body format"
    case .invalidUrl:
      return "Failed to construct valid URL from base URL"
    case .authenticationFailed:
      return "Authentication fails due to wrong API key"
    case .insufficientBalance:
      return "Run out of balance"
    case .invalidParameters:
      return "Request contains invalid parameters"
    case .rateLimitReached:
      return "Sending requests too quickly"
    case .serverError:
      return "Server encounters an issue"
    case .serverOverloaded:
      return "Server is overloaded due to high traffic"
    case .encodingError:
      return "Failed to encode request body to JSON"
    case .unknown:
      return "Unknown error occurred"
    }
  }
  
  public var recoverySuggestion: String? {
    switch self {
    case .invalidFormat:
      return "Please modify your request body according to the DeepSeek API Docs."
    case .invalidUrl:
      return "Please check your base URL configuration and ensure it's properly formatted."
    case .authenticationFailed:
      return "Please check your API key or create a new one if you don't have one."
    case .insufficientBalance:
      return "Please check your account's balance and go to the Top up page to add funds."
    case .invalidParameters:
      return "Please modify your request parameters according to the DeepSeek API Docs."
    case .rateLimitReached:
      return "Please pace your requests reasonably or consider switching to alternative LLM service providers."
    case .serverError:
      return "Please retry your request after a brief wait and contact support if the issue persists."
    case .serverOverloaded:
      return "Please retry your request after a brief wait."
    case .unknown:
      return "Please check the error details and try again."
    case .encodingError:
      return "Please check that all request parameters are properly formatted and contain valid data types."
    }
  }
  
  public static func from(statusCode: Int, message: String?) -> DeepSeekError {
    switch statusCode {
    case 400:
      return .invalidFormat(message: message)
    case 401:
      return .authenticationFailed(message: message)
    case 402:
      return .insufficientBalance(message: message)
    case 422:
      return .invalidParameters(message: message)
    case 429:
      return .rateLimitReached(message: message)
    case 500:
      return .serverError(message: message)
    case 503:
      return .serverOverloaded(message: message)
    default:
      return .unknown(statusCode: statusCode, message: message)
    }
  }
}
