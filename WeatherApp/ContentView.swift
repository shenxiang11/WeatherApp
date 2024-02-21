//
//  ContentView.swift
//  WeatherApp
//
//  Created by 香饽饽zizizi on 2024/2/21.
//

import SwiftUI

struct ContentView: View {
    @State var weather = WeatherState.sunny
    let now = Date.now

    var body: some View {
        ScrollView {
            pannel
        }
        .frame(maxWidth: .infinity)
        .background {
            background
        }
    }

    var background: some View {
        TimelineView(.periodic(from: now , by: 0.001)) { timeline in
            if weather == .rainy {
                Rectangle()
                    .foregroundStyle(
                        ShaderLibrary.heartfelt(
                            .boundingRect,
                            .float(timeline.date.timeIntervalSince(now)),
                            .image(Image(.shanghai))
                        )
                    )
            } else if weather == .snowy {
                Rectangle()
                    .foregroundStyle(
                        ShaderLibrary.snowScreen(
                            .boundingRect,
                            .float(timeline.date.timeIntervalSince(now)),
                            .image(Image(.shanghai))
                        )
                    )
            } else {
                Rectangle()
                    .overlay(
                        Image(.shanghai)
                            .resizable()
                            .scaledToFill()
                    )
            }
        }
        .ignoresSafeArea()
    }

    var pannel: some View {
        VStack {
            VStack(spacing: 20) {
                Text("上海市")
                    .font(.title2)

                Text("8°")
                    .font(.largeTitle)

                Text(weather.labelText)

            }

            Divider()

            Picker("", selection: $weather) {
                ForEach(WeatherState.allCases, id: \.self) { w in
                    Text(w.labelText).tag(w)
                }
            }
            .pickerStyle(.segmented)
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding()
    }
}

enum WeatherState: String, CaseIterable {
    case sunny
    case rainy
    case snowy

    var labelText: String {
        switch self {
        case .sunny:
            return "晴朗";
        case .rainy:
            return "下雨";
        case .snowy:
            return "下雪";
        }
    }
}

#Preview {
    ContentView()
}
