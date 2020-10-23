//
//  MyProgressView.swift
//  TimeMannager
//
//  Created by Sergey Borovkov on 22.10.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import Foundation
import UIKit

extension UIProgressView {
    
    @IBInspectable var barHeight : CGFloat {
        get {
            return transform.d * 2.0
        }
        set {
            // 2.0 Refers to the default height of 2
            let heightScale = newValue / 2.0
            let c = center
            transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
            center = c
        }
    }
    @IBInspectable var topAnchorConst : CGFloat {
        get {
            return transform.d
        }
    }
}

class MyProgressView : UIView
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
        title_.text = _labelText
        SetPositions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // private variables and constants:
    private lazy var pv_ : UIProgressView = {
        let pv = UIProgressView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.backgroundColor = UIColor.gray
        pv.barHeight=self.pvHeight_
        return pv
    }()
    
    private lazy var title_ : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var percentLabel_ : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.text = String(percentage_) + "%"
        return label
    }()
    
    private lazy var maxValueLabel_ : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        var postfix = maxValue_ == 60 ? " hour" : " hours"
        label.text = String(Float(maxValue_)/60) + postfix
        return label
    }()
    
    private let pvHeight_ : CGFloat
    
    private var percentage_ : Int = 0
    
    private var maxValue_ : Int = 0 // max value in minutes
    private var reachedValue_ : Int = 0 // reached value in minutes
    
    // public variables and constants:
    var percentage : Int {
        get{
            return percentage_
        }
        set {
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
            percentage=Int(Float(reachedValue_) / Float(maxValue_)*100)
        }
    }
    
    // private functions:
    private func SetPositions()
    {
        NSLayoutConstraint.activate([
            pv_.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant:  pv_.topAnchorConst),
            pv_.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0.0),
            pv_.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0.0),
            pv_.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -pv_.topAnchorConst),
            title_.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0.0),
            title_.centerYAnchor.constraint(equalTo: pv_.safeAreaLayoutGuide.centerYAnchor, constant: 0.0),
            percentLabel_.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 0.0),
            percentLabel_.centerYAnchor.constraint(equalTo: pv_.safeAreaLayoutGuide.centerYAnchor, constant: 0.0),
            maxValueLabel_.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0.0),
            maxValueLabel_.centerYAnchor.constraint(equalTo: pv_.safeAreaLayoutGuide.centerYAnchor, constant: 0.0),
        ])
    }
}
