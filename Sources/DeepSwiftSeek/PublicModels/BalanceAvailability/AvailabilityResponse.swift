//
//  AvailabilityResponse.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 09.02.25.
//

import Foundation

public struct AvailabilityResponse: Codable {
  public let isAvailable: Bool
  public let balanceInfos: [BalanceInfo]
  
  enum CodingKeys: String, CodingKey {
    case isAvailable = "is_available"
    case balanceInfos = "balance_infos"
  }
}

public struct BalanceInfo: Codable {
  public let currency: String
  public let totalBalance: String
  public let grantedBalance: String
  public let toppedUpBalance: String
  
  enum CodingKeys: String, CodingKey {
    case currency
    case totalBalance = "total_balance"
    case grantedBalance = "granted_balance"
    case toppedUpBalance = "topped_up_balance"
  }
}
