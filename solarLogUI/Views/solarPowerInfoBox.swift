//
//  solarPowerInfoBox.swift
//  solarLogUI
//
//  Created by Holger Preu on 16.10.21.
//

import SwiftUI

struct solarPowerInfoBox: View {
    
    var powerNow:Int
    var powerToday:Int
    var powerYesterday:Int
    var powerMonth:Int
    var powerYear:Int
    var powerTotal:Int
    var boxTitle:String
    var dynamicColor:Bool
    var fixedColor:Color?
    
    var body: some View {
        
        VStack {

            HStack {
                Text(boxTitle)
                    .font(.title3)
                    .padding(0.25)
                
                VStack(alignment: .leading) {
                    Text("Jetzt:")
                    Text("Heute:")
                    Text("Gestern:")
                    Text(Utilities.getDatePartAsString("MMMM") + ":")
                    Text(Utilities.getDatePartAsString("yyyy") + ":")
                    Text("Gesamt:")
                }
                VStack(alignment: .trailing) {
                    Text(Utilities.prettyPrint(powerNow, "W"))
                    Text(Utilities.prettyPrint(powerToday, "Wh"))
                    Text(Utilities.prettyPrint(powerYesterday, "Wh"))
                    Text(Utilities.prettyPrint(powerMonth, "Wh"))
                    Text(Utilities.prettyPrint(powerYear, "Wh"))
                    Text(Utilities.prettyPrint(powerTotal, "Wh"))
                }
                .foregroundColor(dynamicColor ? Color.green : fixedColor)
            }
        }
        .padding()
        .background(Color(.gray).opacity(0.2))
        .cornerRadius(10)
        //.font(.custom("Courier", fixedSize: 24))
    }
    
    private func determineColor() -> Color {
        var returnColor:Color = Color.black
        
        if dynamicColor {
            
        }
        else {
            if fixedColor != nil {
                returnColor = fixedColor!
            }
        }
        
        return returnColor
    }
}

struct solarPowerInfoBox_Previews: PreviewProvider {
    static var previews: some View {
        solarPowerInfoBox(powerNow: 3, powerToday: 30, powerYesterday: 40, powerMonth: 50, powerYear: 60, powerTotal: 100, boxTitle: "Produktion", dynamicColor: true)
    }
}
