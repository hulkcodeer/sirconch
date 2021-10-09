//
//  sirconchApp.swift
//  sirconch
//
//  Created by 박현진 on 2021/10/09.
//

import SwiftUI
import AppTrackingTransparency

@main
struct sirconchApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
        }.onChange(of: scenePhase) { appLifeCycle in
            switch appLifeCycle {
            case .active:
                print("active")                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        switch status {
                        case .authorized:
                            print("authorized")
                        case .denied:
                            print("denied")
                        case .notDetermined:
                            print("notDetermined")
                        case .restricted:
                            print("restricted")
                        default: break
                        }
                    }
                }
            case .background:
                print("background")
            case .inactive:
                print("inactive")
            @unknown default:
                fatalError()
            }
        }
    }
}
