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
            Image("Icon_Learn")
                .padding(.vertical, 8)
                .padding(.trailing)
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
//            Text(product.id)
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
            Text(Image(systemName: "checkmark"))
                .bold()
                .foregroundColor(Color.primary)
//                .clipShape(Capsule())
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .background(Color("Positive"))
//                .frame(maxWidth: .infinity)
          }
            else {
                Text(product.displayPrice)
                    .bold()
                    .foregroundColor(Color.primary)
//                    .clipShape(Capsule())
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .background(Color("AccentColor"))
//                    .frame(maxWidth: .infinity)
            }
          
        }

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
