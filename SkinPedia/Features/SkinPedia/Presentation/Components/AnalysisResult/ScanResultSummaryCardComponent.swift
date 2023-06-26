//
//  ScanResultSummaryCardComponent.swift
//  SkinPedia
//
//  Created by Rainer Regan on 22/06/23.
//

import SwiftUI

struct ScanResultSummaryCardComponent: View {
    let allergentsCount: Int
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Warning!").font(.title2).fontWeight(.semibold)
            Text("We have found").font(.body)
            
            ZStack{
                Circle()
                    .fill(.yellow)
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
