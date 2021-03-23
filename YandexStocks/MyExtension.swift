//
//  MyExtension.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import Foundation
import UIKit


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension UIButton{

    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }

}


extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}
let imageCache = NSCache<NSString, UIImage>()
extension UIImageView{
        func imageFromServerURL(symbol: String, placeHolder: UIImage?) {
            
            DispatchQueue.main.async { [weak self] in
                self?.image = placeHolder
            }
//            let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            if let cachedImage = imageCache.object(forKey: NSString(string: symbol)) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = cachedImage
                }
                print("DEBAG: cache image \(symbol)")
                return
            }
            DispatchQueue.global(qos: .background).async {
                NetworkManager().getLogo(symbol: symbol) { (image) in
                    if let image = image{
                        DispatchQueue.main.async { [weak self] in
                            imageCache.setObject(image, forKey: NSString(string: symbol))
                            self?.image = image
                            print("DEBAG: download image \(symbol)")
                        }
                    } else{
                        DispatchQueue.main.async { [weak self] in
                            self?.image = placeHolder
                        }
                    }
                }
            }

//            if let url = URL(string: imageServerUrl) {
//
//                let request = URLRequest(url: url)
////                    request.setValue("iOSClient", forHTTPHeaderField: "User-Agent")
//
//                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                    if error != nil {
//                        print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
//                        DispatchQueue.main.async {
//                            self.image = placeHolder
//                        }
//                        return
//                    }
//                    DispatchQueue.main.async {
//                        if let data = data {
//                            if let downloadedImage = UIImage(data: data) {
//                                imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
//                                self.image = downloadedImage
//                            }
//                        }
//                    }
//                }).resume()
//            }
        }
}
