//
//  CanvasView.swift
//  EasyDraw
//
//  Created by 朱彦谕 on 2022/6/6.
//

import Foundation
import UIKit
import SwiftUI



class CanvasView: UIScrollView {
    
    var globalStroke = Stroke()
    
    var shapes: [Shape] = []
    
    var currentShape: Shape?
    
    var selectedStartPoint: CGPoint?
    
    var selectedEndPoint: CGPoint? {
        didSet {
            print("selectedFrame: (\(selectedFrame.origin.x), \(selectedFrame.origin.y), \(selectedFrame.size.width), \(selectedFrame.size.height)")
            for shape in shapes {
                if !shape.selected && selectedFrame.contains(shape.frame) {
                    print("append a shape to selectedShapes.")
                    shape.selected = true
                }
            }
        }
    }
    
    var selectedFrame: CGRect {
        guard let selectedStartPoint = selectedStartPoint else {
            return .zero
        }
        guard let selectedEndPoint = selectedEndPoint else {
            return .zero
        }
        return CGRect(x: selectedStartPoint.x, y: selectedStartPoint.y, width: (selectedEndPoint.x - selectedStartPoint.x), height: (selectedEndPoint.y - selectedStartPoint.y))
    }
    
    
    var currentSelectedShapeType: ShapeType = .select
    
    var displayLink: CADisplayLink?
    
    var phase: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupGestureRecognizer()
        setupDisplayLink()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestureRecognizer() {
        let gr = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapped(gr:)))
        gr.numberOfTapsRequired = 2
        gr.delaysTouchesBegan = true
        self.addGestureRecognizer(gr)
    }
    
    @objc private func didDoubleTapped(gr: UITapGestureRecognizer) {
        resetSelectedShapes()
        let location = gr.location(in: self)
        let selectedShape = shapes.reversed().first { $0.frame.contains(location) }
        if let selectedShape = selectedShape {
            displayLink?.isPaused = false
            selectedShape.selected = true
            setNeedsDisplay()
        }
    }
    
    @objc private func updatePhase() {
        phase -= 0.25
    }
    
    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(updatePhase))
        displayLink?.add(to: RunLoop.main, forMode: .default)
        displayLink?.isPaused = true
    }
    
    fileprivate func drawSelectedShapeFrames() {
        UIColor.systemBlue.set()
        for shape in shapes.filter({ $0.selected == true }) {
            let selectFrame = shape.frame.insetBy(dx: -8, dy: -8)
            let bp = UIBezierPath(roundedRect: selectFrame, cornerRadius: 0)
            bp.setLineDash([10.0, 5.0], count: 2, phase: phase)
            bp.lineWidth = 1
            bp.stroke()
        }
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        for shape in shapes {
            draw(shape: shape)
        }
        if let currentShape = currentShape {
            UIColor.red.set()
            draw(shape: currentShape)
        }
        if selectedFrame != .zero {
            print("selectedFrame: (\(selectedFrame.origin.x), \(selectedFrame.origin.y), \(selectedFrame.size.width), \(selectedFrame.size.height)")
            UIColor.systemBlue.withAlphaComponent(0.2).setFill()
            let bp = UIBezierPath(roundedRect: selectedFrame, cornerRadius: 0)
           
            bp.fill()
            
        }
        drawSelectedShapeFrames()
    }
    
    private func resetSelectedShapes() {
        displayLink?.isPaused = true
        for shape in shapes {
            shape.selected = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let t = touches.first else { return }
        let location = t.location(in: self)
        resetSelectedShapes()
        selectedStartPoint = nil
        selectedEndPoint = nil
        switch currentSelectedShapeType {
        case .select:
            print("select logic")
            selectedStartPoint = location
            displayLink?.isPaused = false
        case .circle:
            currentShape = Circle()
        case .rectangle:
            currentShape = Rectangle()
        case .line:
            currentShape = Line()
        }
        
        guard let currentShape = currentShape else {
            return
        }
        currentShape.startPoint = location
        currentShape.endPoint = location
        currentShape.stroke = globalStroke
        print("touchesBegan startPoint:(\(currentShape.startPoint.x), \(currentShape.startPoint.y)), endPoint:(\(currentShape.endPoint.x), \(currentShape.endPoint.y)")
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let t = touches.first else { return }
        let location = t.location(in: self)

        if currentSelectedShapeType == .select {
            selectedEndPoint = location
        } else {
            guard let currentShape = currentShape else {
                return
            }
            currentShape.endPoint = location
            print("touchesMoved startPoint:(\(currentShape.startPoint.x), \(currentShape.startPoint.y)), endPoint:(\(currentShape.endPoint.x), \(currentShape.endPoint.y)")
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = touches.first else { return }
        if currentSelectedShapeType == .select {
            selectedStartPoint = nil
            selectedEndPoint = nil
        } else if let currentShape = currentShape {
            // 重置currentShape
            shapes.append(currentShape)
            print("touchesEnded startPoint:(\(currentShape.startPoint.x), \(currentShape.startPoint.y)), endPoint:(\(currentShape.endPoint.x), \(currentShape.endPoint.y)")
            self.currentShape = nil
        }
        setNeedsDisplay()
    }
    
}

extension CanvasView {
    
    private func stroke(line: Line) {
        print("draw line")
        let bp = UIBezierPath()
        bp.lineWidth = line.stroke.borderSize
        bp.lineCapStyle = .round
        bp.move(to: line.startPoint)
        bp.addLine(to: line.endPoint)
        bp.stroke()
    }
    
    private func stroke(rect: Rectangle) {
        print("draw rect")
        let bp = UIBezierPath(roundedRect: rect.frame, cornerRadius: 0)
        bp.lineWidth = rect.stroke.borderSize
        bp.stroke()
    }
    
    private func stroke(circle: Circle) {
        print("draw circle")
        let bp = UIBezierPath(ovalIn: circle.frame)
        bp.lineWidth = circle.stroke.borderSize
        bp.stroke()
    }
    
    private func draw(shape: Shape) {
        if let circle = shape as? Circle {
            stroke(circle: circle)
        } else if let rect = shape as? Rectangle {
            stroke(rect: rect)
        } else if let line = shape as? Line {
            stroke(line: line)
        }
    }
}
