//
//  ProductView.swift
//  Sternik
//
//  Created by MADRAFi on 21/08/2022.
//

import SwiftUI
import StoreKit



struct ProductView: View {
    
    @EnvironmentObject var store: Store
    @State var isPurchased: Bool = false
    @State var errorTitle = ""
    @State var isShowingError: Bool = false
    
    let product: Product
    let purchasingEnabled: Bool
    
    
    init(product: Product, purchasingEnabled: Bool = true) {
        self.product = product
        self.purchasingEnabled = purchasingEnabled
    }
    
    
    func displayProduct(id: String, name: String, description: String) -> some View {
        
        return HStack {
            Image(id)
                .cornerRadius(8)
                .padding(.leading, 15)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.body)
                Text(description)
                    .font(.caption2)
            }
            Spacer()
            if purchasingEnabled {
                productButton
            }
        }
    }
    
    var body: some View {
        VStack {
            displayProduct(id: product.id, name: product.displayName, description: product.description)
        }
        .alert(isPresented: $isShowingError, content: {
            Alert(title: Text(errorTitle), message: nil, dismissButton: .default(Text("Zamknij")))
        })
        
        
    }
    
    
    var productButton: some View {
        Button(action: {
            Task {
                await buy()
            }
        }) {
            
            if isPurchased {
                ownedButton
            }
            else {
                buyButton
            }
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear() {
            Task {
                isPurchased = (try? await store.isPurchased(product)) ?? false
            }
        }
    }
    
    var buyButton: some View {
        HStack {
            Text(product.displayPrice)
                .bold()
                .font(.caption)
                .padding()
                .background(Color("AccentColor"))
                .foregroundColor(Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .disabled(isPurchased)
    }
    
    func buy() async {
        do {
            if try await store.purchase(product) != nil {
                withAnimation {
                    isPurchased = true
                }
            }
        }
        catch StoreError.failedVerification {
            errorTitle = "Twój zakup nie mogł zostć zweryfikowany przez App Store."
            isShowingError = true
        }
        catch {
            print("Failed purchase for \(product.id): \(error)")
        }
    }
}


var ownedButton: some View {
    HStack {
        Text(Image(systemName: "checkmark"))
            .bold()
            .padding()
            .background(Color("Positive"))
            .foregroundColor(Color.primary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    .padding(.vertical, 8)
    .padding(.horizontal)
    .clipShape(RoundedRectangle(cornerRadius: 10))
    .disabled(true)
}
//struct ProductView_Previews: PreviewProvider {
//    let product: Product
//    static var previews: some View {
//        ProductView(product: )
//    }
//}
