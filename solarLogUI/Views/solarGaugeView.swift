//
//  solarGaugeView.swift
//  solarLogUI
//
//  Created by Holger Preu on 06.07.21.
//

import SwiftUI

struct solarGaugeView: View {
    
    var totalPower:Int
    var currentPower:Int
    var title:String
    
    
    var body: some View {
        // Graph
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0.0) {
                let percentage = totalPower == 0 ? 0 : Double(currentPower) / Double(totalPower)
                let percentageText = String((percentage * 100).rounded()) + "%"
                
                Text("\(title) \(percentageText)")
                HStack(spacing: 0.0) {
                    Rectangle()
                        .frame(width: CGFloat(percentage) * geo.size.width)
                        .foregroundColor(.green).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    Rectangle()
                        .foregroundColor(.red).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                }
                .frame(height: 20.0)
                .cornerRadius(10.0)
                
                HStack {
                    Text("0%")
                    Spacer()
                    Text("50%")
                    Spacer()
                    Text("100%")
                }
                .font(.footnote)
            }
        }
    }
}

struct solarGaugeView_Previews: PreviewProvider {
    static var previews: some View {
        solarGaugeView(totalPower: 100, currentPower: 70, title: "Jetzt:")
    }
}
