import Foundation

public enum APIError:Error {
    case HttpStatusError(status: Int)
    case BadRequest(error: String?)
    case InternalError
    case Unauthorized
    case DecodingError
    case EncodingError
    case EmptyResponseBody
}
