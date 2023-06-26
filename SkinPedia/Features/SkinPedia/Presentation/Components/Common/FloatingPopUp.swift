//
//  FloatingPopUp.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 24/06/23.
//

import Foundation
import SwiftUI

struct PopupView<Content : View> : View {
    @Binding var isShowingPopup: Bool
    var content : Content
    
    init(isShowingPopup: Binding<Bool>, content: () -> Content) {
        self._isShowingPopup = isShowingPopup
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
                self.content
                
        }
        
    }
}
