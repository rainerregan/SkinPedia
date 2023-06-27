//
//  profilePage1.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct profilingPage1: View {
    
    var sideEffects : [String] =
    [
        "Allergic Reactions",
        "Redness",
        "Swelling",
        "Itching",
        "Skin Rashes"
    ]
    @State var goToPage2 = false
    
    var body: some View {
        ProfilingView(alignment: .leading){
            Text("Did your skincare ever give you some side effects?")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            Text("Skincare products may cause side effects, such as:")
                .padding(.bottom, 15)
            
//            List(sideEffects, id : \.self) {
//                se in
//                    SideEffectListProfilePage(label: se)
//            }
            ForEach(sideEffects, id : \.self) {
                se in
                SideEffectListProfilePage(label: se)
            }
            .padding(.bottom, 15)
            
            Text("This could be caused by certain ingredients in your skincare that ")
                .font(.body)
                .fontWeight(.regular)
                .foregroundColor(.black)
            +
            Text("contain allergens")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.redDanger)
            +
            Text(".")
                .font(.body)
                .fontWeight(.regular)
                .foregroundColor(.black)
            
            Spacer()
            
            
            
            HStack{
                Spacer()
                Button {
                
                    goToPage2 = true
                
                } label : {
                    Text("Next")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 14, leading: 157, bottom: 14, trailing: 157))
                        .background(Color.customBrown)
                        .cornerRadius(12)
                }
                
                Spacer()
            }
            .padding(.bottom, 84)
            .background{
                NavigationLink("", destination: ProfilingPage2().navigationBarHidden(true), isActive: $goToPage2)
            }
           
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        profilingPage1()
    }
}



