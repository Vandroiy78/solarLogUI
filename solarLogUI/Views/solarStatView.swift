//
//  solarStatView.swift
//  solarLogUI
//
//  Created by Holger Preu on 10.06.21.
//

import SwiftUI

struct solarStatView: View {
    
    @EnvironmentObject var model:SolarDataModel
    @Environment(\.scenePhase) var scenePhase
    
    let myGreen = Color(.sRGB, red: 0, green: 0.7, blue: 0.2, opacity: 1.0)
    
    var body: some View {
        ScrollView {
            VStack {
                Text("SolarLog")
                    .font(.largeTitle)
                    .padding(.bottom, 0.25)
                Text("Installiert: " + Utilities.prettyPrint(model.solarData.totalPower, "W"))
                    .padding(.bottom, 0.25)
                
                // Yield
                solarPowerInfoBox(powerNow: model.solarData.pdc, powerToday: model.solarData.yieldDay, powerYesterday: model.solarData.yieldYesterday, powerMonth: model.solarData.yieldMonth, powerYear: model.solarData.yieldYear, powerTotal: model.solarData.yieldTotal, boxTitle: "Produktion", dynamicColor: false, fixedColor: myGreen)
                
                // Consumption
                solarPowerInfoBox(powerNow: model.solarData.consPac, powerToday: model.solarData.consYieldDay, powerYesterday: model.solarData.consYieldYesterday, powerMonth: model.solarData.consYieldMonth, powerYear: model.solarData.consYieldYear, powerTotal: model.solarData.consYieldTotal, boxTitle: "Verbrauch", dynamicColor: false, fixedColor: Color.red)
                
                // Balance
                solarPowerInfoBox(powerNow: model.solarData.pdc - model.solarData.consPac, powerToday: model.solarData.yieldDay - model.solarData.consYieldDay, powerYesterday: model.solarData.yieldYesterday - model.solarData.consYieldYesterday, powerMonth: model.solarData.yieldMonth - model.solarData.consYieldMonth, powerYear: model.solarData.yieldYear - model.solarData.consYieldYear, powerTotal: model.solarData.yieldTotal - model.solarData.consYieldTotal, boxTitle: "Bilanz", dynamicColor: false, fixedColor: Color.blue)
                
                
                // Graph
                solarGaugeView(totalPower: model.solarData.totalPower, currentPower: model.solarData.pdc, title: "Jetzt:")
                    .padding()
                
                Button(action: {
                    model.updateData()
                }, label: {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                        Text("Neu laden")
                    }
                })
                .padding()
                
                Text("Daten von: \(model.solarData.lastUpdateTime) ")
                    .font(.footnote)
            }
            .onChange(of: scenePhase, perform: { newPhase in
                if newPhase == .active {
                    model.updateData()
                }
        })
        }
    }
    
    // print the balance including unit
    // set textcolor to green if the balance is greater or equal to zero, else set it to red
    func printBalance(yield:Int, cons:Int, unit:String) -> some View {
        var balance:Int
        let myGreen = Color(.sRGB, red: 0, green: 0.7, blue: 0.2, opacity: 1.0)
        
        balance = yield - cons
        return Text(Utilities.prettyPrint(balance, unit))
            .foregroundColor(balance >= 0 ? myGreen : .red)
    }
}

struct solarStatView_Previews: PreviewProvider {
    static var previews: some View {
        solarStatView()
            .environmentObject(SolarDataModel())
    }
}
