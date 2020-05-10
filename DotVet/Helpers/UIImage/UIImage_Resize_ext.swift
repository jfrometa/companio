//
//  UIImage_Resize_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 5/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

extension UIImage {
  func resize(scaledToSize newSize: CGSize) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    draw(in: CGRect(origin: CGPoint.zero,
                    size: CGSize(width: newSize.width,
                                 height: newSize.height)))
    let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
  }

  func scaleImageWithDivisor(img: UIImage, divisor: CGFloat) -> UIImage {
    let size = CGSize(width: img.size.width / divisor, height: img.size.height / divisor)
    UIGraphicsBeginImageContext(size)
    img.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return scaledImage!
  }

  enum CompressQuality: CGFloat {
    case lowest = 0
    case low = 0.25
    case medium = 0.5
    case high = 0.75
    case highest = 1

    var nextQualityDesc: CompressQuality? {
      switch self {
      case .highest:
        return .high
      case .high:
        return .medium
      case .medium:
        return .low
      case .low:
        return .lowest
      case .lowest:
        return nil
      }
    }
  }

  /// Returns the data for the specified image in JPEG format.
  /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
  /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    
  func jpeg(_ jpegQuality: CompressQuality) -> Data? {
    return jpegData(compressionQuality: jpegQuality.rawValue)
  }

  func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
    let width: CGFloat = size.width + x
    let height: CGFloat = size.height + y
    UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
    let origin: CGPoint = CGPoint(x: (width - size.width) / 2, y: (height - size.height) / 2)
    draw(at: origin)
    let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return imageWithPadding
  }

  /**
     Tries to compress image size to a specific number of bytes
   - parameters:
    - bytes: The max limit in bytes that the image should have
   - returns: A new object that is under the number of bytes specified by the client. In case its impossible it will return nil
   */
  func compress(to bytes: Int) -> Data? {
    var quality: CompressQuality? = .highest
    while quality != nil {
      if let newData = self.jpeg(quality!) {
        if newData.count < bytes {
          return newData
        } else {
          quality = quality!.nextQualityDesc
        }
      } else {
        NSLog("Failed to create Data from UIImage")
        return nil
      }
    }
    return nil
  }
}

extension UIImage {
  func alpha(_ value: CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }
}
