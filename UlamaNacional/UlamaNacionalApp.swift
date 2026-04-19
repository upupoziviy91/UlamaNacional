import SwiftUI

@main
struct UlamaNacionalApp: App {
    var body: some Scene {
        WindowGroup {
            AnalyticsGateView(
                config: .ulamaNacional,
                requestReviewBeforeCheck: false
            ) {
                ContentView()
            }
        }
    }
}
