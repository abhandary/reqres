//
//  PhotoRecord.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/2/22.
//

import Foundation
import UIKit

// This enum contains all the possible states a photo record can be in
enum PhotoRecordState {
  case new, downloaded, filtered, failed
}

struct PhotoRecord {
  let url: URL?
  let state: PhotoRecordState
  let image: UIImage?
  
  init(url:URL?, state: PhotoRecordState, image: UIImage?) {
    self.url = url
    self.state = state
    self.image = image
  }
}
