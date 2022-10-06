//
//  SelectionView.swift
//  ChartsDemo
//
//  Created by Daniel Marques on 20/06/22.
//

import SwiftUI

struct SelectionView: View {

    let value: Double

    var body: some View {

        HStack {
            Text(String(format: "$%.02f", abs(value)))
                .font(.caption)
                .bold()
        }
        .foregroundColor(.black)
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(.black.opacity(0.05))
        .cornerRadius(20)

    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(value: 157)
    }
}
