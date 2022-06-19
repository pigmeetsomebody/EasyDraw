//
//  ViewController.swift
//  EasyDraw
//
//  Created by 朱彦谕 on 2022/6/5.
//

import UIKit

class ViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Home"
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("Create Your First Sketch.", for: .normal)
        button.centerY = view.centerY
        button.centerX = view.centerX
        button.addTarget(self, action: #selector(didTapCreatorButton), for: .touchUpInside)
    }
    
    @objc private func didTapCreatorButton() {
        coordinator?.eventOccurred(with: .createButtonTapped)
    }


}

