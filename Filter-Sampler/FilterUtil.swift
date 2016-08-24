//
//  FilterUtil.swift
//  Filter-Sampler
//
//  Created by ShinokiRyosei on 2016/08/24.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class FilterUtil: NSObject {
    // セピア
    func sepiaFilter(original img: UIImage) -> UIImage {
        guard let filter: CIFilter = CIFilter(name: "CISepiaTone") else { return img }
        guard let ciImage: CIImage = CIImage(image: img) else { return img }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: "inputIntensity")
        return self.outputImage(filter, original: img)
    }
    
    // モノクロ
    func monoChromeFilter(original img: UIImage) -> UIImage {
        guard let filter: CIFilter = CIFilter(name: "CIColorMonochrome") else { return img }
        guard let ciImage: CIImage = CIImage(image: img) else { return img }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(CIColor(red: 0.75, green: 0.75, blue: 0.75), forKey: "inputColor")
        filter.setValue(1.0, forKey: "inputIntensity")
        return self.outputImage(filter, original: img)
    }
    
    
    
    func outputImage(filter: CIFilter, original img: UIImage) -> UIImage {
        let context: CIContext = CIContext(options: nil)
        guard let output = filter.outputImage else { return img }
        guard let extent = filter.outputImage?.extent else { return img }
        let cgImageRef: CGImageRef = context.createCGImage(output, fromRect: extent)
        
        return UIImage(CGImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.Up)
    }
}
