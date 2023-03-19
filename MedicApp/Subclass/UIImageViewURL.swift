//
//  UIImageViewURL.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import UIKit

fileprivate var imageCache = NSCache<AnyObject, AnyObject>()

class UIImageViewURL: UIImageView {
    
    var task: URLSessionDataTask!
    var loadingView = UIActivityIndicatorView(style: .medium)
    
    func loadImage(imageURL: URL) {
        image = nil
        
        startAnimating()
        
        if let task = task {
            task.cancel()
        }
        
        if let imageCache = imageCache.object(forKey: imageURL.absoluteURL as AnyObject) as? UIImage {
            self.image = imageCache
            removeLoadingView()
            return
        }
        
        task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
            
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.removeLoadingView()
                }
                return
            }
            
            imageCache.setObject(image, forKey: imageURL.absoluteURL as AnyObject)
            
            DispatchQueue.main.async {
                self?.image = image
                self?.removeLoadingView()
            }
            
        }
        task.resume()
        
    }
    
    private func startLoadingView() {
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.startAnimating()
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func removeLoadingView() {
        loadingView.removeFromSuperview()
    }
    
}
