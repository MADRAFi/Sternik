//
//  ZoomImageView.swift
//  Sternik
//
//  Created by MADRAFi on 05/09/2022.
//

import SwiftUI

struct ZoomImageView: View {
    
    @State var image: String
    @GestureState var scale = 1.0
    var magnification: some Gesture {
        MagnificationGesture()
            .updating($scale) { currentState, pastState, transaction in
                pastState = currentState
            }
    }
    var body: some View {
        VStack {
            Text("Podgląd")
//                .font(.title2)
                .padding()
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale)
                .gesture(magnification)
        
        }
    }
}

struct ZoomImageView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomImageView(image: "a_q135")
    }
}
