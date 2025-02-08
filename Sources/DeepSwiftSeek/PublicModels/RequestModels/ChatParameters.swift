//
//  ChatParameters.swift
//  DeepSwiftSeek
//
//  Created by Tornike Gomareli on 29.01.25.
//


public struct ChatParameters: Codable, Sendable {
  var messages: [ChatMessageRequest] = []
  var model: String
  let frequencyPenalty: Double?
  let maxTokens: Int?
  let presencePenalty: Double?
  let responseFormat: ResponseFormat?
  let stop: [String]?
  let stream: Bool?
  let streamOptions: StreamOptions?
  let temperature: Double?
  let topP: Double?
  let tools: [Tool]?
  let toolChoice: ToolChoice?
  let logprobs: Bool?
  let topLogprobs: Int?
  
  public init(messages: [ChatMessageRequest] = [], chatModel: DeepSeekModel = .deepSeekChat,frequencyPenalty: Double?, maxTokens: Int?, presencePenalty: Double?, responseFormat: ResponseFormat?, stop: [String]?, stream: Bool?, streamOptions: StreamOptions?, temperature: Double?, topP: Double?, tools: [Tool]?, toolChoice: ToolChoice?, logprobs: Bool?, topLogprobs: Int?) {
    self.messages = messages
    self.model = chatModel.rawValue
    self.frequencyPenalty = frequencyPenalty
    self.maxTokens = maxTokens
    self.presencePenalty = presencePenalty
    self.responseFormat = responseFormat
    self.stop = stop
    self.stream = stream
    self.streamOptions = streamOptions
    self.temperature = temperature
    self.topP = topP
    self.tools = tools
    self.toolChoice = toolChoice
    self.logprobs = logprobs
    self.topLogprobs = topLogprobs
  }
  
  enum CodingKeys: String, CodingKey {
    case frequencyPenalty = "frequency_penalty"
    case maxTokens = "max_tokens"
    case presencePenalty = "presence_penalty"
    case responseFormat = "response_format"
    case stop
    case stream
    case streamOptions = "stream_options"
    case temperature
    case topP = "top_p"
    case tools
    case toolChoice = "tool_choice"
    case logprobs
    case topLogprobs = "top_logprobs"
    case model
    case messages
  }
  
  // MARK: - Static Defaults
  
  /// Default parameters optimized for creative and varied responses
  public static let creative = ChatParameters(
    frequencyPenalty: 0.7,
    maxTokens: 2048,
    presencePenalty: 0.7,
    responseFormat: nil,
    stop: nil,
    stream: false,
    streamOptions: nil,
    temperature: 0.9,
    topP: 0.9,
    tools: nil,
    toolChoice: nil,
    logprobs: nil,
    topLogprobs: nil
  )
  
  /// Default parameters optimized for focused and deterministic responses
  public static let focused = ChatParameters(
    frequencyPenalty: 0.3,
    maxTokens: 2048,
    presencePenalty: 0.3,
    responseFormat: nil,
    stop: nil,
    stream: false,
    streamOptions: nil,
    temperature: 0.3,
    topP: 0.3,
    tools: nil,
    toolChoice: nil,
    logprobs: nil,
    topLogprobs: nil
  )
  
  /// Default parameters for streaming responses
  public static let streaming = ChatParameters(
    frequencyPenalty: 0.5,
    maxTokens: 4096,
    presencePenalty: 0.5,
    responseFormat: nil,
    stop: nil,
    stream: true,
    streamOptions: nil,
    temperature: 0.7,
    topP: 0.9,
    tools: nil,
    toolChoice: nil,
    logprobs: nil,
    topLogprobs: nil
  )
  
  /// Default parameters for code generation
  public static let codeGeneration = ChatParameters(
    frequencyPenalty: 0.2,
    maxTokens: 2048,
    presencePenalty: 0.2,
    responseFormat: nil,
    stop: ["\n\n", "```"],
    stream: false,
    streamOptions: nil,
    temperature: 0.2,
    topP: 0.95,
    tools: nil,
    toolChoice: nil,
    logprobs: nil,
    topLogprobs: nil
  )
  
  /// Default parameters for short, concise responses
  public static let concise = ChatParameters(
    frequencyPenalty: 0.5,
    maxTokens: 256,
    presencePenalty: 0.5,
    responseFormat: nil,
    stop: nil,
    stream: false,
    streamOptions: nil,
    temperature: 0.5,
    topP: 0.5,
    tools: nil,
    toolChoice: nil,
    logprobs: nil,
    topLogprobs: nil
  )
  
  // MARK: - Instance Methods
  
  /// Creates a new instance with stream enabled/disabled
  public func withStream(_ enabled: Bool) -> ChatParameters {
    ChatParameters(
      frequencyPenalty: self.frequencyPenalty,
      maxTokens: self.maxTokens,
      presencePenalty: self.presencePenalty,
      responseFormat: self.responseFormat,
      stop: self.stop,
      stream: enabled,
      streamOptions: self.streamOptions,
      temperature: self.temperature,
      topP: self.topP,
      tools: self.tools,
      toolChoice: self.toolChoice,
      logprobs: self.logprobs,
      topLogprobs: self.topLogprobs
    )
  }
  
  public func withMessages(_ messages: [ChatMessageRequest]) -> ChatParameters {
    ChatParameters(
      messages: messages,
      chatModel: DeepSeekModel(rawValue: self.model) ?? .deepSeekChat,
      frequencyPenalty: self.frequencyPenalty,
      maxTokens: self.maxTokens,
      presencePenalty: self.presencePenalty,
      responseFormat: self.responseFormat,
      stop: self.stop,
      stream: self.stream,
      streamOptions: self.streamOptions,
      temperature: self.temperature,
      topP: self.topP,
      tools: self.tools,
      toolChoice: self.toolChoice,
      logprobs: self.logprobs,
      topLogprobs: self.topLogprobs
    )
  }
  
  public func withModel(_ model: DeepSeekModel) -> ChatParameters {
    ChatParameters(
      messages: self.messages,
      chatModel: model,
      frequencyPenalty: self.frequencyPenalty,
      maxTokens: self.maxTokens,
      presencePenalty: self.presencePenalty,
      responseFormat: self.responseFormat,
      stop: self.stop,
      stream: self.stream,
      streamOptions: self.streamOptions,
      temperature: self.temperature,
      topP: self.topP,
      tools: self.tools,
      toolChoice: self.toolChoice,
      logprobs: self.logprobs,
      topLogprobs: self.topLogprobs
    )
  }
  
  /// Creates a new instance with modified max tokens
  public func withMaxTokens(_ tokens: Int) -> ChatParameters {
    ChatParameters(
      frequencyPenalty: self.frequencyPenalty,
      maxTokens: tokens,
      presencePenalty: self.presencePenalty,
      responseFormat: self.responseFormat,
      stop: self.stop,
      stream: self.stream,
      streamOptions: self.streamOptions,
      temperature: self.temperature,
      topP: self.topP,
      tools: self.tools,
      toolChoice: self.toolChoice,
      logprobs: self.logprobs,
      topLogprobs: self.topLogprobs
    )
  }
  
  /// Creates a new instance with modified temperature
  public func withTemperature(_ temp: Double) -> ChatParameters {
    ChatParameters(
      frequencyPenalty: self.frequencyPenalty,
      maxTokens: self.maxTokens,
      presencePenalty: self.presencePenalty,
      responseFormat: self.responseFormat,
      stop: self.stop,
      stream: self.stream,
      streamOptions: self.streamOptions,
      temperature: temp,
      topP: self.topP,
      tools: self.tools,
      toolChoice: self.toolChoice,
      logprobs: self.logprobs,
      topLogprobs: self.topLogprobs
    )
  }
}
