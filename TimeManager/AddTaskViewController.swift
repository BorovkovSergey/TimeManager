//
//  AddTaskViewController.swift
//  TimeManager
//
//  Created by Sergey Borovkov on 06.11.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import Foundation
import UIKit

class AddTaskViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(MainLabel)
        view.addSubview(CloseButton)
        CloseButton.addTarget(self, action: #selector(ButtonCloseTapped(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
        MainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        CloseButton.topAnchor.constraint(equalTo: MainLabel.bottomAnchor),
        CloseButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        CloseButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    private lazy var MainLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text="Hello world" // todo fix me
        v.textColor=UIColor.black
        return v
    }()
    
    private lazy var CloseButton : UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("Close", for: .normal)
        v.backgroundColor=UIColor.gray
        v.setTitleColor(UIColor.white, for: .normal)
        return v
    }()

    @objc func ButtonCloseTapped(_ sender: Any) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}
