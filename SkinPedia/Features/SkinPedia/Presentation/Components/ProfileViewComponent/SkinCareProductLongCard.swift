//
//  SkinCareProductLongCard.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 27/06/23.
//

import SwiftUI


struct SkinCareProductLongCard: View {
    var productName: String?
    var productAnalysisResult : ProductAnalysisResult
    var dateScanned : String?
    var allergenColor : Color
    var badgeTextColor : Color
    var listStateIcon : Image
    
    @StateObject var analysisResultViewModel = AnalysisResultViewModel()
    
    init(productAnalysisResult: ProductAnalysisResult, productName: String) {
        self.productAnalysisResult = productAnalysisResult
//        self.dateScanned = dateScanned.formatted(date: .abbreviated, time: .omitted)
        self.productName = productName
        
        
        switch productAnalysisResult.analysis?.harmful?.allergen?.count ?? 0 {
        case 0 :
            self.allergenColor = .green
            self.badgeTextColor = .white
            self.listStateIcon = Image(systemName: "leaf.circle")
            break
            
        case 1...5 :
            self.allergenColor = .yellow
            self.badgeTextColor = .darkBrown
            self.listStateIcon = Image(systemName: "exclamationmark.triangle.fill")
            break
            
        case let x where x > 5 :
            self.allergenColor = .red
            self.badgeTextColor = .white
            self.listStateIcon = Image(systemName: "exclamationmark.triangle.fill")
            break
        default:
            self.allergenColor = .gray
            self.badgeTextColor = .darkBrown
            self.listStateIcon = Image(systemName: "questionmark.diamond")
            break
        }
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Text(productName ?? "")
                .font(.title3)
                .fontWeight(.semibold)
            Text("Date")
                .font(.footnote)
                .foregroundColor(.textGray)
            
            HStack{
                listStateIcon
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .foregroundColor(badgeTextColor)
                Text("This product contains \(productAnalysisResult.analysis?.harmful?.allergen?.count ?? 0) allergents!")
                    .font(.subheadline)
                    .foregroundColor(badgeTextColor)
            }
            .padding(8)
            .background(allergenColor)
            .cornerRadius(10)
            
            Spacer().frame(height: 16)
            
            NavigationLink(destination: AnalysisResultView()){
                HStack{
                    Text("Detail Information")
                        .font(.subheadline)
                    Spacer()
                    Image(systemName: "chevron.right.circle")
                }
            }
            
            
        }
        .padding(16)
        .background(Color.lightestBrown.opacity(0.4))
        .cornerRadius(10)
    }
}

//struct SkinCareProductLongCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SkinCareProductLongCard(StringProductName: "skincare #3", dateScanned: Date(), totalAllergen: 6)
//    }
//}
