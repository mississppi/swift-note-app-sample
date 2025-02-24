//
//  LocalNativeSampleApp.swift
//  LocalNativeSample
//
//  Created by KOSUKE SAKURAI on 2025/02/21.
//

import SwiftUI

@main
struct LocalNativeSampleApp: App {
    @StateObject private var viewModel = PostViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
