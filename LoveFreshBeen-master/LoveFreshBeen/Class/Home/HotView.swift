//
//  HotView.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

class HotView: UIView {

    private let iconW = (ScreenWidth - 2 * HotViewMargin) * 0.25
    private let iconH: CGFloat = 80
    
    var iconClick:((_ index: Int) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //swift3.0中的逃逸闭包,如果闭包被作为参数传递到函数时，该闭包不需要立即执行而是需要等某些线程完成任务之后再执行，那么需要在该闭包前加上@escaping，否则编译器报错。如下代码所示：
    convenience init(frame: CGRect, iconClick:@escaping ((_ index: Int) -> Void)) {
        self.init(frame:frame)
        self.iconClick = iconClick
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: 模型的Set方法
    var headData: HeadData? {
        didSet {
            if(headData == nil){
                return
            }
            if (headData?.icons?.count)! > 0 {
                
                if headData!.icons!.count % 4 != 0 {
                    self.rows = headData!.icons!.count / 4 + 1
                } else {
                    self.rows = headData!.icons!.count / 4
                }
                var iconX: CGFloat = 0
                var iconY: CGFloat = 0

                for i in 0..<headData!.icons!.count {
                    iconX = CGFloat(i % 4) * iconW + HotViewMargin
                    iconY = iconH * CGFloat(i / 4)
                    let icon = IconImageTextView(frame: CGRect(x:iconX, y:iconY, width:iconW,height:iconH), placeholderImage: UIImage(named: "icon_icons_holder")!)
                    
                    icon.tag = i
                    icon.activitie = headData!.icons![i]
                   //  #selector(PageScrollView.imageViewClick(_:)
                    let tap = UITapGestureRecognizer(target: self, action:#selector(HotView.iconClick(_:)))
                    icon.addGestureRecognizer(tap)
                    addSubview(icon)
                }
            }
        }
    }
// MARK: rows数量
    private var rows: Int = 0 {
        willSet {
            bounds = CGRect(x:0,y:0,width:ScreenWidth,height:iconH * CGFloat(newValue));

        }
    }

// MARK:- Action
    func iconClick(_ tap: UITapGestureRecognizer) {
        if iconClick != nil {
            iconClick!(tap.view!.tag)
        }
    }
}

