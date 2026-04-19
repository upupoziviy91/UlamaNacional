import SwiftUI

@main
struct UlamaNacionalApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.arguments.contains("-nativeScreenshots") {
                ContentView()
            } else {
                AnalyticsGateView(
                    config: .ulamaNacional,
                    requestReviewBeforeCheck: false
                ) {
                    ContentView()
                }
            }
        }
    }
}
