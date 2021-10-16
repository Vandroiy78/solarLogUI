//
//  SolarDataModel.swift
//  solarLogUI
//
//  Created by Holger Preu on 10.06.21.
//

import Foundation

class SolarDataModel: ObservableObject {
    
    @Published var solarData:SolarData = SolarData()
    var baseUrl = Constants.Network.baseUrl
    
    init() {
        
        // Fetch Solar Data
        updateData()
    }
    
    func updateData() {
        getRemoteJsonFile()
    }
    
    func updateBaseUrl(value:String) {
        self.baseUrl = value
    }
    
    func getRemoteJsonFile() {
        
        // var myData:SolarData = SolarData()
        
        // Get a URL object
        let url = URL(string: Constants.Network.url)
        
        guard url != nil else {
            print("Could not create the URL object")
            return
        }
        
        // Get a URL Session object
        let session = URLSession.shared
        
        // create http request and prepare headers
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // handle Basic Authentication
        if Constants.Network.useBasicAuth {
            let loginData = String(format: "%@:%@", Constants.Network.basic_auth_user, Constants.Network.basic_auth_password).data(using: String.Encoding.utf8)!
            let base64LoginData = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        }
        
        // Build the JSON query
        let jsonQuery: [String:Any] = ["801" : ["170" : nil]]
        
        // Serialize the array to JSON data
        var jsonTodo : Data
        
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: jsonQuery, options: [])
            
            // Get a data task object
            let dataTask = session.uploadTask(with: request, from: jsonTodo) { (data, urlreponse, error) in
                
                // Check that there wasn't an error
                if error == nil && data != nil {
                    do {
                        
                        // Create a JSON Decoder object
                        let decoder = JSONDecoder()
                        
                        // Parse the JSON
                        let myDecodedData = try decoder.decode(Welcome.self, from: data!)
                        
                        if let container = myDecodedData.the801 {
                            DispatchQueue.main.async {
                                self.solarData = container.the170
                            }
                        }
                    }
                    
                    catch {
                        print("Could not parse the JSON response")
                    }
                }
            }
            
            // Call resume on the data task
            dataTask.resume()
        }
        catch {
            print ("Cannot encode JSON")
        }
        
    }
}

