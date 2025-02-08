//
//  DeepSeekModelsList.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 08.02.25.
//

public struct DeepSeekModelsList: Decodable {
  public let object: String
  public let models: [DeepSeekModelObject]
  
  enum CodingKeys: String, CodingKey {
    case models = "data"
    case object
  }
}

public struct DeepSeekModelObject: Decodable {
  public let id: String
  public let object: String
  public let ownedBy: String
  
  private enum CodingKeys: String, CodingKey {
    case id, object
    case ownedBy = "owned_by"
  }
}
