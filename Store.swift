//
//  Store.swift
//  Sternik
//
//  Created by MADRAFi on 20/08/2022.
//

import Foundation
import SwiftUI
import StoreKit


class ViewModel: ObservableObject {
    
    var products: [Product] = []
    
    func fetchProducts() async {
            do {
                let products = try await Product.products(for: ["MADsoft.Radio-Operator"])
                self.products = products
                print(products)

            }
            catch {
                print (error)
            }
    }
    
    func purchase(product: Product) async {
        do {
            try await product.purchase()
        }
        catch {
            print(error)
        }
    }
}
