//
//  InfiniteScrollView.swift
//  InfiniteScrollSample
//
//  Created by 蜂谷庸正 on 2018/05/10.
//  Copyright © 2018年 Tsunemasa Hachiya. All rights reserved.
//

import UIKit

class InfiniteScrollView: UIScrollView {

    let cellWidth: CGFloat = 150.0
    let groupWidth: CGFloat = 150.0 * 3
    
    var arrayLabelTitle: [UILabel] = [UILabel]()
    
    var containerView: UIView!
    
    var firstCall: Bool = true
    var page: Int = 0
    var myContentOffset: CGPoint = CGPoint.zero
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentSize = CGSize(width: groupWidth * 5, height: 130)
        self.containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height))
        self.containerView.backgroundColor = UIColor.lightGray
        self.addSubview(self.containerView)
        
        for i in 0..<15 {
            let labelTitle = UILabel(frame: CGRect(x: CGFloat(i) * cellWidth, y: 60, width: cellWidth, height: 25))
            self.containerView.addSubview(labelTitle)
            labelTitle.backgroundColor = UIColor.white
            let titleStr = String(format: "%d", (i - 7))
            labelTitle.text = titleStr
            
            arrayLabelTitle.append(labelTitle)
        }
        
        self.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.recenterIfNecessary()
    }
    
    // MARK: - Layout
    func recenterIfNecessary() {
        let currentOffset: CGPoint = self.contentOffset
        let centerOffsetX: CGFloat = 2 * groupWidth
        
        let directionScroll: CGFloat = currentOffset.x - centerOffsetX
        let distanceFromCenter: CGFloat = fabs(directionScroll)
        
        if distanceFromCenter > groupWidth {
            self.contentOffset = CGPoint(x: centerOffsetX, y: currentOffset.y)
            if directionScroll > 0 {
                self.page += 1
            } else {
                self.page -= 1
            }
            
            if firstCall {
                firstCall = false
                self.page = 0
                self.myContentOffset = CGPoint.zero
            }
            
            updateLabelTitle()
        }
        
        self.myContentOffset = CGPoint(x: groupWidth * CGFloat(self.page) + directionScroll, y: currentOffset.y)
        
        print("\(self.page) : \(self.myContentOffset.x)")
    }
    
    func updateLabelTitle() {
        for i in 0..<arrayLabelTitle.count {
            let index = i + (page * 3)
            let titleStr = String(format: "%d", (index - 7))
            let labelTitle = arrayLabelTitle[i]
            labelTitle.text = titleStr
        }
    }
}
