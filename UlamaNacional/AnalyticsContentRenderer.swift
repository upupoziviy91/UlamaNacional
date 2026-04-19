import SwiftUI
import WebKit

public struct AnalyticsContentRenderer: UIViewRepresentable {
    public let config: AnalyticsLaunchConfig
    @ObservedObject public var model: AnalyticsSurfaceModel

    public init(config: AnalyticsLaunchConfig, model: AnalyticsSurfaceModel) {
        self.config = config
        self.model = model
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(model: model, sessionStore: AnalyticsSessionStore(storageKey: config.resumeStorageKey))
    }

    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: AnalyticsBrowserFactory.makeConfiguration())
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.keyboardDismissMode = .interactive
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        model.webView = webView

        let sessionStore = AnalyticsSessionStore(storageKey: config.resumeStorageKey)
        let startURL = sessionStore.savedURL(forEntryURL: config.initialURL) ?? config.initialURL
        sessionStore.save(entryURL: config.initialURL)
        webView.load(URLRequest(url: startURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: config.requestTimeout))
        return webView
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
    }

    public final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        private let model: AnalyticsSurfaceModel
        private let sessionStore: AnalyticsSessionStore

        init(model: AnalyticsSurfaceModel, sessionStore: AnalyticsSessionStore) {
            self.model = model
            self.sessionStore = sessionStore
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            Task { @MainActor in
                model.isLoading = true
                model.errorMessage = nil
                model.refreshNavigationState()
            }
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            Task { @MainActor in
                model.isLoading = false
                model.refreshNavigationState()
                sessionStore.save(url: webView.url)
            }
        }

        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            Task { @MainActor in
                model.isLoading = false
                model.errorMessage = error.localizedDescription
                model.refreshNavigationState()
            }
        }

        public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            Task { @MainActor in
                model.isLoading = false
                model.errorMessage = error.localizedDescription
                model.refreshNavigationState()
            }
        }

        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
            if navigationAction.request.url?.scheme == "about" {
                return .cancel
            }
            return .allow
        }

        public func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }
}

@MainActor
public final class AnalyticsSurfaceModel: ObservableObject {
    @Published public var isLoading = false
    @Published public var canGoBack = false
    @Published public var canGoForward = false
    @Published public var errorMessage: String?
    public weak var webView: WKWebView?

    public init() {}

    public func goBack() {
        guard webView?.canGoBack == true else { return }
        webView?.goBack()
        refreshNavigationState()
    }

    public func goForward() {
        guard webView?.canGoForward == true else { return }
        webView?.goForward()
        refreshNavigationState()
    }

    public func reload() {
        webView?.reload()
    }

    public func refreshNavigationState() {
        canGoBack = webView?.canGoBack ?? false
        canGoForward = webView?.canGoForward ?? false
    }
}
