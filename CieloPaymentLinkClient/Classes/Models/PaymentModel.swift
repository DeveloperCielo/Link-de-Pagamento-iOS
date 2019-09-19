import Foundation

public struct ProductModel: Codable {
    public let id: UUID?
    public let name: String
    public let softDescriptor, description, expirationDate, shortUrl: String?
    public let type: ProductType
    public let showDescription: Bool
    public let price: Int
    public let weight, maxNumberOfInstallments: Int?
    public let shipping: Shipping?
    public let links: [Link]?
    
    public init(name: String, description: String? = nil, showDescription: Bool = false, price: Int, expirationDate: Date? = nil, softDescriptor: String? = nil, weight: Int? = nil, maxNumberOfInstallments: Int? = nil, type: ProductType,
                shipping: Shipping?){
        
        self.type = type
        self.name = name
        self.description = description
        self.showDescription = showDescription
        self.price = price
        
        self.softDescriptor = softDescriptor
        self.weight = weight
        self.maxNumberOfInstallments = maxNumberOfInstallments
        self.shipping = shipping
        
        if let date = expirationDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            self.expirationDate = dateFormatter.string(from: date)
        } else {
            self.expirationDate = nil
        }
        
        self.id = nil
        self.links = nil
        self.shortUrl = nil
    }
}

public struct Link: Codable {
    public let method, rel: String
    public let href: String
}

public struct Shipping: Codable {
    public let name: String?
    public let shippingPrice: Int?
    public let originZipcode: String?
    public let type: ShippingType
    
    public init(type: ShippingType, name: String? = nil, shippingPrice: Int? = nil, originZipcode: String? = nil){
        self.name = name
        self.shippingPrice = shippingPrice
        self.originZipcode = originZipcode
        self.type = type
    }
}

public struct Recurrent: Codable {
    public let interval: RecurrentInterval
    public let endDate: String?
    
    public init(interval: RecurrentInterval, endDate: Date? = nil){
        self.interval = interval
        
        if let date = endDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            self.endDate = dateFormatter.string(from: date)
        } else {
            self.endDate = nil
        }
    }
}

public enum ProductType: String, Codable {
    case asset = "Asset"
    case digital = "Digital"
    case service = "Service"
    case payment = "Payment"
    case recurrent = "Recurrent"
}

public enum ShippingType: String, Codable {
    case correios = "Correios"
    case fixedAmount = "FixedAmount"
    case free = "Free"
    case withoutShippingPickUp = "WithoutShippingPickUp"
    case withoutShipping = "WithoutShipping"
}

public enum RecurrentInterval: String, Codable {
    case monthly = "Monthly"
    case bimonthly = "Bimonthly"
    case quarterly = "Quarterly"
    case semiAnnual = "SemiAnnual"
    case annual = "Annual"
}
