//
//  Sushi_LaneApp.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

import SwiftUI
import Factory

@main
struct Sushi_LaneApp: App {

    var body: some Scene {
        WindowGroup {
            if XCTIsTesting == false {
                NavigationStack {
                    SushiLaneView(viewModel: Container.shared.sushiLaneViewModel.resolve())
                }
            }
        }
    }

    private var XCTIsTesting: Bool {
        ProcessInfo.processInfo.environment.keys.contains("XCTestBundlePath")
        || ProcessInfo.processInfo.environment.keys.contains("XCTestConfigurationFilePath")
        || ProcessInfo.processInfo.environment.keys.contains("XCTestSessionIdentifier")
        || (ProcessInfo.processInfo.arguments.first
            .flatMap(URL.init(fileURLWithPath:))
            .map { $0.lastPathComponent == "xctest" || $0.pathExtension == "xctest" }
            ?? false)
    }
}
