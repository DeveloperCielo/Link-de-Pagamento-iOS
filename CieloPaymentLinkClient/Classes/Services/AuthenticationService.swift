import Foundation

class AuthenticationService
{
    let oAuthPath = "v2/token"
    
    func getAccessToken(credentials: Credentials,
                        url: URL,
                        completion: @escaping (Result<AccessToken, APIError>) -> Void){
        
        if let oAuthUrl = URL(string: oAuthPath, relativeTo: url)
        {
            let authorization = "Basic \(credentials.base64)"
            let body = "grant_type=client_credentials".data(using: .utf8)
            
            var urlRequest = URLRequest(url: oAuthUrl)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue(authorization, forHTTPHeaderField: "Authorization")
            urlRequest.httpBody = body
            
            APICaller<AccessToken>().execute(urlRequest: urlRequest) { result in
                completion(result)
            }
        }
    }
}
