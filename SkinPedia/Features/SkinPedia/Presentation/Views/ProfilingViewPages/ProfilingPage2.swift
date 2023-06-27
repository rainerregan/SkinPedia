//
//  ProfilePage2.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct ProfilingPage2: View {
    @State var querrySearchNameList : [String]?
    @State var SkinCareName : String = ""
    @State var ableToContinue : Bool = false
    @State var selectedProduct : [NSObject] = [];
    
    var body: some View {
        ProfilingView(alignment: .leading){
            Text("What was that product?")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 20)
            
            Text("Help us to identify what were 3 products that caused the side effects.")
                .padding(.bottom, 15)
            
            VStack(spacing: 0){
                VStack(alignment: .leading, spacing: 0){
                    Text("Skincare Product")
                        .font(.subheadline)
                        .foregroundColor(.customDarkGray)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    HStack{
                        TextField("Input Skincare Name", text: $SkinCareName)
                            .font(.body)
                            .fontWeight(.semibold)
                        
                            .padding(.horizontal, 16)
                            .padding(.bottom, 10)
                        
                        Spacer()
                        
                        Button {
                            SkinCareName = ""
                            print("Clicked")
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(SkinCareName == "" ? .clear : .black)
                        }
                        
                        .disabled((SkinCareName == ""))
                        
                    }
                    .padding(.trailing, 16)
                    
                    if !SkinCareName.isEmpty {
                        if let nameList = self.querrySearchNameList {
                            ForEach(nameList, id : \.self) {
                                productName in
                                    Text(productName)
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .onTapGesture {
                                        selectedProduct
                                    }
                            }
                        }
                    }
                    
                }
                .background(Color.customLightGray)
            }.clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            
            
            Spacer()
            Button{
                
            } label: {
                VStack{
                    Text("Continue")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor((selectedProduct.isEmpty) ? Color.darkBrown : .white)
                        .padding(.vertical, 14)
                    
                }
                .frame(width: 358)
                .background((selectedProduct.isEmpty) ? Color.customMediumGray.opacity(0.8) :  Color.customBrown)
                .cornerRadius(12)
                    
            }
            .disabled(selectedProduct.isEmpty)
            
        }
    }
}

struct ProfilePage2_Previews: PreviewProvider {
    static var previews: some View {
        ProfilingPage2()
    }
}
