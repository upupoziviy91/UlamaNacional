import SwiftUI

struct ContentView: View {
    @StateObject private var matchStore = MatchStore()
    @State private var selectedTab = ScreenshotArguments.initialTab
    @AppStorage("app.language") private var languageRawValue = AppLanguage.english.rawValue
    @AppStorage("onboarding.completed") private var onboardingCompleted = false

    private var language: AppLanguage {
        AppLanguage.from(languageRawValue)
    }

    private var shouldShowOnboarding: Bool {
        !onboardingCompleted || ScreenshotArguments.showsOnboarding
    }

    var body: some View {
        Group {
            if shouldShowOnboarding {
                OnboardingView {
                    onboardingCompleted = true
                }
            } else {
                mainTabs
            }
        }
        .preferredColorScheme(.dark)
    }

    private var mainTabs: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag(AppTab.home)
                .tabItem {
                    Label(Copy.homeTab(language), systemImage: "sportscourt")
                }

            MatchCenterView()
                .environmentObject(matchStore)
                .tag(AppTab.score)
                .tabItem {
                    Label {
                        Text(Copy.scoreTab(language))
                    } icon: {
                        Image("ScoreTabIcon")
                    }
                }

            TrainingView()
                .tag(AppTab.training)
                .tabItem {
                    Label(Copy.trainingTab(language), systemImage: "figure.strengthtraining.traditional")
                }

            CultureView()
                .environmentObject(matchStore)
                .tag(AppTab.national)
                .tabItem {
                    Label(Copy.nationalTab(language), systemImage: "flag")
                }
        }
        .tint(BrandPalette.yellow)
    }
}

enum AppTab: String {
    case home
    case score
    case training
    case national
}

private enum ScreenshotArguments {
    static let showsOnboarding = ProcessInfo.processInfo.arguments.contains("-showOnboarding")

    static var initialTab: AppTab {
        let arguments = ProcessInfo.processInfo.arguments
        guard let index = arguments.firstIndex(of: "-screenshotTab"),
              arguments.indices.contains(index + 1),
              let tab = AppTab(rawValue: arguments[index + 1]) else {
            return .home
        }
        return tab
    }
}
