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
            
            
            
            let sdkName = "PaymentLink-iOS"
            guard let bundle = Bundle(identifier: "com.jnazario.CieloPaymentLink") else {
                completion(.failure(.BadRequest(error: "Não foi possível obter o número da versão para registro no servidor.")))
                return
            }
            
            guard let buildVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String else {
                completion(.failure(.BadRequest(error: "Não foi possível obter o número da versão para registro no servidor.")))
                return
            }
            
            urlRequest.addValue("\(sdkName)@\(buildVersion)", forHTTPHeaderField: "x-sdk-version")
            
            APICaller<ProductModel>().execute(urlRequest: urlRequest) { result in
                completion(result)
            }
        }
    }
}
