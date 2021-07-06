//
//  solarTabView.swift
//  solarLogUI
//
//  Created by Holger Preu on 10.06.21.
//

import SwiftUI

struct solarTabView: View {
    var body: some View {
        TabView {
            solarStatView()
                .tabItem {
                    VStack {
                        Image(systemName: "sun.max")
                        Text("Leistungsdaten")
                    }
                }
            solarSettingsView()
                .tabItem {
                    Image(systemName: "gearshape.2.fill")
                    Text("Einstellungen")
                }
        } .environmentObject(SolarDataModel())
    }
}

struct solarTabView_Previews: PreviewProvider {
    static var previews: some View {
        solarTabView()
    }
}
