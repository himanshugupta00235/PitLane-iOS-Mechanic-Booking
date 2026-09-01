import Foundation

enum APIError: LocalizedError {
    case networkFailure
    case decodingError
    case fileNotFound
    case serverError(statusCode: Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .networkFailure:
            return "Unable to connect. Please check your internet connection and try again."
        case .decodingError:
            return "We received unexpected data. Please try again later."
        case .fileNotFound:
            return "The requested data could not be found."
        case .serverError(let statusCode):
            return "Server error (\(statusCode)). Please try again later."
        case .unknown:
            return "Something went wrong. Please try again."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .networkFailure:
            return "Check your Wi-Fi or cellular connection."
        case .decodingError, .fileNotFound, .serverError, .unknown:
            return "Tap Retry to try again."
        }
    }
}
