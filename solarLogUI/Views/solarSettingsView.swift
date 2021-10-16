//
//  solarSettingsView.swift
//  solarLogUI
//
//  Created by Holger Preu on 06.07.21.
//

import SwiftUI

struct solarSettingsView: View {
    
    @EnvironmentObject var model:SolarDataModel
    @State var serverUrl = ""
    @State var serverPort = "80"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Einstellungen")
                .font(.largeTitle)
            HStack(alignment: .center) {
                Text("solarLog URL:")
                TextField("solarlog.myhome.com", text: $serverUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: serverUrl, perform: { value in
                        model.updateBaseUrl(value: serverUrl)
                        Utilities.saveSettings(value: serverUrl, key: "baseUrl")
                    })
            }
            HStack(alignment: .center) {
                Toggle(isOn: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/, label: {
                    Text("Encrypted")
                })

            }
            HStack(alignment: .center) {
                Text("Port:")
                TextField("443", text: $serverPort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Spacer()
        }
        .onAppear {
            serverUrl = model.baseUrl
        }
        .padding()
    }
}

struct solarSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        solarSettingsView()
    }
}
