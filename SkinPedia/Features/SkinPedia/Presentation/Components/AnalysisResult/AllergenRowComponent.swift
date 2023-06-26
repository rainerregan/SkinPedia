//
//  AllergenRowComponen.swift
//  SkinPedia
//
//  Created by Rainer Regan on 21/06/23.
//

import SwiftUI

struct AllergenRowComponent: View {
    var ingredientTableArray: [IngredientsTable]
    
    var body: some View {
        VStack {
            DisclosureGroup{
                VStack(alignment: .leading) {
                    Text(ingredientTableArray[0].introtext == "" ? "No description available" : (ingredientTableArray[0].introtext ?? ""))
                }
                .padding(.vertical, 16)
            } label: {
                VStack(alignment: .leading){
                    Text(ingredientTableArray[0].title ?? "-").font(.body).fontWeight(.semibold)
                    Text(ingredientTableArray[0].categories ?? "-").font(.subheadline)
                }
            }
            .padding()
            .background(Color.lightBrown.opacity(0.3))
            .foregroundColor(.darkBrown)
            .cornerRadius(20)
        }
        
    }
}
