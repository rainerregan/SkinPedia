//
//  CautionCard.swift
//  SkinPedia
//
//  Created by Rainer Regan on 26/06/23.
//

import SwiftUI

struct CautionCard: View {
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: "lightbulb.fill").font(.system(size: 20, weight: .light))
            
            Text("Please be aware using this product. Using this product may provoke allergies for some people!")
                .font(.subheadline)
        }
        .padding(16)
        .background(Color.customRed)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}

struct CautionCard_Previews: PreviewProvider {
    static var previews: some View {
        CautionCard()
    }
}
