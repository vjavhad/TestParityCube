//
//  NetWorkManager.swift
//
//  Created by ViJay Avhad on 12/06/18.
//  Copyright © 2018 ViJay Avhad. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()
let BASEURL = "https://api.desidime.com/v3/deals/"

class NetWorkManager : NSObject{
    
    @discardableResult func callService(_ paramString: String, myCallback: @escaping ([String: Any]?) -> Void) -> URLSessionTask {
        
        let url:URL = URL(string:BASEURL+paramString)!
        
        let session = URLSession.shared
        var request = URLRequest(url: url as URL)
        
        request.httpMethod = "GET"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        request.addValue("7d7c5cacb355d043f07c7c9e4b38257ea5683f8d643b578683877a9b6a8bee1b", forHTTPHeaderField: "X-Desidime-Client")
        
        let task = session.dataTask(with: request, completionHandler:{ (data, response, err) in
            if err != nil {
                print("Cannot get response // internet errrorr...")
                self.showAlert("Make sure your device is connected to the internet.", title: "Unable to connect.")
            } else {
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        do {
                            if let data = data, let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                                
                                DispatchQueue.main.async{
                                    myCallback(jsonResult)
                                }
                            }
                        } catch let JSONError as NSError {
                            print("JSONError \(JSONError)")
                            self.showAlert("Unable Process your request.", title: "")
                        }
                    }
                }else{
                    
                }
            }
        })
        task.resume()
        return task
    }
    
    class func downloadImageFrom(urlString: String,imgView :UIImageView) {
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!) else {
            imgView.image = #imageLiteral(resourceName: "plchldr");
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            imgView.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data) {
                        imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                    }
                    imgView.image = UIImage(data: data)
                    if(imgView.image == nil){
                        imgView.image = #imageLiteral(resourceName: "plchldr");
                    }
                }
               
            }.resume()
        }
    }
    
    func showAlert(_ message: String="Default message",title:String = ""){
        
        let alertController = UIAlertController(title: title,  message: message, preferredStyle:.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action -> Void in
        })
    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}



