//
//  AddTaskViewController.swift
//  TimeManager
//
//  Created by Sergey Borovkov on 06.11.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import Foundation
import UIKit

protocol AddTaskViewControllerDelegate: class {
    func CreateNewTask()
}

class AddTaskViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(MainLabel)
        view.addSubview(CancelButton)
        CancelButton.addTarget(self, action: #selector(ButtonCloseTapped(_:)), for: .touchUpInside)
        view.addSubview(CreateButton)
        CreateButton.addTarget(self, action: #selector(ButtonCreateTapped(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
        MainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        CancelButton.topAnchor.constraint(equalTo: MainLabel.bottomAnchor),
        CancelButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        CancelButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        CreateButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        CreateButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        CreateButton.topAnchor.constraint(equalTo: MainLabel.bottomAnchor),
        ])
    }
    
    weak var delegate: AddTaskViewControllerDelegate!
    
    private var tasksStorage: TMTaskStorage = TMTaskStorage()
    
    private lazy var MainLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text="Hello world" // todo fix me
        v.textColor=UIColor.black
        return v
    }()
    
    private lazy var CancelButton : UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("Cancel", for: .normal)
        v.backgroundColor=UIColor.gray
        v.setTitleColor(UIColor.white, for: .normal)
        return v
    }()

    private lazy var CreateButton : UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("Create", for: .normal)
        v.backgroundColor=UIColor.gray
        v.setTitleColor(UIColor.white, for: .normal)
        return v
    }()
    
    @objc private func ButtonCloseTapped(_ sender: Any) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func ButtonCreateTapped(_ sender: Any) -> Void {
        tasksStorage.CreateNewTask(name: "Test", minutes: 100, period: .daily, true)
        delegate.CreateNewTask()
    }
    
    func SetTaskStorage( _ input : TMTaskStorage ) -> Void
    {
        self.tasksStorage = input
    }
}
