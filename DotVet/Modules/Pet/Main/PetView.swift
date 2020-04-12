//
//  PetView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

class PetView: UIView {
    
    let btnAdd: UIButton = {
        let btn = UIButton(type: .contactAdd).withAutoLayout()
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        setView()
        setConstraints()
    }

    
    private func setView() {
        self.addSubview(btnAdd)
        
        //let keypayh: KeyPath<UIButton, Bool> = btnAdd[keyPath: \UIButton.isSelected]
       // self.addObserver(btnAdd, forKeyPath: #keyPath(UIButton.isSelected), options: [], context: nil)
       
    }
    
    private func setConstraints() {
      guard let sv = self.superview else { return }
        anchor(top: sv.safeTopAnchor,
               leading: sv.leadingAnchor,
               bottom: sv.safeBottomAnchor,
               trailing: sv.trailingAnchor)
        
        btnAdd.anchor(bottom: safeBottomAnchor,
                      centerX: centerXAnchor,
                      padding: .init(top: 0, left: 0, bottom: 40, right: 0))
    }

}
