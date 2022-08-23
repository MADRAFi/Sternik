//
//  SternikApp.swift
//  Shared
//
//  Created by MADRAFi on 17/07/2022.
//

import SwiftUI
import GoogleMobileAds

@main

struct SternikApp: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
