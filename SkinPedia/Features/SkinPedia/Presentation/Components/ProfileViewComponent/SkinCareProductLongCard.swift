//
//  SkinCareProductLongCard.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 27/06/23.
//

import SwiftUI


struct SkinCareProductLongCard: View {
    var StringProductName : String
    var dateScanned : String
    var allergenColor : Color
    var listStateIcon : Image
    var allergenCount : Int
    
    init(StringProductName: String, dateScanned: Date, totalAllergen: Int) {
        self.allergenCount = totalAllergen
        self.StringProductName = StringProductName
        
        self.dateScanned = dateScanned.formatted(date: .abbreviated, time: .omitted)
        
        switch totalAllergen {
        case 0...1 :
            self.allergenColor = .green
            self.listStateIcon = Image(systemName: "leaf.circle")
            break
            
        case 1...5 :
            self.allergenColor = .yellow
            self.listStateIcon = Image(systemName: "exclamationmark.triangle.fill")
            break
            
        case let x where x > 5 :
            self.allergenColor = .red
            self.listStateIcon = Image(systemName: "exclamationmark.triangle.fill")
            break
            
        default:
            self.allergenColor = .gray
            self.listStateIcon = Image(systemName: "questionmark.diamond")
            break
        }
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Text(StringProductName)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.leading, 23)
                .padding(.top, 9)
            Text(dateScanned)
                .font(.system(size: 12))
                .foregroundColor(.textGray)
                .padding(.leading, 23)
            
            HStack{
                HStack{
                    listStateIcon
                        .resizable()
                        .scaledToFit()
                        .frame(height: 16)
                        .padding(.leading, 10)
                        .padding(.vertical, 5)
                    Text("This product contains \(allergenCount) allergents!")
                        .font(.subheadline)
                        .padding(.trailing, 7)
                    
                }
                .background(allergenColor)
                .cornerRadius(12)
                .padding(.top, 7)
                
            }
            .padding(.leading, 23)
            
            HStack{
                Text("Detail Information")
                Spacer()
                Image(systemName: "chevron.right.circle")
            }
            .padding(.leading, 23)
            .padding(.trailing, 16)
            
            Spacer()
        }.frame(width: 358, height: 138, alignment: .leading)
            .background(Color.lightestBrown)
            .cornerRadius(18.24)
    }
}

struct SkinCareProductLongCard_Previews: PreviewProvider {
    static var previews: some View {
        SkinCareProductLongCard(StringProductName: "skincare #3", dateScanned: Date(), totalAllergen: 6)
    }
}
