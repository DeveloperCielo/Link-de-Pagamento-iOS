import Foundation

public struct Credentials
{
    let clientId: String
    let clientSecret: String
    let base64: String
    
    public init(clientId: String, clientSecret: String)
    {
        self.clientId = clientId
        self.clientSecret = clientSecret
        base64 = Data("\(clientId):\(clientSecret)".utf8).base64EncodedString()
    }
}
