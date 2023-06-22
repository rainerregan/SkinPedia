//
//  ScanResultSummaryCardComponent.swift
//  SkinPedia
//
//  Created by Rainer Regan on 22/06/23.
//

import SwiftUI

struct ScanResultSummaryCardComponent: View {
    let allergentsCount: Double
    let ingredientsCount: Double
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(allergentsCount > 0 ? "Warning!" : "Good!").font(.title3).fontWeight(.semibold).padding(.bottom, 4)
                Text("We Have Found").font(.subheadline).padding(.bottom, 4)
                AllergenceRatioBadgeComponent(allergentsCount: allergentsCount, ingredientsCount: ingredientsCount)
                Text("In your Skincare Product").font(.subheadline)
            }
            Spacer()
            
            CircularProgressView(allergentsCount: allergentsCount, ingredientsCount: ingredientsCount)
                .frame(width: 100)
        }
        .padding(16)
        .background(Color.lightBrown.opacity(0.3))
    }
}

struct ScanResultSummaryCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        ScanResultSummaryCardComponent(allergentsCount: 10, ingredientsCount: 20)
    }
}
