//
//  Shape.swift
//  EasyDraw
//
//  Created by 朱彦谕 on 2022/6/6.
//

import Foundation
import UIKit

enum BorderStyle {
    case solid, dotted
}

enum ShapeType {
    case select, circle, rectangle, line
}

protocol Shape: NSSecureCoding {
    var frame: CGRect { get }
    var startPoint: CGPoint { get set }
    var endPoint: CGPoint { get set }
    var transform: CGAffineTransform { get set }
    var fillColor: UIColor { get set }
    var stroke: Stroke { get set }
    var selected: Bool { get set }
}

extension Shape {
    var frame: CGRect {
        
        let rect = CGRect(x: startPoint.x, y: startPoint.y, width: (endPoint.x - startPoint.x), height: (endPoint.y - startPoint.y))
        print("fram: (\(rect.origin.x), \(rect.origin.y), \(rect.size.width), \(rect.size.height)")
        return rect
    }
}

class Stroke {
    
    var borderColor: UIColor = .black
    
    var borderSize: CGFloat = 1
    
    var borderStyle: BorderStyle = .solid
    
}


class Circle: Shape {
    
    var selected: Bool = false
    
    var startPoint: CGPoint = .zero
    
    var endPoint: CGPoint = .zero
    
    var stroke: Stroke = Stroke()
    
    var transform: CGAffineTransform = .identity
    
    var fillColor: UIColor = .clear
    
    
    static var supportsSecureCoding: Bool = true
    
    func encode(with coder: NSCoder) {
        
    }
    
    init() {}
    
    required init?(coder: NSCoder) {
        
    }
    
}

class Rectangle: Shape {
    
    var selected: Bool = false
    
    var startPoint: CGPoint = .zero
    
    var endPoint: CGPoint = .zero
    
    var stroke: Stroke = Stroke()
    
    var transform: CGAffineTransform = .identity
    
    var fillColor: UIColor = .clear
    
    static var supportsSecureCoding: Bool = true
    
    init() {}
    
    func encode(with coder: NSCoder) {
        
    }
    
    required init?(coder: NSCoder) {
        
    }
    
}

class Line: Shape {
    
    var selected: Bool = false
    
    var startPoint: CGPoint = .zero
    
    var endPoint: CGPoint = .zero
    
    var stroke: Stroke = Stroke()
    
    var transform: CGAffineTransform = .identity
    
    var fillColor: UIColor = .clear
    
    static var supportsSecureCoding: Bool = true
    
    init() {}
    
    func encode(with coder: NSCoder) {
        
    }
    
    required init?(coder: NSCoder) {
        
    }
    
}
