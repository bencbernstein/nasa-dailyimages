//
//  NASA.swift
//  Predict The Sky
//
//  Created by Benjamin Bernstein on 2/14/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import UIKit

// if a closure is passed as an argument to a function and it is invoked after the function returns, it's escpaing


class NASA {
    var title = String()
    var imagePlanet = UIImage()
    
    class func makePlanetTest(date:String, addPlanet: @escaping (PlanetStruct) -> Void) {
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=BWfyjXwysE18Wf2RmiBx6nvZBwsxKH0uAuoEkIv2&date=\(date)")
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            // completion handler
            if let e = error {
                print ("Error reaching the url : \(e)")
            } else {
                // no errors
                // check for response ..
                if let res = response as? HTTPURLResponse {
                    print ("got the response with responce doe \(res.statusCode)")
                    // if youre going to go through the trouble of making the urlresponse then check for 200 or something
                    if let safeData = data {
                        let json = try! JSONSerialization.jsonObject(with: safeData, options: [])
                        var JSON = json as? [String : String]
                        if let url = JSON?["url"], let title = JSON?["title"] {
                            let secureUrl = convertFrom(insecureURL: url)
                            let planet = PlanetStruct(title: title, imgUrl: secureUrl)
                            addPlanet(planet)
                        }
                        
                    }
                }
            }
        }
        task.resume()

        
        
    }

    class func convertFrom(insecureURL: String) -> String {
        var secureURL = String(describing: insecureURL)
        secureURL.insert("s", at: secureURL.index(secureURL.startIndex, offsetBy: 4))
        //secureURL.insert("/", at: secureURL.index(secureURL.startIndex, offsetBy: 6))
        print ("secure string is now \(secureURL)")
        return secureURL
    }
    
    func convertToSecure(insecureURL: String) -> String {
        var secureURL = String(describing: insecureURL)
        secureURL.insert("s", at: secureURL.index(secureURL.startIndex, offsetBy: 4))
        //secureURL.insert("/", at: secureURL.index(secureURL.startIndex, offsetBy: 6))
        print ("secure string is now \(secureURL)")
        return secureURL
    }
    
    class func downloadPic(picURL: String, handler: @escaping (Data) -> Void){
        let picURL = Foundation.URL(string: picURL)
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: picURL!)
        let downloadPicTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            // the download has finished
            if let e = error {
                print ("Error downloading the picture : \(e)")
            } else {
                // no errors
                // check for response ...
                if let res = response as? HTTPURLResponse {
                    print ("Downloaded the picture with response code \(res.statusCode)")
                    if let imageData = data {
                        handler(imageData)
                    } else {
                        print("Couldn't get any images, the image is nil")
                    }
                } else {
                    print ("Couldn't get response code for some reason")
                    
                }
            }
        }
        
        downloadPicTask.resume()
        
    }

    
//    func downloadPic(picURL: String, handler: @escaping (Bool) -> Void){
//        let picURL = Foundation.URL(string: picURL)
//        var returnImage = UIImage()
//        let session = URLSession(configuration: .default)
//        let request = URLRequest(url: picURL!)
//        let downloadPicTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
//            // the download has finished
//            if let e = error {
//                print ("Error downloading the picture : \(e)")
//            } else {
//                // no errors
//                // check for response ...
//                if let res = response as? HTTPURLResponse {
//                    print ("Downloaded the picture with response code \(res.statusCode)")
//                    if let imageData = data {
//                        DispatchQueue.main.async {
//                            // convert the data into an image
//                            returnImage = UIImage(data: imageData)!
//                            print("Image after response code statement is now this \(returnImage)")
//                            // we just set the handler to true!!
//                            self.imagePlanet = returnImage
//                            handler(true)
//                        }
//                    } else {
//                        print("Couldn't get any images, the image is nil")
//                    }
//                } else {
//                    print ("Couldn't get response code for some reason")
//                    
//                }
//            }
//        }
//        
//        downloadPicTask.resume()
//    
//    }
//    
//    
    
    
    
}





