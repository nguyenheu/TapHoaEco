//
//  ServiceCall.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import Foundation

class ServiceCall {
    class func post(parameter: [String: Any], path: String, isToken: Bool = false, withSuccess: @escaping (AnyObject?) -> (), failure: @escaping (Error?) -> ()) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let parameterData = NSMutableData()
            let dictKeys = parameter.keys
            var i = 0
            
            for key in dictKeys {
                if let value = parameter[key] as? String {
                    parameterData.append(String(format: "%@%@=%@", i == 0 ? "" : "&", key, value.replacingOccurrences(of: "+", with: "%2B")).data(using: .utf8)!)
                } else {
                    parameterData.append(String(format: "%@%@=%@", i == 0 ? "" : "&", key, String(describing: parameter[key]!)).data(using: .utf8)!)
                }
                i += 1
            }
            
            var request = URLRequest(url: URL(string: path)!, timeoutInterval: 20)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            if isToken {
//                #if DEBUG
//                request.addValue("JdivWokmEzOtrDVj8Y2X", forHTTPHeaderField: "access_token")
//                #else
//                if let token = MainViewModel.shared.userObj.authToken {
                    request.addValue(MainViewModel.shared.userObj.authToken, forHTTPHeaderField: "access_token")
//                }
//                #endif
            }
            
            request.httpMethod = "POST"
            request.httpBody = parameterData as Data
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                } else {
                    if let data = data {
                        do {
                            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
//                            debugPrint("response: ", jsonDictionary ?? 0)
                            
                            DispatchQueue.main.async {
                                withSuccess(jsonDictionary)
                            }
                        } catch {
                            DispatchQueue.main.async {
                                failure(error)
                            }
                        }
                    }
                }
                
                guard data != nil else { return }
            }
            task.resume()
        }
    }
}
