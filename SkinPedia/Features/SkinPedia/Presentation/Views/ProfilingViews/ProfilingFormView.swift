//
//  ProfilingFormView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 28/06/23.
//

import SwiftUI

struct ProfilingFormView: View {
    
    @ObservedObject var profilingViewModel = ProfilingViewModel()
    
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
                    Text("Skincare Product")
                        .font(.subheadline)
                        .foregroundColor(.customDarkGray)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    
                    HStack{
                        TextField("Input Skincare Name", text: $profilingViewModel.textFieldString)
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 10)
                            .onReceive(
                                profilingViewModel.$textFieldString
                                    .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
                            ) {
                                guard !$0.isEmpty else { return }
                                
                                // Nunggu 2 detik kemudian nembak API
                                print(">> searching for: \($0)")
                                profilingViewModel.getProductDetails()
                            }
                        
                        Spacer()
                        
                        Button {
                            profilingViewModel.textFieldString = ""
                            print("Clicked")
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(profilingViewModel.textFieldString == "" ? .clear : .black)
                        }
                        
                        .disabled((profilingViewModel.textFieldString == ""))
                        
                    }
                    .padding(.trailing, 16)
                    
                    // TODO: Benerin Tampilan LIST
                    ScrollView{
                        VStack{
                            ForEach(profilingViewModel.productDetailsResult, id:\.self){ result in
                                Text(result.productName ?? "")
                            }
                        }
                    }
                    
                    
                    
                }
                .background(Color.customLightGray)
            }.clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            
            Spacer()
            
            NavigationLink(destination: ProfilingFormView()) {
                Text("Next")
                    .padding(16)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .background(Color.customBrown)
            .cornerRadius(10)
            
        }
        .navigationTitle("Profiling")
        .padding(16)
        .frame(maxWidth: .infinity)
    }
}

struct ProfilingFormView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilingFormView()
    }
}
