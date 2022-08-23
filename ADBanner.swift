//
//  ADBanner.swift
//  testUI
//
//  Created by MADRAFi on 19/08/2022.
//  Copyright © 2022 MADsoft. All rights reserved.
//


import GoogleMobileAds
import SwiftUI
import UIKit


struct ADBanner: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> GADBannerView {
        
        
        let adview = GADBannerView(adSize: GADAdSizeBanner)
        let banner_UnitID = Bundle.main.infoDictionary?["ADBanner_UnitID"] as? String
        adview.adUnitID = banner_UnitID
        adview.rootViewController = UIApplication.shared.getRootViewController()
        adview.load(GADRequest())
        
        return adview
    }
    func updateUIView(_ uiView: GADBannerView, context: Context) {
        
    }
    
    class Coordinator: NSObject,GADBannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
          print("bannerViewDidReceiveAd")
        }

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
          print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }

        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
          print("bannerViewDidRecordImpression")
        }

        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
          print("bannerViewWillPresentScreen")
        }

        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
          print("bannerViewWillDIsmissScreen")
        }

        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
          print("bannerViewDidDismissScreen")
        }
    }
}

extension UIApplication {
    func getRootViewController() -> UIViewController {
        guard let screen = self.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
}
