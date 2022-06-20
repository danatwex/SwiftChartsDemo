//
//  ChartCardView.swift
//  ChartsDemo
//
//  Created by Daniel Marques on 20/06/22.
//

import SwiftUI
import Charts

struct ChartCardView: View {

    @State var interval: ChartInterval = .sixMonths

    @State var data = [StockChartData]()

    var body: some View {
        let open = data.first?.close ?? 0
        let close = data.last?.close ?? 0

        ZStack(alignment: .topLeading) {
            Color.white
            VStack(alignment: .leading) {
                Text(String(format: "$%.02f", data.last?.close ?? 0))
                    .font(.title)

                TrendView(open: open, close: close)
                    .offset(x: -2, y: -8)

                Spacer()

                ChartView(data: data)

                Picker("Chart Interval", selection: $interval) {
                    Text("1W").tag(ChartInterval.oneWeek)
                    Text("1M").tag(ChartInterval.oneMonth)
                    Text("6M").tag(ChartInterval.sixMonths)
                    Text("1Y").tag(ChartInterval.oneYear)
                    Text("5Y").tag(ChartInterval.fiveYears)
                }
                .pickerStyle(.segmented)
                .padding(.top, -32)
            }
            .padding(.all)
        }
        .cornerRadius(12)
        .padding(.top, -10.0)
        .shadow(radius: 0.5, x: 0.25, y: 0.5)
        .frame(height: 220.0)
        .onAppear {
            getData(for: interval)
        }
        .onChange(of: interval) { newValue in
            self.getData(for: newValue)
        }
    }

    func getData(for interval: ChartInterval) {
        var date: Date
        var sampling: ChartTimeInterval
        let day = 24.0 * 60.0 * 60.0
        switch interval {
            case .oneDay:
                date = Date(timeIntervalSinceNow: -day)
                sampling = .onehour
            case .oneWeek:
                date = Date(timeIntervalSinceNow: -7 * day)
                sampling = .thirtyminutes
            case .oneMonth:
                date = Date(timeIntervalSinceNow: -30 * day)
                sampling = .oneday
            case .sixMonths:
                date = Date(timeIntervalSinceNow: -6 * 30 * day)
                sampling = .fivedays
            case .oneYear:
                date = Date(timeIntervalSinceNow: -365 * day)
                sampling = .onemonths
            case .fiveYears:
                date = Date(timeIntervalSinceNow: -5 * 365 * day)
                sampling = .threemonths
        }
        SwiftYFinance.chartDataBy(identifier: "WEX", start: date,
                                  interval: sampling) { newData, error in
            guard let newData = newData else {
                print(error ?? "Something went wrong!")
                return
            }
            data = newData
        }
    }

    enum ChartInterval {
        case oneDay, oneWeek, oneMonth, sixMonths, oneYear, fiveYears
    }

}

struct ChartCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChartCardView(data: makeMockData())
    }
}
