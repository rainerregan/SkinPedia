//
//  SideEffectListProfilePage.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct SideEffectListProfilePage: View {
    
    var label : String;
    
    var body: some View {
        HStack{
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 15)
                .foregroundColor(.redDanger)
            
            Text(label)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.redDanger)
        }
    }
}

