//
//  MyCollectionViewCell.swift
//  TimeMannager
//
//  Created by Sergey Borovkov on 27.10.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import Foundation
import UIKit

// simple cell with button
class UICollectionViewAddItemButton: UICollectionViewCell {

    let btn: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("Add task", for: .normal)
        v.setTitleColor( .black, for: .normal)
        v.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        return v
    }()

    // this will be used as a "callback closure" in collection view controller
    var tapCallback: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() -> Void {
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(btn)
        btn.setTitleColor( self.traitCollection.userInterfaceStyle == .dark ? .white : .black, for: .normal)
        // constrain button to all 4 sides
        NSLayoutConstraint.activate([
            btn.topAnchor.constraint(equalTo: contentView.topAnchor),
            btn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            btn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            btn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        btn.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
    }

    @objc func didTap(_ sender: Any) {
        // tell the collection view controller we got a button tap
        tapCallback?()
    }

}

