//
//  SampleFormView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//

import SwiftUI

struct SampleFormView: View {
    @StateObject var analysisResultViewModel = AnalysisResultViewModel()

    var body: some View {
        content.environmentObject(analysisResultViewModel)
    }
    
    var content: some View {
        NavigationStack {
            VStack{
                TextField("Enter field data", text: $analysisResultViewModel.toBeAnalyzedRequest.ingredients)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                NavigationLink(destination: AnalysisResultView(analysisResultViewModel: analysisResultViewModel)) {
                    Text("Process")
                }
                
            }
        }
        
    }
}
