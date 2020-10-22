//
//  ViewController.swift
//  TimeMannager
//
//  Created by Sergey Borovkov on 22.10.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

//class UIProgressBar: UIVi
class ViewController: UIViewController {
    
    private lazy var textField : MyProgressView = {
        let pv = MyProgressView(_height: 40, _labelText: "hello world", _maxValue: 60)
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.backgroundColor = UIColor.gray
        //           pv.barHeight=height;
        //           pv.progress = 0.0
        pv.reachedValue=30
        return pv
    }()
    
    private func addSubviews(){
        view.addSubview(textField)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0.0),
            textField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0.0),
        ])
        // Do any additional setup after loading the view.
    }
}

