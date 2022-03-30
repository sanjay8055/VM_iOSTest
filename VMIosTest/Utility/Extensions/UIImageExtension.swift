//
//  UIImageExtension.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import UIKit

var cache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(_ from: URL) {
        
        //set placeholder image
        self.image = UIImage(named: "person.circle")
        //check if image present in cache
        if let image = cache.object(forKey: from.lastPathComponent as NSString) {
            DispatchQueue.main.async {
                self.image = image
            }
            return
        }
        
        //download image from url
        let request = URLRequest(url: from)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, error == nil, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
                cache.setObject(image, forKey: from.lastPathComponent as NSString)
                //imageDict[from.lastPathComponent] = data
            }
        }.resume()
    }
}
