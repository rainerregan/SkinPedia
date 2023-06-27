//
//  ScanResultSummaryCardComponent.swift
//  SkinPedia
//
//  Created by Rainer Regan on 22/06/23.
//

import SwiftUI

struct ScanResultSummaryCardComponent: View {
    let allergentsCount: Int
    
    func getColor(count: Int) -> Color {
        switch count{
        case 0:
            return Color.green
        case 1...5:
            return Color.customYellow
        case let x where x > 5:
            return Color.red
        default:
            return Color.green
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Warning!").font(.title2).fontWeight(.semibold)
            Text("We have found").font(.body)
            
            ZStack{
                Circle()
                    .fill(getColor(count: allergentsCount))
                    .frame(width: 150, height: 150)
                VStack{
                    Text("\(allergentsCount)").font(.title).fontWeight(.semibold)
                    Text("Allergents")
                }
            }
            
            Text("From the total ingredients")
        }
        .padding(.vertical, 16)
    }
}

struct ScanResultSummaryCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        ScanResultSummaryCardComponent(allergentsCount: 10)
    }
}
