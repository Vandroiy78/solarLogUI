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
                        Text("Stat")
                    }
                }
        } .environmentObject(SolarDataModel())
    }
}

struct solarTabView_Previews: PreviewProvider {
    static var previews: some View {
        solarTabView()
    }
}
