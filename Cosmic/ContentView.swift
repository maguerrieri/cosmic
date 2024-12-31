//
//  ContentView.swift
//  Cosmic
//
//  Created by Mario Guerrieri on 12/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HSplitView {
            ConfessionsView()

            VSplitView {
                PlaylistView()

                PlaylistQRCodeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
