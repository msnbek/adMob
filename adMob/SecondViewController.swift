//
//  SecondViewController.swift
//  adMob
//
//  Created by Mahmut Senbek on 11.10.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(label)
        label.text = "If you don't wanna see ads, buy premium"
        label.textAlignment = .center
        label.textColor = .purple
        label.layer.cornerRadius = 10
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        label.layer.shadowOpacity = 0.9
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
