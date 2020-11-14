//
//  MyProgressView.swift
//  TimeMannager
//
//  Created by Sergey Borovkov on 22.10.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import Foundation
import UIKit

class MyProgressView : UICollectionViewCell
{
    // initializers:
    init(_height : CGFloat, _labelText : String, _maxValue : Int ) {
        self.pvHeight_=_height
        self.maxValue_ = _maxValue
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height:0))
        self.addSubview(pv_)
        self.addSubview(title_)
        self.addSubview(percentLabel_)
        self.addSubview(maxValueLabel_)
        titleName_ = _labelText
        title_.text = titleName_
        commonInit()
    }
    
    override init(frame: CGRect) {
        self.pvHeight_=40
        super.init(frame: frame)
        self.addSubview(pv_)
        pv_.trackTintColor = self.traitCollection.userInterfaceStyle == .dark ? MYColorsDarkMode.whiteGray : MYColors.whiteGray
        pv_.tintColor = self.traitCollection.userInterfaceStyle == .dark ? MYColorsDarkMode.darkGray : MYColors.darkGray
        self.addSubview(title_)
        title_.textColor = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
        self.addSubview(percentLabel_)
        title_.textColor = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
        self.addSubview(maxValueLabel_)
        title_.textColor = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // private variables and constants:
    private lazy var pv_ : UIProgressView = {
        let pv = UIProgressView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    private lazy var title_ : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var percentLabel_ : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(percentage_) + "%"
        return label
    }()
    
    private lazy var maxValueLabel_ : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = GetMaxValueLabelText()
        return label
    }()
    
    private let pvHeight_ : CGFloat
    
    private var percentage_ : Int = 0
    
    private var titleName_ : String = "Name"
    private var maxValue_ : Int = 0 // max value in minutes
    private var reachedValue_ : Int = 0 // reached value in minutes
    
    // public variables and constants:
    var percentage : Int {
        get{
            return percentage_
        }
        set{
            percentage_=newValue
            pv_.setProgress(Float(percentage_)/100, animated: true)
            percentLabel_.text=String(percentage_) + "%"
        }
    }
    
    var reachedValue : Int {
        get{
            return reachedValue_
        }
        set{
            reachedValue_=newValue
            recalculatePercentage()
        }
    }
    
    func GetMaxValueLabelText() -> String
    {
        let postfix = maxValue_ == 60 ? " hour" : " hours"
        return String(Float(maxValue_)/60) + postfix
    }
    
    var maxValue : Int {
        get{
            return maxValue_
        }
        set{
            maxValue_ = newValue
            maxValueLabel_.text = GetMaxValueLabelText()
            recalculatePercentage()
        }
    }
    
    var titleName : String {
        get{
            return titleName_
        }
        set{
            titleName_ = newValue
            title_.text = titleName_
        }
    }
    
    // private functions:
    private func recalculatePercentage() -> Void {
        percentage=Int(Float(reachedValue_) / Float(maxValue_)*100)
    }
    
    private func commonInit() -> Void {
        contentView.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .systemFill : .systemGray6
        NSLayoutConstraint.activate([
            pv_.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            pv_.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            pv_.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pv_.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title_.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            title_.centerYAnchor.constraint(equalTo: pv_.safeAreaLayoutGuide.centerYAnchor),
            percentLabel_.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            percentLabel_.centerYAnchor.constraint(equalTo: pv_.safeAreaLayoutGuide.centerYAnchor),
            maxValueLabel_.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            maxValueLabel_.centerYAnchor.constraint(equalTo: pv_.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
}
