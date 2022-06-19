//
//  Coordinator.swift
//  iOSCoordinator
//
//  Created by 朱彦谕 on 2021/7/30.
//

import Foundation
import UIKit
enum Event {
    case createButtonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccurred(with event: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
