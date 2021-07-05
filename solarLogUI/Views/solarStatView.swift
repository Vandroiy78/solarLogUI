//
//  solarStatView.swift
//  solarLogUI
//
//  Created by Holger Preu on 10.06.21.
//

import SwiftUI

struct solarStatView: View {
    
    @EnvironmentObject var model:SolarDataModel
    let myGreen = Color(.sRGB, red: 0, green: 0.7, blue: 0.2, opacity: 1.0)
    
    var body: some View {
        VStack {
            Text("SolarLog")
                .font(.largeTitle)
                .padding()
            Text("Installiert: " + prettyPrint(model.solarData.totalPower, "W"))
                .padding()
            HStack {
                VStack {
                    Text("Jetzt:")
                    Text("Heute:")
                }
                VStack(alignment: .trailing) {
                    Text(prettyPrint(model.solarData.pdc, "W"))
                    Text("2.31 kWh")
                }
                VStack(alignment: .trailing) {
                    Text(prettyPrint(model.solarData.consPac, "W"))
                    Text("1.34 kWh")
                }
                VStack(alignment: .trailing) {
                    let balance =  model.solarData.pdc - model.solarData.consPac
                    
                    Text(prettyPrint(balance, "W"))
                        .foregroundColor(balance >= 0 ? myGreen : .red)
                    Text("1.34 kWh")
                }
            }
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
    
    func printPowerValue(_ label:UILabel, _ prefix:String, _ value:Int, _ unit:String) {
        label.text = "\(prefix): \(prettyPrint(value, unit))"
    }
    
    func printBalance(_ label:UILabel, yield:Int, cons:Int, unit:String) {
        var balance:Int
        balance = yield - cons
        label.text = prettyPrint(balance, unit)
        if balance >= 0 {
            label.textColor = UIColor(red: 0, green: 0.7, blue: 0.2, alpha: 1.0)
        }
        else {
            label.textColor = .red
        }
    }
}

struct solarStatView_Previews: PreviewProvider {
    static var previews: some View {
        solarStatView()
            .environmentObject(SolarDataModel())
    }
}
