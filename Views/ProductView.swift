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
    
    
    var body: some View {
        HStack {
            Image(product.id)
//                .resizable()
//                .scaledToFit()
                .cornerRadius(8)
//                .frame(width: 80, height: 80)
                .padding(.vertical, 8)
                .padding(.horizontal)
            if purchasingEnabled {
                productDetail
                Spacer()
                buyButton
                    .disabled(isPurchased)
            }
            else {
                productDetail
            }
        }
        .alert(isPresented: $isShowingError, content: {
            Alert(title: Text(errorTitle), message: nil, dismissButton: .default(Text("Zamknij")))
        })
        
        
    }
    
    @ViewBuilder
    var productDetail: some View {
        VStack(alignment: .leading) {
            Text(product.displayName)
                .bold()
            Text(product.description)
                .font(.caption)
        }
    }
    
    var buyButton: some View {
        Button(action: {
            Task {
                await buy()
            }
        }) {
            
            if isPurchased {
                ownedButton
                
            }
            else {
                Text(product.displayPrice)
                    .bold()
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(Color.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
        }
//        .frame(maxWidth: 100)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear() {
            Task {
                isPurchased = (try? await store.isPurchased(product)) ?? false
            }
        }
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

//struct ProductView_Previews: PreviewProvider {
//    let product: Product
//    static var previews: some View {
//        ProductView(product: )
//    }
//}
