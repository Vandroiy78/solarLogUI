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
        getRemoteJsonFile()
    }
    
    func updateData() {
        getRemoteJsonFile()
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
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
            
            /*
            let dataTask2 = session.dataTaskPublisher(for: request)
                .map { $0.data
                    
                    
                }
                .decode(type: Welcome.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
            
            let cancellableSink = dataTask2
                .sink(receiveCompletion: { completion in
                        print(".sink() received the completion", String(describing: completion))
                        switch completion {
                            case .finished:
                                break
                            case .failure(let anError):
                                print("received error: ", anError)
                        }
                }, receiveValue: { someValue in
                    print(".sink() received \(someValue)")
                })*/
            
            // Call resume on the data task
            dataTask.resume()
        }
        catch {
            print ("Cannot encode JSON")
        }
        
    }
}

