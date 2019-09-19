# Link-de-Pagamento-iOS

SDK do Link de Pagamento para iOS, feito com Swift

## Principais recursos

* [x] Autenticação no oAuth
* [x] Crianção do link de pagamento
  * [x] De todos os tipos de produtos
  * [x] Com todos os tipos de entrega
  * [x] Com recorrência
  
## Instalação

Para instalar adicione a seguinte linha no seu `PodFile`:
```ruby
pod "CieloPaymentLinkApiClient"
````
## Uso

Para utilizar o SDK é necessário importar o módulo **CieloPaymentLinkClient**, e então utilizar o **PaymentLinkClient** conforme o exemplo abaixo:

```swift
import UIKit
import CieloPaymentLinkClient

class ViewController: UIViewController {

    ...

    @IBAction func createLinkTouched(_ sender: Any) {
        let credentials = Credentials(
            clientId: "ClientId",
            clientSecret: "ClientSecret")
        
        let product = ProductModel(
            name: "Teste Product",
            description: "The incredible test product",
            showDescription: true,
            price: 39999,
            weight: 400,
            type: ProductType.asset,
            shipping: Shipping(type: ShippingType.free)
        )
        
        let client = PaymentLinkClient(credentials: credentials, environment: Environment.sandbox)
        
        client.CreateLink(product: product){ result in
            switch result{
            case .success(let product):
                DispatchQueue.main.async {
                    self.linkLabel.text = product.shortUrl
                }
                
            case .failure(.BadRequest(let error)):
                print(error ?? "No body for badrequest")
                
            default:
                print("Something bad happened!")
            }
            
        }
    }
}

```

O *Enum* de erro possui as seguintes opções:

* HttpStatusError(status: Int)
* BadRequest(error: String?)
* InternalError
* Unauthorized
* DecodingError
* EncodingError
* EmptyResponseBody

## Manual

Para mais informações sobre a integração com a API de Link de Pagamentos, vide o manual em: [Link de Pagamento] (https://developercielo.github.io/manual/linkdepagamentos5)
