//
//  MainCoordinator.swift
//  iOSCoordinator
//
//  Created by 朱彦谕 on 2021/7/30.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func eventOccurred(with event: Event) {
        switch event {
        case .createButtonTapped:
            var canvasVC: UIViewController & Coordinating = CanvasViewController()
            canvasVC.coordinator = self
            navigationController?.pushViewController(canvasVC, animated: true)
        }
        
    }
    
    func start() {
        var vc: UIViewController & Coordinating = ViewController()
        //if let coordinatingVC = ViewController
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    
}
