import Foundation

class ProductService
{
    let oAuthPath = "v1/products"
    
    
    func createProduct(accessToken: AccessToken,
                       product: ProductModel,
                       url: URL,
                       completion: @escaping (Result<ProductModel, APIError>) -> Void){
        
        if let oAuthUrl = URL(string: oAuthPath, relativeTo: url)
        {
            let authorization = "Bearer \(accessToken.accessToken)"
            guard let body =  try? JSONEncoder().encode(product) else{
                completion(.failure(.EncodingError))
                return
            }
            
            var urlRequest = URLRequest(url: oAuthUrl)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue(authorization, forHTTPHeaderField: "Authorization")
            urlRequest.httpBody = body
            
            APICaller<ProductModel>().execute(urlRequest: urlRequest) { result in
                completion(result)
            }
        }
    }
}
