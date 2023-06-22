//
//  AllergenceRatioBadgeComponent.swift
//  SkinPedia
//
//  Created by Rainer Regan on 22/06/23.
//

import SwiftUI

struct AllergenceRatioBadgeComponent: View {
    
    let allergentsCount: Double
    let ingredientsCount: Double
    
    var body: some View {
        Text("\(String(format:"%.1f",allergentsCount/ingredientsCount * 100))% of Allergence")
            .padding(16)
            .background(Color.getColorFromAllergentsCount(allergentsCount: Int(allergentsCount)))
            .cornerRadius(10)
            .fontWeight(.medium)
    }
}

struct AllergenceRatioBadgeComponent_Previews: PreviewProvider {
    static var previews: some View {
        AllergenceRatioBadgeComponent(allergentsCount: 1.0, ingredientsCount: 10.0)
    }
}
