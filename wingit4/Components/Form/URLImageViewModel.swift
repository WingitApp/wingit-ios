//
//  URLImageViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 9/11/21.
//

import SwiftUI

class URLImageViewModel: ObservableObject {
  @Published var image: UIImage?
  @Published var isImageLoading: Bool = true
  var urlString: String?
  var imageCache = ImageCache.getImageCache()
  
  init(urlString: String?) {
    self.urlString = urlString
    loadImage()
  }
  
  func loadImage() {
    if loadImageFromCache() {
        return
    }
    
    loadImageFromUrl()
  }
  
  func loadImageFromCache() -> Bool {
    guard let urlString = urlString else { return false }
    
    guard let cacheImage = imageCache.get(forKey: urlString) else {
      return false
    }
    
    image = cacheImage
    return true
  }
  func loadImageFromUrl() {
    guard let urlString = urlString else { return }
    
    guard let url = URL(string: urlString) else {
      return
    }
    
    let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
    task.resume()
  }
  
  func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
    guard error == nil else {
      print("Error: \(error!)")
      return
    }
    
    guard let data = data else {
      print("No data found")
      return
    }
    
    DispatchQueue.main.async {
      guard let loadedImage = UIImage(data: data) else {
        return
      }
      
      self.image = loadedImage
      self.imageCache.set(forKey: self.urlString!, image: loadedImage)
    }
    
    
    
  }
}

/**
 Add / retreive image to cache
 */
class ImageCache {
  var cache = NSCache<NSString, UIImage>()
  
  func get(forKey: String) -> UIImage? {
    return cache.object(forKey: NSString(string: forKey))
  }
  
  func set(forKey: String, image: UIImage) -> Void {
    return cache.setObject(image, forKey: NSString(string: forKey))
  }
}


extension ImageCache {
  private static var imageCache = ImageCache()
  
  static func getImageCache() -> ImageCache {
    return imageCache
  }
}
