//
//  ADBanner.swift
//  testUI
//
//  Created by MADRAFi on 19/08/2022.
//  Copyright © 2022 MADsoft. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final class ADBanner: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: GADAdSizeBanner)

        let viewController = UIViewController()

        view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
