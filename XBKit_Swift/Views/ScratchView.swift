//
//  ScratchView.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/9/13.
//  Copyright © 2018年 Xinbo. All rights reserved.
//
// @class ScratchView
// @abstract 刮刮乐
// @discussion
//

import UIKit

class ScratchView: UIView {

    //MARK: Property
    private var maskLayer: CAShapeLayer!
    private var maskPath: UIBezierPath!
    var showPercent: Float = 0.7
    var strokeLineCap: String = kCALineCapRound {
        didSet {
            maskLayer.lineCap = strokeLineCap
        }
    }
    var strokeLineWidth: CGFloat = 20 {
        didSet {
            maskLayer.lineWidth = strokeLineWidth
        }
    }
    //MARK: Target Methods
    
    
    //MARK: Public Methods
    
    
    //MARK: Private Methods
    @objc func processPanGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            let point = gesture.location(in: scratchContentView)
            maskPath.move(to: point)
            break
        case .changed:
            let point = gesture.location(in: scratchContentView)
            maskPath.addLine(to: point)
            maskPath.move(to: point)
            maskLayer.path = maskPath.cgPath
//
            let image = getImageFromContentView()
            var percent = 1 - getAlphaPixelPercent(img: image)
            percent = max(0, min(1, percent))
            
            if percent >= showPercent {
                showContentView()
            }
            
            break
        default:
            break
        }
    }
    
    private func showContentView() {
        scratchContentView.layer.mask = nil
    }
    
    private func resetState() {
        maskPath.removeAllPoints()
        maskLayer.path = nil
        scratchContentView.layer.mask = maskLayer
    }
    
    private func getImageFromContentView() -> UIImage{
        let size = scratchContentView.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        scratchContentView.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    private func getAlphaPixelPercent(img: UIImage) -> Float {
        
        //计算像素总个数
        let width = Int(img.size.width)
        let height = Int(img.size.height)
        let bitmapByteCount = width * height
        
        //得到所有像素数据
        let pixelData = UnsafeMutablePointer<UInt8>.allocate(capacity: bitmapByteCount)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let context = CGContext.init(data: pixelData,
                                     width: width,
                                     height: height,
                                     bitsPerComponent: 8,
                                     bytesPerRow: width,
                                     space: colorSpace,
                                     bitmapInfo: CGBitmapInfo.init(rawValue: CGImageAlphaInfo.alphaOnly.rawValue).rawValue)!
        
        let rect = CGRect.init(x: 0, y: 0, width: width, height: height)
        context.clear(rect)
        context.draw(img.cgImage!, in: rect)
        
        //计算透明像素个数
        var alphaPixelCount = 0
        for x in 0...Int(width) {
            for y in 0...Int(height) {
                if pixelData[y * width + x] == 0 {
                    alphaPixelCount += 1
                }
            }
        }
        
        free(pixelData)
        return Float(alphaPixelCount) / Float(bitmapByteCount)
        

    }
    
    //MARK: - Initial Methods And setupUI
    public init(contentView: UIView, maskView: UIView, percent: Float) {
        super.init(frame: .zero)
        showPercent = percent
        inits()
        
        scratchMaskView = maskView
        scratchContentView = contentView
    }
    
    public init(content: String, maskColor: UIColor, percent: Float) {
        super.init(frame: .zero)
        showPercent = percent
        inits()
        
        let label: UILabel = scratchContentView.viewWithTag(1000) as! UILabel
        label.text = content
        scratchMaskView.backgroundColor = maskColor
    }
    
    private func inits() {

        
        addSubview(scratchMaskView)
        addSubview(scratchContentView)
        
        maskLayer = CAShapeLayer.init()
        maskLayer.strokeColor = UIColor.red.cgColor
        maskLayer.lineWidth = strokeLineWidth
        maskLayer.lineCap = strokeLineCap
        
        scratchContentView.layer.mask = maskLayer
        
        maskPath = UIBezierPath.init()
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(processPanGesture(gesture:)))
        addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scratchMaskView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self)
        }
        
        scratchContentView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    
    //MARK: Subviews Lazy
    private lazy var scratchContentView: UIView = {
        let temp = UIView.init()
        let contentLabel = UILabel.init()
        contentLabel.tag = 1000
        contentLabel.backgroundColor = .white
        contentLabel.font = UIFont.systemFont(ofSize: 25)
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 0
        temp.addSubview(contentLabel)
        return temp
    }()
    
    private lazy var scratchMaskView: UIView = {
        let temp = UIView.init()
        temp.backgroundColor = UIColor.lightGray
        return temp
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
