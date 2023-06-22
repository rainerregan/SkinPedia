//
//  AllergenRowComponen.swift
//  SkinPedia
//
//  Created by Rainer Regan on 21/06/23.
//

import SwiftUI

struct AllergenRowComponent: View {
    var itemList: ItemList
    
    var body: some View {
        VStack{
            HStack {
                VStack(alignment: .leading) {
                    Text(itemList.title ?? "-")
                        .font(.headline)
                    Text(itemList.alias ?? "-").font(.subheadline)
                }
                .padding(.vertical, 8)
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            
            Divider()
        }
        
        
    }
}
