//
//  Networking.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import Foundation

class Networking {
    var session = URLRequest(url: URL(string:
                                        "https://tyfnvcpyad.execute-api.us-west-1.amazonaws.com/default/helloworldserverless")!)
    var task = URLSessionDataTask()
    func spitjson() -> [String: Any] {
        var result:[String: Any] = ["DD": (Any).self]
        let samplejson = Testjson(val1: 1, val2: 2)
        do {
        let encodedData = try JSONEncoder().encode(samplejson)
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String: Any] {
                return json
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return result
    }
    func spitdata() -> Data {
        var result:[String: Any] = ["DD" : "failure"]
        let samplejson = Testjson(val1: 50000000, val2: 500000000)
        var encodedData = Data()
        do {
            var encoder = JSONEncoder()
           // encoder.outputFormatting = .withoutEscapingSlashes
            
        encodedData = try encoder.encode(samplejson)
            
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return encodedData
    }
    func exampleGet() async {
        var awsurl = URL(string: "https://tyfnvcpyad.execute-api.us-west-1.amazonaws.com/default/helloworldserverless")!
        var mainsesh = URLSession(configuration: .default)
        var request = URLRequest(url: awsurl)
        do {
            print(String(data: spitdata(), encoding: .utf8))
            var main = mainsesh.dataTask(with: request, completionHandler: {data, response, error in
                var str = String(data: data!, encoding: .utf8)
                print(str)
            })
            main.resume()
        } catch {"networking error"}
    }
}
