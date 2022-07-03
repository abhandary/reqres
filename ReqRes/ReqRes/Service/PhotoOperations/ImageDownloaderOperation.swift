//
//  ImageLoader.swift
//  IMDB Movies
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation
import UIKit

class ImageDownloaderOperation: Operation {
  //1
  let inputPhotoRecord: PhotoRecord
  var resultPhotoRecord: PhotoRecord
  
  //2
  init(_ photoRecord: PhotoRecord) {
    self.inputPhotoRecord = photoRecord
    self.resultPhotoRecord =
      PhotoRecord(url: photoRecord.url,
                  state: .failed,
                  image: UIImage(named: "Failed"))
  }
  
  //3
  override func main() {
    //4
    if isCancelled {
      return
    }
    
    guard let photoRecordUrl = inputPhotoRecord.url else {
      print("ImageDownloaderOperation: unexpected nil URL")
      return
    }
    
    //5
    /*
    do {
      let (imageData, _) = try await URLSession.shared.data(from: photoRecordUrl)
    } catch {
      print(error)
      return
    }
     */

    guard let imageData = try? Data(contentsOf: photoRecordUrl) else { return }
    
    //6
    if isCancelled {
      return
    }
    
    //7
    if !imageData.isEmpty {
      resultPhotoRecord =
        PhotoRecord(url: inputPhotoRecord.url,
                    state: .downloaded,
                    image: UIImage(data:imageData))
    } else {
      print("ImageDownloaderOperation: image data is empty")
    }
  }
}
