//
//  UIImage+Extention.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/7/3.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    enum CircleHeading: NSInteger {
        case left = 0
        case right
        case top
        case bottom
    }
    
    static func xb_resizableImage(name: String, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> UIImage {
        var image = UIImage.init(named: name)
        let insets = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
        image = image?.resizableImage(withCapInsets: insets, resizingMode: UIImageResizingMode.stretch)
        return image!
    }
    
    static func xb_imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    static func xb_imageWithView(size: CGSize, bgColor: UIColor) -> UIImage {
        let view = UIView.init()
        view.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        view.backgroundColor = bgColor
        
        UIGraphicsBeginImageContext(view.bounds.size)
        let context = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        
        var image = UIGraphicsGetImageFromCurrentImageContext()
        image = image?.xb_imageWithCornerRadius(radius: size.height * 0.5)
        UIGraphicsEndImageContext()
        return image!
    }
    
    func xb_imageWithCornerRadius(radius: CGFloat)  -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
    
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(UIBezierPath.init(roundedRect: rect, cornerRadius: radius).cgPath)
        context?.clip()
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func cutCircle(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        let rect = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        context?.addEllipse(in: rect)
        context?.clip()
        image.draw(in: rect)
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func resized(imageName: String, scale:CGFloat) -> UIImage {
        let image = UIImage.init(named: imageName)!
        return image.stretchableImage(withLeftCapWidth: Int(image.size.width * scale), topCapHeight: Int(image.size.height * scale))
    }
    
    /** 缩放图片*/
    static func scaledImage(imageDate: NSData, size:CGSize, scale:CGFloat, orientation:UIImageOrientation) -> UIImage {
        let maxPixedSize = max(size.width, size.height)
        let sourceRef = CGImageSourceCreateWithData(CFBridgingRetain(imageDate) as! CFData, nil)
        let options = [kCGImageSourceCreateThumbnailFromImageAlways: kCFBooleanTrue,
                       kCGImageSourceThumbnailMaxPixelSize: maxPixedSize] as [CFString : Any]
        
        let imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef!, 0, options as CFDictionary)
        let resultImage = UIImage.init(cgImage: imageRef!, scale: scale, orientation: orientation)
        
        return resultImage
        
    }

    // MARK: - 二维码生成
    static func qrImage(qrString: String, imageSide: CGFloat) -> UIImage {
        let filter: CIFilter = CIFilter.init(name: "CIQRCodeGenerator")!
        filter.setDefaults()
        filter.setValue(qrString.data(using: .utf8), forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        let outputCIImage: CIImage = filter.outputImage!
        
        let extent: CGRect = outputCIImage.extent.integral
        let scale = min(imageSide / extent.size.width, imageSide / extent.size.height)
        
        let width = extent.size.width * scale
        let height = extent.size.height * scale
        
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        //width：图片宽度像素
        //height：图片高度像素
        //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
        //bitmapInfo：指定的位图应该包含一个alpha通道。
        let bitmapRef: CGContext = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue)!
        let bitmapImage: CGImage =  CIContext.init(options: nil).createCGImage(outputCIImage, from: extent)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale)
        bitmapRef.draw(bitmapImage, in: extent)
        
        return UIImage.init(cgImage: bitmapRef.makeImage()!)
    }
    
    static func qrImageWithLogo(qrImage: UIImage, logoImage: UIImage, logoSide: CGFloat) -> UIImage? {
        if qrImage.isEqual(nil) || logoImage.isEqual(nil) {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(qrImage.size, false, UIScreen.main.scale)
        qrImage.draw(in: CGRect.init(x: 0, y: 0, width: qrImage.size.width, height: qrImage.size.height))
        logoImage.draw(in: CGRect.init(x: (qrImage.size.width - logoSide) / 2, y: (qrImage.size.height - logoSide) / 2, width: logoSide, height: logoSide))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func imageFor(heading: CircleHeading, rect:CGRect, fillColor: UIColor) -> UIImage{
        var radius: CGFloat = 0.0
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        switch heading {
        case .top:
            radius = rect.size.width * 0.5
            context.move(to: CGPoint.init(x: 0, y: rect.size.height))
            context.addLine(to: CGPoint.init(x: 0, y: radius))
            context.addArc(center: CGPoint.init(x: radius, y: radius), radius: radius, startAngle: -.pi / 2, endAngle: -(.pi + .pi / 2), clockwise: true)
            context.addLine(to: CGPoint.init(x: rect.size.width, y: rect.size.height))
            break
        case .bottom:
            radius = rect.size.width * 0.5
            context.move(to: CGPoint.init(x: 0, y: 0))
            context.addLine(to: CGPoint.init(x: 0, y: rect.size.height - radius))
            context.addArc(center: CGPoint.init(x: radius, y: rect.size.height - radius), radius: radius, startAngle: -.pi / 2, endAngle: -(.pi + .pi / 2), clockwise: true)
            context.addLine(to: CGPoint.init(x: rect.size.width, y: 0))
            break
        case .left:
            radius = rect.size.height * 0.5
            context.move(to: CGPoint.init(x: rect.size.width, y: 0))
            context.addLine(to: CGPoint.init(x: radius, y: 0))
            context.addArc(center: CGPoint.init(x: radius, y: radius), radius: radius, startAngle: -.pi / 2, endAngle: -(.pi + .pi / 2), clockwise: true)
            context.addLine(to: CGPoint.init(x: rect.size.width, y: rect.size.height))
            break
        case .right:
            radius = rect.size.height * 0.5
            context.move(to: CGPoint.init(x: 0, y: 0))
            context.addLine(to: CGPoint.init(x: rect.size.width - radius, y: 0))
            context.addArc(center: CGPoint.init(x: rect.size.width - radius, y: radius), radius: radius, startAngle: -.pi / 2, endAngle: -(.pi + .pi / 2), clockwise: true)
            context.addLine(to: CGPoint.init(x: 0, y: rect.size.height))
            break
        }
        context.closePath()
        context.setFillColor(fillColor.cgColor)
        context.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}





