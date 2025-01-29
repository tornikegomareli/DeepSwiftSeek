//
//  Response->Error.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//

extension DeepSeekError {
  public static func from(_ errorResponse: DeepSeekErrorResponse, statusCode: Int) -> DeepSeekError {
    from(statusCode: statusCode, message: errorResponse.error.message)
  }
}
