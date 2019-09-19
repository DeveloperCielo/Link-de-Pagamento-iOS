
import Foundation

public enum Environment{
    case production
    case sandbox
}

/// Handles authentication and payment link creation
public class PaymentLinkClient {
    let sandboxUrl = URL(string: "https://meucheckoutsandbox.braspag.com.br/api/public/")!
    let productionUrl = URL(string: "https://cieloecommerce.cielo.com.br/api/public/")!
    
    let credentials: Credentials
    let environment: Environment
    
    ///
    public init(credentials: Credentials, environment: Environment){
        self.credentials = credentials
        self.environment = environment
    }
    
    /**
    Creates the payment link.
     
     - Parameter product: the product to be created
    */
    public func CreateLink(product: ProductModel, _ completion: @escaping (Result<ProductModel, APIError>) -> Void)
    {
        let url = (environment == Environment.production ? productionUrl : sandboxUrl)
        
        AuthenticationService().getAccessToken(credentials: credentials, url: url){ result in
            switch result{
            case .success(let at):
                self.createProduct(accessToken: at, product: product, url: url, completion)
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func createProduct(accessToken: AccessToken, product: ProductModel, url: URL,
                       _ completion: @escaping (Result<ProductModel, APIError>) -> Void) {
        
        ProductService().createProduct(accessToken: accessToken, product: product, url: url, completion: completion)
        
    }
}
