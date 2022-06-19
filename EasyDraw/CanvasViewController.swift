//
//  CanvasViewController.swift
//  EasyDraw
//
//  Created by 朱彦谕 on 2022/6/5.
//

import Foundation
import UIKit
import FluentUI
import SnapKit

class CanvasViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCanvasView()
        setupTabBarView()
        navigationItem.usesLargeTitle = false
        navigationItem.navigationBarStyle = .primary
        
        
    }
    private let tabBarView: TabBarView = {
        let tabBar = TabBarView(showsItemTitles: false)

        return tabBar
    }()
    private let canvasView: CanvasView = {
        let canvas = CanvasView(frame: .zero)
        return canvas
    }()
    
    
    private func setupCanvasView() {
        view.addSubview(canvasView)
        canvasView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view)
        }
    }
    
    private func setupTabBarView() {
        tabBarView.items = [
            TabBarItem(title: "select", image: UIImage(named: "arrow")!, selectedImage: UIImage(named: "arrow_selected")!, landscapeImage: UIImage(named: "arrow")!, landscapeSelectedImage: UIImage(named: "arrow")!),
            TabBarItem(title: "circle", image: UIImage(named: "circle")!, selectedImage: UIImage(named: "circle_selected")!, landscapeImage: UIImage(named: "circle")!, landscapeSelectedImage: UIImage(named: "circle")!),
            TabBarItem(title: "rect", image: UIImage(named: "rect")!, selectedImage: UIImage(named: "rect_selected")!, landscapeImage: UIImage(named: "rect")!, landscapeSelectedImage: UIImage(named: "rect")!),
            TabBarItem(title: "line", image: UIImage(named: "line")!, selectedImage: UIImage(named: "line_selected")!, landscapeImage: UIImage(named: "line")!, landscapeSelectedImage: UIImage(named: "line")!),
        ]
        view.addSubview(tabBarView)
        tabBarView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view)
        }
        tabBarView.delegate = self
    }
    
}

extension CanvasViewController: TabBarViewDelegate {
    func tabBarView(_ tabBarView: TabBarView, didSelect item: TabBarItem) {
        if item.title == "select" {
            canvasView.currentSelectedShapeType = .select
        } else if item.title == "circle" {
            canvasView.currentSelectedShapeType = .circle
        } else if item.title == "rect" {
            canvasView.currentSelectedShapeType = .rectangle
        } else if item.title == "line" {
            canvasView.currentSelectedShapeType = .line
        }
    
    }
}
