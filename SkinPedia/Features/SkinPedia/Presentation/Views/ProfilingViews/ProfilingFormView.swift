//
//  ProfilingFormView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 28/06/23.
//

import SwiftUI

struct ProfilingFormView: View {
    
    @StateObject var profilingViewModel = ProfilingViewModel()
    @EnvironmentObject var productAnalysistViewModel : AnalysisResultViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment:.leading){
                Text("Did your skincare ever give you some side effects?")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer().frame(height: 16)
                Text("Skincare products may cause side effects, such as:")
            }
            Spacer().frame(height: 16)
            
            VStack(spacing: 0){
                VStack(alignment: .leading, spacing: 0){
                    
                    HStack(spacing: 0) {
                        Text("Skincare Product")
                            .font(.subheadline)
                            .foregroundColor(.customDarkGray)
                            .padding(.bottom, 4)
                            .padding(.leading, 16)
                            .padding(.top, 10)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.customLightGray)
                    
                    
                    HStack{
                        TextField("Input Skincare Name", text: $profilingViewModel.textFieldString)
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 10)
                            .onReceive(
                                profilingViewModel.$textFieldString
                            ) {
                                guard !$0.isEmpty else {
                                    profilingViewModel.productDetailsResult.removeAll(keepingCapacity: false)
                                    return }
                                
                                // Nunggu 2 detik kemudian nembak API
                                print(">> searching for: \($0)")
                                profilingViewModel.getProductDetails()
                                profilingViewModel.searchQuerryIsShown = true
                            }
                        
                        Spacer()
                        
                        Button {
                            profilingViewModel.textFieldString = ""
                            print("Clicked")
                            profilingViewModel.searchQuerryIsShown = false;
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(profilingViewModel.textFieldString == "" ? .clear : .black)
                        }
                        
                        .disabled((profilingViewModel.textFieldString == ""))
                        .padding(.trailing, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.customLightGray)
                    
                    
                    // TODO: Benerin Tampilan LIST
                    ScrollView{
                        VStack(alignment: .leading){
                            ForEach(profilingViewModel.productDetailsResult, id:\.self){ result in
                                Text(result.productName ?? "")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        profilingViewModel.SelectedProductResult.append(result)
                                        profilingViewModel.textFieldString = ""
                                        profilingViewModel.searchQuerryIsShown = false
                                    }
                                Divider()
                                    .padding(.horizontal)
                                
                            }
                        }
                    }
                    .background(Color.white)
                    .frame(height: (profilingViewModel.searchQuerryIsShown ? 156 : 0))
                    
                }
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            
            ScrollView{
                ForEach(Array(profilingViewModel.SelectedProductResult.enumerated()), id : \.element) {
                    index, selected in
                    HStack {
                        Text(selected.productName!)
                            .font(.subheadline)
                        Spacer()
                        Button {
                            profilingViewModel.SelectedProductResult.remove(at: index)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 15)
                    .background(Color.lightestYellow)
                    .cornerRadius(12)
                }
            }
            
            Spacer()
            
            Button{
                
                var ingredients : String = ""
                
                for product in profilingViewModel.SelectedProductResult {
                    ingredients  = "\(ingredients), \(product.ingredients ?? "" )"
                }
                
                productAnalysistViewModel.toBeAnalyzedRequest = ProductAnalysisRequest(ingredients: ingredients)
                
                profilingViewModel.toAnalysisResult = true
            } label : {
                Text("Continue")
                    .padding(16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background((profilingViewModel.SelectedProductResult.isEmpty) ? Color.customMediumGray : Color.customBrown)
                    .cornerRadius(10)
                    
            }.disabled((profilingViewModel.SelectedProductResult.isEmpty) ? true : false)
//            NavigationLink(destination: ProfilingFormView()) {
//                Text("Continue")
//                    .padding(16)
//                    .foregroundColor(.white)
//            }
//            .frame(maxWidth: .infinity)
//            .background((profilingViewModel.SelectedProductResult.isEmpty) ? Color.customMediumGray : Color.customBrown)
//            .cornerRadius(10)
//            .disabled((profilingViewModel.SelectedProductResult.isEmpty) ? true : false)
            
        }
        .background{
            NavigationLink("", destination: AnalysisResultView(analysisResultViewModel: self.productAnalysistViewModel, isSavingAllergen : true), isActive: $profilingViewModel.toAnalysisResult)
        }
        .navigationTitle("Profiling")
        .padding(16)
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.keyboard)
    }
}

struct ProfilingFormView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilingFormView()
    }
}
