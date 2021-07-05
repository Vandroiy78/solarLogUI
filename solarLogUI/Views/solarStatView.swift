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
            Text("Installiert: " + prettyPrint(model.solarData.totalPower, "W"))
                .padding()
            HStack {
                VStack(alignment: .leading) {
                    Text("Jetzt:")
                    Text("Heute:")
                    Text("Gestern:")
                    Text("Monat:")
                    Text("Jahr:")
                    Text("Gesamt:")
                }
                VStack(alignment: .trailing) {
                    Text(prettyPrint(model.solarData.pdc, "W"))
                    Text(prettyPrint(model.solarData.yieldDay, "Wh"))
                    Text(prettyPrint(model.solarData.yieldYesterday, "Wh"))
                    Text(prettyPrint(model.solarData.yieldMonth, "Wh"))
                    Text(prettyPrint(model.solarData.yieldYear, "Wh"))
                    Text(prettyPrint(model.solarData.yieldTotal, "Wh"))
                }
                VStack(alignment: .trailing) {
                    Text(prettyPrint(model.solarData.consPac, "W"))
                    Text(prettyPrint(model.solarData.consYieldDay, "Wh"))
                    Text(prettyPrint(model.solarData.consYieldYesterday, "Wh"))
                    Text(prettyPrint(model.solarData.consYieldMonth, "Wh"))
                    Text(prettyPrint(model.solarData.consYieldYear, "Wh"))
                    Text(prettyPrint(model.solarData.consYieldTotal, "Wh"))
                }
                VStack(alignment: .trailing) {
                    printBalance(yield: model.solarData.pdc, cons: model.solarData.consPac, unit: "W")
                    printBalance(yield: model.solarData.yieldDay, cons: model.solarData.consYieldDay, unit: "Wh")
                    printBalance(yield: model.solarData.yieldYesterday, cons: model.solarData.consYieldYesterday, unit: "Wh")
                    printBalance(yield: model.solarData.yieldMonth, cons: model.solarData.consYieldMonth, unit: "Wh")
                    printBalance(yield: model.solarData.yieldYear, cons: model.solarData.consYieldYear, unit: "Wh")
                    printBalance(yield: model.solarData.yieldTotal, cons: model.solarData.consYieldTotal, unit: "Wh")
                }
            }
            .padding()
            .background(Color(.gray).opacity(0.2))
            .cornerRadius(10)
            
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
    }
    
    // converts a number to 'kilo' or 'mega' if applicable and displays it with the according unit (with k or M as prefix)
    func prettyPrint(_ number:Int, _ unit:String) -> String {
        
        var myReturn: String
        
        if abs(number) < 1000 {
            myReturn = String("\(number) \(unit)")
        }
        else if abs(number) < 1000000 {
            let roundedNumber = (Double(number)/1000.0 * 100).rounded() / 100
            myReturn = String("\(roundedNumber) k\(unit)")
        }
        else {
            let roundedNumber = (Double(number)/1000000.0 * 100).rounded() / 100
            myReturn = String("\(roundedNumber) M\(unit)")
        }

        return myReturn
    }
    
    // print the balance including unit
    // set textcolor to green if the balance is greater or equal to zero, else set it to red
    func printBalance(yield:Int, cons:Int, unit:String) -> some View {
        var balance:Int
        let myGreen = Color(.sRGB, red: 0, green: 0.7, blue: 0.2, opacity: 1.0)
        
        balance = yield - cons
        return Text(prettyPrint(balance, unit))
            .foregroundColor(balance >= 0 ? myGreen : .red)
    }
}

struct solarStatView_Previews: PreviewProvider {
    static var previews: some View {
        solarStatView()
            .environmentObject(SolarDataModel())
    }
}
