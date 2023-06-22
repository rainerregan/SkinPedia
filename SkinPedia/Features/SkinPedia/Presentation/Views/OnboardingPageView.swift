//
//  OnboardingPageView.swift
//  SkinPedia
//
//  Created by Rainer Regan on 22/06/23.
//

import SwiftUI

struct OnboardingPageView: View {
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                VStack{
                    Image(uiImage: UIImage(named: "PlaceholderLogo")!)
                        .resizable()
                        .frame(width: 150, height: 150)
                    Text("Hi Skinsis!").font(.largeTitle).fontWeight(.medium).padding(.vertical, 8).foregroundColor(Color.darkBrown)
                    Text("Scan your product now and let's find out if there are any allergens in your skincare product that could potentially affect you").font(.body)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                NavigationLink(destination: CameraView()) {
                    Text("Let's Start")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .foregroundColor(.white)
                .background(Color.darkBrown)
                .cornerRadius(10)
                .frame(maxWidth: .infinity) // Make NavigationLink full width
            }
            .padding(.horizontal, 16)
        }
        
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView()
    }
}
