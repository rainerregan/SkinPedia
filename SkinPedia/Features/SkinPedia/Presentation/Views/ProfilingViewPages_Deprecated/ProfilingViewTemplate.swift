//
//  ProfileView.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct ProfilingView<CustomContent : View>: View {
    
    var customContent : () -> CustomContent
    var vStackAlign : HorizontalAlignment
    @Environment(\.presentationMode) var presentationMode
    
    init(alignment : HorizontalAlignment, @ViewBuilder customContent: @escaping () -> CustomContent) {
        self.customContent = customContent
        self.vStackAlign = alignment
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: vStackAlign){
                
                customContent()
                    .padding(.horizontal, 16)
                
            }
            .navigationBarTitle("Profiling", displayMode: .inline)
        }
    }
}



