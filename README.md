<p align="center">
  <strong><span style="font-size: 24px;">DeepSeekSwift</span></strong>
</p>

<p align="center">
  <img src="https://github.com/tornikegomareli/DeepSwiftSeek/blob/main/logo.webp" alt="My Image" width="500"/>
</p>

<p align="center">
    <a href="https://platform.deepseek.com/usage">
        <img src="https://img.shields.io/badge/Readthedocs-%23000000.svg?style=for-the-badge&logo=readthedocs&logoColor=white" alt="Documentation">
    </a>
    <a href="./LICENSE">
        <img src="https://img.shields.io/github/license/Ileriayo/markdown-badges?style=for-the-badge" alt="MIT License">
    </a>
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white" alt="Swift 5.7+">
    </a>
</p>


**🚨 Due to current server resource constraints, DeepSeek temporarily suspended API service recharges to prevent any potential impact on users operations. 
Existing balances can still be used for calls.**

## Overview

DeepSeek Swift SDK is a lightweight and efficient Swift-based client for interacting with the DeepSeek API. It provides support for chat message completion, streaming, error handling, and configurating DeepSeek LLM with advanced parameters.

## Features

- Supports **chat completion** requests
- Handles **error responses** with detailed error descriptions and solving advices.
- **streaming responses**
- Built-in support for **different models and advanced parameters**
- Uses **Swift concurrency (async/await)** for network calls

## Installation

To integrate `DeepSwiftSeek` into your project, you can use **Swift Package Manager (SPM)**:

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/tornikegomareli/DeepSwiftSeek.git", from: "0.0.1")
    ]
)
```

Or add it via Xcode:
1. Open your project in Xcode.
2. Navigate to **File > Swift Packages > Add Package Dependency**.
3. Enter the repository URL.
4. Choose the latest version and click **Next**.

## Usage

### 1. Initialize the Client

```swift
import DeepSwiftSeek

let configuration = Configuration(apiKey: "YOUR_API_KEY")
let deepSeekClient = DeepSeekClient(configuration: configuration)
```

### 2. Sending a Chat Completion Request

```swift
Task {
    do {
        let response = try await deepSeekClient.chatCompletions(
            messages: {
                ChatMessageRequest(role: .user, content: "Tell me a joke.", name: "User")
            },
            model: .deepSeekChat,
            parameters: .creative
        )
        print(response.choices.first?.message.content ?? "No response")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

### 3. Streaming Chat Completions

```swift
Task {
    do {
        let stream = try await deepSeekClient.chatCompletionStream(
            messages: {
                ChatMessageRequest(role: .user, content: "Write a poem.", name: "User")
            },
            model: .deepSeekChat,
            parameters: .streaming
        )
        for try await chunk in stream {
            print(chunk) // Prints streamed responses
        }
    } catch {
        print("Streaming error: \(error.localizedDescription)")
    }
}
```

### 4. Handling Errors

The SDK provides detailed error handling:

```swift
catch let error as DeepSeekError {
    print("DeepSeek API Error: \(error.localizedDescription)")
    print("Recovery Suggestion: \(error.recoverySuggestion ?? "None")")
} catch {
    print("Unexpected error: \(error)")
}
```

## Models

DeepSeek SDK supports multiple models:

```swift
public enum DeepSeekModel: String {
    case deepSeekChat = "deepseek-chat"
    case deepSeekReasoner = "deepseek-reasoner"
}
```

## Available Parameters

You can configure chat completion parameters:

```swift
let parameters = ChatParameters(
    frequencyPenalty: 0.5,
    maxTokens: 512,
    presencePenalty: 0.5,
    temperature: 0.7,
    topP: 0.9
)
```

### Predefined Parameter Sets

| Mode         | Temperature | Max Tokens | Top P |
|-------------|------------|------------|------|
| **Creative** | 0.9 | 2048 | 0.9 |
| **Focused** | 0.3 | 2048 | 0.3 |
| **Streaming** | 0.7 | 4096 | 0.9 |
| **Code Generation** | 0.2 | 2048 | 0.95 |
| **Concise** | 0.5 | 256 | 0.5 |

### Creating Custom Predefined Parameters

If you need specific configurations, you can define your own parameter presets:

```swift
extension ChatParameters {
    static let myCustomPreset = ChatParameters(
        frequencyPenalty: 0.4,
        maxTokens: 1024,
        presencePenalty: 0.6,
        temperature: 0.8,
        topP: 0.85
    )
}
```

Then use it in your requests:

```swift
let parameters = ChatParameters.myCustomPreset
```

This approach allows you to maintain reusable configurations tailored to different needs.

## Error Handling

DeepSeek SDK has built-in error handling for various API failures:

| Error Type | Description |
|------------|-------------|
| `invalidFormat` | Invalid request body format. |
| `authenticationFailed` | Incorrect API key. |
| `insufficientBalance` | No balance remaining. |
| `rateLimitReached` | Too many requests sent. |
| `serverOverloaded` | High traffic on server. |
| `encodingError` | Failed to encode request body. |

## TODOs

- [ ] Improve documentation with more examples
- [ ] SwiftUI full demo based on chat, history and reasoning
- [ ] Reasoning model + OpenAI SDK

## License

This project is available under the MIT License.

### Disclaimer
This SDK is **not affiliated** with DeepSeek and is an independent implementation to interact with their API.

