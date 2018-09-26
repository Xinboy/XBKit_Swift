//
//  CircleRectBaseCell.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/7/3.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

class CircleRectBaseCell: UITableViewCell {

    private let kBaseCellIdentifier = "CircleRectBaseCell"
    
    enum CellBorderStyle: NSInteger {
        case noRound = 0
        case topRound
        case bottomRound
        case allRound
    }
    
    /** 边框类型*/
    var borderStyle: CellBorderStyle = CellBorderStyle.noRound
    var contentBorderColor: UIColor = UIColor.clear
    var contentBackgroundColor: UIColor = UIColor.clear
    var contentBorderWidth: CGFloat = 1.0
    var contentMargin: CGFloat = 0.0
    var contentCornerRadius: CGSize = CGSize.init(width: 5, height: 5)

    public func cellWith(tableView: UITableView, indexPath: NSIndexPath) -> CircleRectBaseCell {
        var cell: CircleRectBaseCell = tableView.dequeueReusableCell(withIdentifier: kBaseCellIdentifier) as! CircleRectBaseCell
        if cell.isKind(of: CircleRectBaseCell.self) {
            cell = CircleRectBaseCell.init(style: .default, reuseIdentifier: kBaseCellIdentifier)
        }
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.borderStyle = CellBorderStyle.allRound
        } else if indexPath.row == 0 {
            cell.borderStyle = CellBorderStyle.topRound
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.borderStyle = CellBorderStyle.bottomRound
        } else {
            cell.borderStyle = CellBorderStyle.noRound
        }
        return cell
    }
    
    public func setBorderStyleWith(tableView: UITableView, indexPath: NSIndexPath) {
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            self.borderStyle = CellBorderStyle.allRound
        } else if indexPath.row == 0 {
            self.borderStyle = CellBorderStyle.topRound
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            self.borderStyle = CellBorderStyle.bottomRound
        } else {
            self.borderStyle = CellBorderStyle.noRound
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupBorder()
    }
    
    func setupBorder() {
        let ContentViewWidth = self.contentView.frame.size.width
        let ContentViewHeight = self.contentView.frame.size.height
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        let layer = CAShapeLayer.init()
        layer.lineWidth = self.contentBorderWidth
        layer.strokeColor = self.contentBorderColor.cgColor
        layer.fillColor = self.contentBackgroundColor.cgColor
        
        let view = UIView.init(frame: self.contentView.bounds)
        view.layer.insertSublayer(layer, at: 0)
        view.backgroundColor = UIColor.clear

        let bottomLine = UIView.init(frame: CGRect.init(x: 12, y: ContentViewHeight - 0.5, width: ContentViewWidth, height: 0.5))
        bottomLine.backgroundColor = UIColor.init(white: 234 / 255.0, alpha: 1.0)
        if self.borderStyle != CellBorderStyle.bottomRound {
            view.addSubview(bottomLine)
        }
        self.backgroundView = view
        
        let rect = CGRect.init(x: self.contentMargin, y: 0, width: ContentViewWidth, height: ContentViewHeight)
        switch self.borderStyle {
        case .noRound:
            let path = UIBezierPath.init(rect: rect)
            layer.path = path.cgPath
        case .topRound:
            let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: self.contentCornerRadius)
            layer.path = path.cgPath
        case .bottomRound:
            let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: self.contentCornerRadius)
            layer.path = path.cgPath
        case .allRound:
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: self.contentCornerRadius)
        layer.path = path.cgPath
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
