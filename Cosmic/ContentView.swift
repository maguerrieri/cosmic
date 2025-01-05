//
//  ContentView.swift
//  Cosmic
//
//  Created by Mario Guerrieri on 12/30/24.
//

import SwiftUI

struct ContentView: View {
    let playlistURL: URL?
    let playlistPartyCode: String

    let confessionsResponsesURL: URL?
    let confessionsFormURL: String

    var body: some View {
        HSplitView {
            ConfessionsView(responsesURL: confessionsResponsesURL)
                .background { Starfield(count: 200) }

            VSplitView {
                PlaylistView(url: playlistURL)

                HStack {
                    QRCodeView(data: confessionsFormURL) {
                        Text("Submit your own light or dark confessions!")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }

                    Spacer(minLength: 100)

                    QRCodeView(data: "https://festify.us/\(playlistPartyCode)") {
                        Text("Scan to add songs to the playlist!")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
                }
                .background { Starfield() }
            }
        }
    }
}

#Preview {
    ContentView(playlistURL: .init(string: "https://google.com"),
                playlistPartyCode: "",
                confessionsResponsesURL: .init(string: "https://google.com")!,
                confessionsFormURL: "test")
}
