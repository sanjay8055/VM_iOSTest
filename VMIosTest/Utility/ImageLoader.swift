//
//  ImageLoader.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import UIKit


class ImageLoader {
    static let shared = ImageLoader()
    var cache = NSCache<NSString, UIImage>()

    private init() {
        cache.countLimit = 20
    }
    
    func loadImage(_ from: URL) -> UIImage? {
        
        if let image = cache.object(forKey: from.lastPathComponent as NSString) {
            return image
        }
        
        getImageFromServer(request: URLRequest(url: from), completion: { image in
            if let image = image {
                self.cache.setObject(image, forKey: (from.lastPathComponent as NSString))
            }
        })
       
    }
    
    func getImageFromServer(request: URLRequest, completion: (UIImage?)-> Void)  {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, error == nil {
                completion(UIImage(data: data))
            } else {
                print(error?.localizedDescription as Any)
                return completion(nil)
            }
        }.resume()
    }
}
