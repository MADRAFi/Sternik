//
//  Store.swift
//  Sternik
//
//  Created by MADRAFi on 20/08/2022.
//

import Foundation
import SwiftUI
import StoreKit

typealias Transaction = StoreKit.Transaction
//typealias RenewalInfo = StoreKit.Product.SubscriptionInfo.RenewalInfo
//typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState


public enum StoreError: Error {
    case failedVerification
}


class Store: ObservableObject {
    
    @Published private(set) var products : [Product] = []
    @Published private(set) var purchasedProducts : [Product] = []
    
    var updateListenerTask: Task<Void, Error>? = nil
    private let productID: [String: String]
    
    init() {
        if let path = Bundle.main.path(forResource: "Products", ofType: "plist"),
            let plist = FileManager.default.contents(atPath: path) {
            productID = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String: String]) ?? [:]
        } else {
            productID = [:]
        }
        products = []
        
        updateListenerTask = listenForTransactions()
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
        
    }
    
    deinit {
        updateListenerTask?.cancel()
        
    }
  
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await self.updateCustomerProductStatus()
                    await transaction.finish()
                }
                catch {
                    print("Transaction failed verification")
                }
            }
            
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: productID.keys)
            
            for product in storeProducts {
                switch product.type {
                case .nonConsumable:
                    products.append(product)
                default:
                    print("Unknown product")
                }
            }
            
        }
        catch {
                print("Failed product request from the App Store server: \(error)")
        }
    }

    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verification):
            let transation = try checkVerified(verification)
            await updateCustomerProductStatus()
            await transation.finish()
            return transation
            
        case .userCancelled, .pending:
            return nil
            
        default:
            return nil
        }
    }
    
    func isPurchased(_ product: Product) async throws -> Bool {
        switch product.type {
        case .nonConsumable:
            return purchasedProducts.contains(product)
        default:
            return false
        }
    }
    
    func isPurchased(_ productID: String) async throws -> Bool {
//        let result = purchasedProducts.contains(where: {$0.id == productID})
//        return result
        
//        guard let fullproduct = await Transaction.currentEntitlement(for: productID) else {
//            return false
//        guard let product = products()
//        }
        guard let product = products.filter({$0.id == productID }).first else { return false }
        return purchasedProducts.contains(product)

    }
    
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    
    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedProducts: [Product] = []
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                switch transaction.productType {
                case .nonConsumable:
                    if let product = products.first(where: {$0.id == transaction.productID}) {
                        purchasedProducts.append(product)
                    }
                default:
                    break
                    
                }
            }
            catch {
                print("Error updating purchased products status")
            }
        }
        self.purchasedProducts = purchasedProducts
    }
}
