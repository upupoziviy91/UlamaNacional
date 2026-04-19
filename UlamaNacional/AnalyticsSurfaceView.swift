import SwiftUI

public struct AnalyticsSurfaceView: View {
    public let config: AnalyticsLaunchConfig
    @StateObject private var model = AnalyticsSurfaceModel()

    public init(config: AnalyticsLaunchConfig) {
        self.config = config
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                AnalyticsContentRenderer(config: config, model: model)
                    .ignoresSafeArea()

                analyticsControls(topInset: proxy.safeAreaInsets.top)

                if model.isLoading {
                    ProgressView()
                        .tint(AnalyticsPresentationStyle.accent)
                        .padding(10)
                        .background(AnalyticsPresentationStyle.overlay.opacity(0.85))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .padding(.top, proxy.safeAreaInsets.top + 42)
                }

                if let errorMessage = model.errorMessage {
                    VStack(spacing: 10) {
                        Text("Connection issue")
                            .font(.headline)
                        Text(errorMessage)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                        Button("Reload") {
                            model.reload()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(AnalyticsPresentationStyle.accent)
                        .foregroundStyle(AnalyticsPresentationStyle.navy)
                    }
                    .padding(16)
                    .foregroundStyle(.white)
                    .background(AnalyticsPresentationStyle.overlay.opacity(0.92))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .padding(20)
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            AnalyticsBrowserFactory.prewarm(url: config.initialURL, timeout: config.requestTimeout)
        }
    }

    private func analyticsControls(topInset: CGFloat) -> some View {
        HStack {
            HStack(spacing: 8) {
                analyticsControlButton(systemName: "chevron.left", isEnabled: model.canGoBack) {
                    model.goBack()
                }

                analyticsControlButton(systemName: "chevron.right", isEnabled: model.canGoForward) {
                    model.goForward()
                }
            }

            Spacer(minLength: 96)

            analyticsControlButton(systemName: "arrow.clockwise", isEnabled: true) {
                model.reload()
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, max(topInset - 2, 8))
    }

    private func analyticsControlButton(
        systemName: String,
        isEnabled: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(isEnabled ? .primary : .secondary.opacity(0.55))
                .frame(width: 32, height: 32)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(.white.opacity(0.18), lineWidth: 0.5)
                }
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
    }
}
