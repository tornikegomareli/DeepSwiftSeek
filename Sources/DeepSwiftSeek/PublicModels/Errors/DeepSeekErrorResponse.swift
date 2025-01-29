//
//  DeepSeekErrorResponse.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

import Foundation

public struct DeepSeekErrorResponse: Decodable {
  public let error: ErrorDetail
  
  public struct ErrorDetail: Decodable {
    public let message: String
    public let type: String?
    public let code: String?
    
    private enum CodingKeys: String, CodingKey {
      case message
      case type
      case code
    }
  }
}
