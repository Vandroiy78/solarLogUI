//
//  solarStatView.swift
//  solarLogUI
//
//  Created by Holger Preu on 10.06.21.
//

import SwiftUI

struct solarStatView: View {
    
    @EnvironmentObject var model:SolarDataModel
    
    var body: some View {
        VStack {
            Text("SolarLog")
                .font(.largeTitle)
                .padding()
            Text("Installiert:")
                .padding()
            HStack {
                VStack {
                    Text("Jetzt:")
                    Text("Heute:")
                }
                VStack(alignment: .trailing) {
                    Text("4.00 kW")
                    Text("2.31 kWh")
                }
                VStack(alignment: .trailing) {
                    Text("2.69 kW")
                    Text("1.34 kWh")
                }
            }
            Button(action: {
                
            }, label: {
                HStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text("Neu laden")
                }
            })
            .padding()
            Text("Daten von: ")
                .font(.footnote)
        }
    }
}

struct solarStatView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            solarStatView()
                .preferredColorScheme(.dark)
                .environmentObject(SolarDataModel())
            solarStatView()
                .preferredColorScheme(.light)
                .environmentObject(SolarDataModel())
        }
    }
}
