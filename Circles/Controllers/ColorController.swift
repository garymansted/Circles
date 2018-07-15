//
//  ColorController.swift
//  Circles
//
//  Created by Gary Mansted on 13/7/18.
//  Copyright © 2018 Gary Mansted. All rights reserved.
//

import Foundation
import UIKit

class ColorController {
    static func getRandomColor(completion: @escaping (String?, UIColor) -> ()) {
        var errorString: String? = nil
        var randomColor = UIColor()
        DispatchQueue.global(qos: .userInteractive).async {
            var request = URLRequest(url: RANDOM_COLOR_GENERATOR_URL!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: [], options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                do {
                    var dta = Data()
                    if let d = data {
                        dta = d
                    }
                    else {
                        DispatchQueue.main.async {
                            print("Network Failure")
                            completion("FAILED", randomColor)
                        }
                        return
                    }
                    let json = try JSONSerialization.jsonObject(with: dta)
                    let JS = json as! NSArray
                    for rgbDictionary in JS {
                        let dic = rgbDictionary as! NSDictionary
                        if let rgb = dic.object(forKey: "rgb") as? NSDictionary {
                            if let red = rgb.object(forKey: "red") {
                                if let green = rgb.object(forKey: "green") {
                                    if let blue = rgb.object(forKey: "blue") {
                                        randomColor = UIColor(red: CGFloat(red as! Int) / 255, green: CGFloat(green as! Int) / 255, blue: CGFloat(blue as! Int) / 255, alpha: 1)
                                    }
                                }
                            }
                        }
                    }
                }
                catch {
                    errorString = "FAILED"
                }
                DispatchQueue.main.async {
                    completion(errorString, randomColor)
                }
            })
            task.resume()
        }
    }
}
