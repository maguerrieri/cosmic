//
//  PlaylistView.swift
//  Cosmic
//
//  Created by Mario Guerrieri on 12/30/24.
//

import SwiftUI
import WebKit

private struct WebView: NSViewRepresentable {
    private let webView = WKWebView()

    let url: URL?

    func makeNSView(context: Context) -> WKWebView {
        webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        if let url {
            nsView.load(.init(url: url))
        }
    }
}

struct PlaylistView: View {
    let url: URL?

    var body: some View {
        if let url {
            WebView(url: url)
        } else {
            Text("🚨 Invalid playlist URL 🚨")
                .padding()
        }
    }
}

#Preview {
    PlaylistView(url: .init(string: "https://google.com"))
}
