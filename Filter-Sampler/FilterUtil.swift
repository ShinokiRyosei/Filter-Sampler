//
//  FilterUtil.swift
//  Filter-Sampler
//
//  Created by ShinokiRyosei on 2016/08/24.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class FilterUtil: NSObject {
    
    func switchFilters(originaal img: UIImage, index: Int) -> UIImage {
        switch index {
        case 0:
            return self.sepiaFilter(original: img)
        case 1:
            return self.monoChromeFilter(original: img)
        case 2:
            return self.adjustmentFilter(original: img)
        case 3:
            return self.toneCurveFilter(original: img)
        default:
            return img
        }
    }
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
    // 色調節フィルタ
    func adjustmentFilter(original img: UIImage) -> UIImage {
        guard let filter: CIFilter = CIFilter(name: "CIColorControl") else { return img }
        guard let ciImage: CIImage = CIImage(image: img) else { return img }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(1.0, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(3.0, forKey: "inputContrast")
        return self.outputImage(filter, original: img)
    }
    // トーンカーブ
    func toneCurveFilter(original img: UIImage) -> UIImage {
        guard let filter: CIFilter = CIFilter(name: "CIToneCurve") else { return img }
        guard let ciImage: CIImage = CIImage(image: img) else { return img }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(CIVector(x: 0.0, y: 0.0), forKey: "inputPoint0")
        filter.setValue(CIVector(x: 0.25, y: 0.1), forKey: "inputPoint1")
        filter.setValue(CIVector(x: 0.5, y: 0.5), forKey: "inputPoint2")
        filter.setValue(CIVector(x: 0.75, y: 0.9), forKey: "inputPoint3")
        filter.setValue(CIVector(x: 1.0, y: 1.0), forKey: "inputPoint4")
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
