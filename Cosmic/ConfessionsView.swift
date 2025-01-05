//
//  ConfessionsView.swift
//  Cosmic
//
//  Created by Mario Guerrieri on 12/30/24.
//

import CodableCSV
import SwiftUI

private enum Response: Decodable {
    enum CodingKeys: String, CodingKey {
        case timestamp
        case type = "Daylight or Darkness?"
        case daylightName = "What is your name?"
        case daylightResponse = "Upon what would you like to shine the light of day?"
        case darknessResponse = "What should forever remain shrouded in darkness?"

        var intValue: Int? {
            switch self {
                case .timestamp:
                    return 0
                case .type:
                    return 1
                case .daylightName:
                    return 3
                case .daylightResponse:
                    return 2
                case .darknessResponse:
                    return 4
            }
        }
    }

    case daylight(timestamp: String, name: String, response: String)
    case darkness(timestamp: String, response: String)

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let timestamp = try container.decode(String.self, forKey: .timestamp)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
            case "Daylight":
                let name = try container.decode(String.self, forKey: .daylightName)
                let response = try container.decode(String.self,
                                                    forKey: .daylightResponse)
                self = .daylight(timestamp: timestamp, name: name, response: response)
            case "Darkness":
                let response = try container.decode(String.self,
                                                    forKey: .darknessResponse)
                self = .darkness(timestamp: timestamp, response: response)
            default:
                throw DecodingError.dataCorruptedError(forKey: .type,
                                                       in: container,
                                                       debugDescription: "Invalid type")

        }
    }
}

struct ConfessionsView: View {
    @State private var currentResponse: Response?

    let responsesURL: URL?

    private func fetchResponses() async -> [Response] {
        guard let responsesURL else { return [] }

        do {
            let (data, _) = try await URLSession.shared.data(from: responsesURL)

            return try CSVDecoder { $0.headerStrategy = .firstLine }
                .decode([Response].self, from: data)
        } catch {
            return []
        }
    }

    private static let headerFont = Font.system(size: 30)
    private static let responseFont = Font.system(size: 40)

    var body: some View {
        ZStack {
            if let currentResponse {
                VStack {
                    switch currentResponse {
                        case .daylight(_, let name, let response):
                            Group {
                                (Text("A ray of daylight from ")
                                 + Text("\(name)")
                                    .font(.system(size: 35))
                                 + Text("..."))
                                .font(Self.headerFont)
                                .padding(.bottom)

                                Text(verbatim: response)
                                    .font(Self.responseFont)
                                    .id("response")
                            }
                            .foregroundStyle(.daylight)
                        case .darkness(_, let response):
                            Group {
                                Text("A dark portent...")
                                    .font(Self.headerFont)
                                    .padding(.bottom)

                                Text(verbatim: response)
                                    .font(Self.responseFont)
                                    .id("response")
                            }
                            .foregroundStyle(.darkness)
                    }
                }
                .padding()
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task(id: responsesURL) {
            while !Task.isCancelled {
                let newResponse = await fetchResponses().randomElement()
                withAnimation(.easeInOut(duration: 5)) {
                    currentResponse = newResponse
                }

                try? await Task.sleep(for: .seconds(20))
            }
        }
        .background { Starfield(count: 200) }
        .frame(minWidth: 400, minHeight: 400)
    }
}

#Preview {
    ConfessionsView(responsesURL: .init(string: "https://docs.google.com/spreadsheets/d/e/2PACX-1vRNYaReIYhET8fxxaEyH_vEJxXt7oo4Xq3R0A5KvFm0knWaNavQMmbQUe6SkBGoE8GbuqgrLOuIQr_h/pub?output=csv")!)
        .frame(width: 500, height: 500)
}
