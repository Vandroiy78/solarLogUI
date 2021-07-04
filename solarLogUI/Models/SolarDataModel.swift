//
//  SolarDataModel.swift
//  solarLogUI
//
//  Created by Holger Preu on 10.06.21.
//

import Foundation

class SolarDataModel: ObservableObject {
    
    @Published var solarData:SolarData = SolarData()
    
    init() {
        
        // Fetch Solar Data
        solarData = getRemoteJsonFile()
    }
    
    func getRemoteJsonFile() -> SolarData {
        
        // var myData:SolarData = SolarData()
        
        // Get a URL object
        let url = URL(string: Constants.Network.url)
        
        guard url != nil else {
            print("Could not create the URL object")
            return SolarData()
        }
        
        // Get a URL Session object
        let session = URLSession.shared
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Build the JSON query
        let jsonQuery: [String:Any] = ["801" : ["170" : nil]]
        
        // Serialize the array to JSON data
        var jsonTodo : Data
        
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: jsonQuery, options: [])
            
        }
        catch {
            print ("Cannot encode JSON")
            return SolarData()
        }
        
        
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
                        let solardata = container.the170
                        return solardata
                    
                    }
                }
                
                catch {
                    print("Could not parse the JSON response")
                }
            }
        }
        
        // Call resume on the data task
        dataTask.resume()
        
        return SolarData()
        
    }
}

