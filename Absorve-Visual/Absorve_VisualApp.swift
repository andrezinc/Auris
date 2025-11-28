//
//  Absorve_VisualApp.swift
//  Absorve-Visual
//
//  Created by Andre Castilhano on 06/11/25.
//

import SwiftUI
import Foundation

class Constants {
    static let currentOnboardingVersion = "onboardingVersion_1.0.0"
}

@main
struct Absorve_VisualApp: App {
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false

    var body: some Scene {
        WindowGroup{
            CameraUI()
                .sheet(isPresented: .constant(!hasSeenOnboardingView)) {
                    OnBoardingView()
                }
        }
    }
}
