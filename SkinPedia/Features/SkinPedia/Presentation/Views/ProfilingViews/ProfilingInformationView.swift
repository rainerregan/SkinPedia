//
//  ProfilingInformationView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 28/06/23.
//

import SwiftUI

struct ProfilingInformationView: View {
    
    @StateObject var productAnalysistViewModel : AnalysisResultViewModel = AnalysisResultViewModel()
    @EnvironmentObject var mainViewViewModel : MainViewViewModel
    
    var sideEffects : [String] = [
        "Allergic Reactions",
        "Redness",
        "Swelling",
        "Itching",
        "Skin Rashes"
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment:.leading){
                Text("Did your skincare ever give you some side effects?")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer().frame(height: 16)
                Text("Skincare products may cause side effects, such as:")
            }
            
            VStack(alignment: .leading, spacing: 4) {
                ForEach(sideEffects, id : \.self) {
                    se in
                    SideEffectListProfilePage(label: se)
                }
            }
            Spacer().frame(height: 16)
            
            Text("This could be caused by certainning ingredients in your skincare that contain allergens")
            
            Spacer()
            
            NavigationLink(destination: ProfilingFormView()
                .environmentObject(productAnalysistViewModel)
                .environmentObject(mainViewViewModel)
            ) {
                Text("Next")
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.customBrown)
                    .foregroundColor(.white)
            }
            .cornerRadius(10)
            
        }
        .navigationTitle("Profiling")
        .padding(16)
        .frame(maxWidth: .infinity)
    }
}

struct ProfilingInformationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilingInformationView()
    }
}
