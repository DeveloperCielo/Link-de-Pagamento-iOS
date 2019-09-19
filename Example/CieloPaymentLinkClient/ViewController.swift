//
//  ViewController.swift
//  CieloPaymentLinkClient
//
//  Created by Paulo Fernandes on 09/19/2019.
//  Copyright (c) 2019 Paulo Fernandes. All rights reserved.
//

import UIKit
import CieloPaymentLinkClient

class ViewController: UIViewController {
    @IBOutlet weak var linkLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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

