//
//  ContentView.swift
//  ChartsDemo
//
//  Created by Daniel Marques on 14/06/22.
//

import SwiftUI

extension StockChartData: Identifiable {
    public var id: UUID { UUID() }
}

struct ContentView: View {

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color(hex: "F3F6F8")
                VStack(alignment: .leading) {
                    Text("WEX")
                        .font(.headline).fontWeight(.medium)
                        .foregroundColor(Color(hex: "253746").opacity(0.5))
                    Text("WEX Inc.")
                        .font(.largeTitle)
                        .foregroundColor(Color(hex: "253746"))
                        .bold()
                    ChartCardView()
                }
                .padding(.all)
            }
            .navigationTitle("Charts Demo")
        }
    }
}
