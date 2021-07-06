//
//  solarSettingsView.swift
//  solarLogUI
//
//  Created by Holger Preu on 06.07.21.
//

import SwiftUI

struct solarSettingsView: View {
    
    @State var serverUrl = Constants.Network.url
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Einstellungen")
                .font(.largeTitle)
            HStack(alignment: .center) {
                Text("solarLog URL:")
                TextField("http://solarlog.myhome.com", text: $serverUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Spacer()
        }
        .padding()
    }
}

struct solarSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        solarSettingsView()
    }
}
