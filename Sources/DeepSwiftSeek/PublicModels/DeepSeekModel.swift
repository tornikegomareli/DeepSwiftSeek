import Foundation

public enum DeepSeekModel: String, Sendable, CaseIterable {
  /// The DeepSeek-V3 model optimized for chat interactions.
  ///
  /// - Note: This model has been upgraded to DeepSeek-V3.
  /// - Important: If `max_tokens` is not specified, the default maximum output length is 4,000 tokens. Adjust this parameter as needed for longer outputs.
  /// - Context Caching: For implementation details, see **DeepSeek Context Caching** documentation.
  /// - Pricing: Discounted pricing is available until **February 8, 2025, 16:00 UTC**. After this date, the price will revert to the original non-discounted rate.
  case deepSeekChat = "deepseek-chat"
  
  /// The DeepSeek-R1 model designed for complex reasoning tasks, providing Chain of Thought (CoT) reasoning before the final answer.
  ///
  /// - Note: This model outputs Chain of Thought (CoT) reasoning content prior to delivering the final answer. For more details, refer to the **Reasoning Model** documentation.
  /// - Important: The total output token count includes both CoT reasoning and the final answer tokens, which are priced equally.
  /// - Important: If `max_tokens` is not specified, the default maximum output length is 4,000 tokens. Adjust this parameter to support longer outputs.
  /// - Context Caching: For implementation details, see **DeepSeek Context Caching** documentation.
  /// - Pricing: This model is **not included** in the promotional discount and is always charged at the original price.
  case deepSeekReasoner = "deepseek-reasoner"
}
