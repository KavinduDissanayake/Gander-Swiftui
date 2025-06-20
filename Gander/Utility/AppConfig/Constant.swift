//
//  Constant.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

struct Constant {
    enum Environment {
        case staging
        case qa
        case dev
        case prod
    }

    static let environment: Environment = .dev

    static func isLoggingEnabled() -> Bool {
        switch environment {
        case .staging, .qa, .dev:
            return true
        case .prod:
            return false
        }
    }
    
    static var anthropicAPIKey: String {
        switch environment {
        case .staging:
            return "sk-staging-key"
        case .qa:
            return "sk-qa-key"
        case .dev:
            return "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"
        case .prod:
            return "sk-prod-key"
        }
    }

    static let factCheckPromptTemplate = """
    You are an expert fact-checking agent. Analyze the following article excerpt and determine the factual accuracy of its content.

    Headline: "{headline}"
    Body: "{body}"

    Respond with one of the following classifications:
    - VERIFIED (if the information is accurate and supported by credible sources)
    - UNVERIFIED (if the information cannot be confirmed or lacks reliable sources)
    - MISINTERPRETATION (if the content misrepresents or distorts facts)

    Then provide:
    1. A short rationale for your classification (2–3 sentences).
    2. List any specific factual claims that were verified or disputed.
    3. Provide a list of sources used, including display metadata.

    Respond strictly in the following JSON format:

    {
      "status": "VERIFIED" | "UNVERIFIED" | "MISINTERPRETATION",
      "rationale": "Short explanation of why this classification was chosen.",
      "sources": [
        {
          "title": "Article Title",
          "date": "WEDNESDAY, 19 JUNE 2025",
          "sourceImageURL": "https://example.com/logo.jpg",
          "thumbnailImageURL": "https://example.com/thumbnail.jpg",
          "url": "https://example.com/article"
        }
      ]
    }
    """
}

extension Constant {
    static func factCheckPrompt(headline: String, body: String) -> String {
        return factCheckPromptTemplate
            .replacingOccurrences(of: "{headline}", with: headline)
            .replacingOccurrences(of: "{body}", with: body)
    }
}
