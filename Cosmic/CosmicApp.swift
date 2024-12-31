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

    var body: some Scene {
        WindowGroup {
            ContentView(playlistURL: playlistURL)
        }

        Settings {
            Form {
                Section {
                    TextField("Playlist URL", text: $playlistURLString)
                }
            }
            .padding()
        }
    }
}
