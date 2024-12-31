//
//  ContentView.swift
//  Cosmic
//
//  Created by Mario Guerrieri on 12/30/24.
//

import SwiftUI

struct ContentView: View {
    let playlistURL: URL?
    let partyCode: String

    var body: some View {
        HSplitView {
            ConfessionsView()

            VSplitView {
                PlaylistView(url: playlistURL)

                PlaylistQRCodeView(partyCode: partyCode)
            }
        }
    }
}

#Preview {
    ContentView(playlistURL: .init(string: "https://google.com"),
                partyCode: "")
}
