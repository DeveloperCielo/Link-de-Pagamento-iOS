import Foundation

public struct AccessToken: Codable {
    public let accessToken, tokenType, expiresIn: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
