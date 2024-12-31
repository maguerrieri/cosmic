//
//  PlaylistQRCodeView.swift
//  Cosmic
//
//  Created by Mario Guerrieri on 12/30/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct PlaylistQRCodeView: View {
    let partyCode: String

    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    private var qrCodeImage: NSImage? {
        filter.message = Data("https://festify.us/\(partyCode)".utf8)

        if let outputImage = filter.outputImage {
            let rep = NSCIImageRep(ciImage: outputImage)
            let image = NSImage(size: rep.size)
            image.addRepresentation(rep)
            return image
        }

        return nil
    }

    var body: some View {
        VStack {
            if let qrCodeImage {
                Image(nsImage: qrCodeImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Unable to generate QR code 🙁")
                    .padding()
                    .fixedSize()
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
            }

            Text("Scan to add songs to the playlist!")
                .font(.title2)
        }
        .padding()
    }
}

#Preview {
    PlaylistQRCodeView(partyCode: "")
}
