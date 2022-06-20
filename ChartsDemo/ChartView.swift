//
//  ChartView.swift
//  ChartsDemo
//
//  Created by Daniel Marques on 20/06/22.
//

import SwiftUI
import Charts


struct ChartView: View {

    var data: [StockChartData]

    var body: some View {
        let open = data.first?.close ?? 0
        let close = data.last?.close ?? 0

        let trendColor: Color = close > open ? .green : .red
        ZStack(alignment: .center) {
            Chart(data) {
                LineMark(x: .value("Date", $0.date ?? Date()),
                         y: .value("Close", $0.close ?? 0))
                .foregroundStyle(trendColor)
                AreaMark(x: .value("Date", $0.date ?? Date()),
                         y: .value("Close", $0.close ?? 0))
                .foregroundStyle(Gradient(colors: [trendColor.opacity(0.2), trendColor.opacity(0.075), .white, .white]))
            }
            .frame(height: 85)
            .chartXAxis(SwiftUI.Visibility.hidden)
            .chartYAxis(SwiftUI.Visibility.hidden)
            .padding(.horizontal, -16)
            Line()
                .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [3]))
                .opacity(0.25)
                .frame(height: 0.5)
                .padding(.horizontal, -16)
                .offset(y: -15)
        }

    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(data: makeMockData())
    }
}

func makeMockData() -> [StockChartData] {
    var mockData = [StockChartData]()
    for i in 1...20 {
        let date = Date(timeIntervalSinceNow: TimeInterval(-i * 24 * 60 * 60))
        let value = Float.random(in: 100...200)
        mockData.append(StockChartData(date: date, close: value))
    }
    return mockData
}
