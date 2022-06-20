//
//  TrendView.swift
//  ChartsDemo
//
//  Created by Daniel Marques on 20/06/22.
//

import SwiftUI

struct TrendView: View {

    let open: Float
    let close: Float

    var body: some View {

        let trend = close - open
        let percentage = (close - open) / open
        let trendColor: Color = trend > 0 ? .green : .red
        let trendImage: Image = trend > 0 ?
            Image(systemName: "arrowtriangle.up.fill") :
            Image(systemName: "arrowtriangle.down.fill")

        HStack {
            trendImage
                .font(.caption)
            Text(String(format: "$%.02f", abs(trend)))
                .font(.caption)
                .bold()
            Text(String(format: "(%.02f", abs(percentage)) + "%)")
                .font(.caption)
                .bold()
        }
        .foregroundColor(trendColor)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(trendColor.opacity(0.1))
        .cornerRadius(20)

    }
}

struct TrendView_Previews: PreviewProvider {
    static var previews: some View {
        TrendView(open: 1, close: 2)
    }
}
