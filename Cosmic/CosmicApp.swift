//
//  CosmicApp.swift
//  Cosmic
//
//  Created by Mario Guerrieri on 12/30/24.
//

import SwiftUI

@main
struct CosmicApp: App {
    @AppStorage("playlistURL") private var playlistURLString = "https://festify.us/"
    private var playlistURL: URL? { .init(string: playlistURLString) }

    @AppStorage("partyCode") private var partyCode = ""

    var body: some Scene {
        WindowGroup {
            ContentView(playlistURL: playlistURL,
                        partyCode: partyCode)
        }

        Settings {
            Form {
                Section {
                    TextField("Playlist URL", text: $playlistURLString)
                    TextField("Party code", text: $partyCode)
                }
            }
            .padding()
        }
    }
}
