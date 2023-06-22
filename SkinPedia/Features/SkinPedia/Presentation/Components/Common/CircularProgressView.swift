//
//  CircularProgressView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 22/06/23.
//

import SwiftUI

struct CircularProgressView: View {
    
    let allergentsCount: Double
    let ingredientsCount: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.getColorFromAllergentsCount(allergentsCount: Int(allergentsCount)).opacity(0.5),
                    lineWidth: 15
                )
            Circle()
                // 2
                .trim(from: 0, to: CGFloat(allergentsCount/ingredientsCount))
                .stroke(
                    Color.getColorFromAllergentsCount(allergentsCount: Int(allergentsCount)),
                    style: StrokeStyle(
                        lineWidth: 15,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            HStack(alignment: .bottom){
                Text("\(Int(allergentsCount))").font(.title).padding(.horizontal, -10).fontWeight(.bold).foregroundColor(Color.getColorFromAllergentsCount(allergentsCount: Int(allergentsCount)))
                Text("/").font(.title)
                Text("\(Int(ingredientsCount))").font(.body).padding(.horizontal,-8)
            }
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(allergentsCount: 6, ingredientsCount: 22)
    }
}
