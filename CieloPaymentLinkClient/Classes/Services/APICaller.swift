import Foundation

class APICaller<TResponse: Decodable>{    
    func execute(urlRequest: URLRequest, _ completion: @escaping (Result<TResponse, APIError>) -> Void){
            URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode {
                    case 200, 201:
                        completion(self.parseBody(data: data))
                    case 400:
                        if let errorBody = data{
                            completion(.failure(.BadRequest(error: String(decoding: errorBody, as: UTF8.self))))
                        } else {
                            completion(.failure(.BadRequest(error: nil)))
                        }
                        
                    default:
                        completion(.failure(.HttpStatusError(status: httpResponse.statusCode)))
                    }
                }
                }.resume()
    }
    
    func parseBody<TResponse>(data: Data?) -> Result<TResponse, APIError> where TResponse : Decodable {
        if let jsonData = data {
            do{
                let decodedData = try JSONDecoder().decode(TResponse.self, from: jsonData )
                return .success(decodedData)
            } catch {
                print("Error decoding response: \(error)")
                return .failure(.DecodingError)
            }
        } else {
            return .failure(.EmptyResponseBody)
        }
    }
}
