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

    @AppStorage("confessionResponsesURL") private var confessionResponsesURLString = ""
    private var confessionResponsesURL: URL? { .init(string: confessionResponsesURLString) }

    @AppStorage("confessionFormURL") private var confessionFormURLString = ""

    var body: some Scene {
        WindowGroup {
            ContentView(playlistURL: playlistURL,
                        playlistPartyCode: partyCode,
                        confessionsResponsesURL: confessionResponsesURL,
                        confessionsFormURL: confessionFormURLString)
        }

        Settings {
            Form {
                Section {
                    TextField("Playlist URL", text: $playlistURLString)
                    TextField("Party code", text: $partyCode)
                }

                Section {
                    TextField("Confessions responses URL", text: $confessionResponsesURLString)
                    TextField("Confessions form URL", text: $confessionFormURLString)
                }
            }
            .padding()
        }
    }
}
