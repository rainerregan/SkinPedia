//
//  IngredientRowComponent.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//

import SwiftUI

struct IngredientRowComponent: View {
    var ingredient: IngredientsTable
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(ingredient.title ?? "-")
                .font(.headline)
            Text(ingredient.categories ?? "-").font(.subheadline).padding(.bottom, 8)
            Text(ingredient.introtext?.trimHTMLTags() ?? "No description available")
        }
    }
}
