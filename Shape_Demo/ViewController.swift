//
//  ViewController.swift
//  Shape_Demo
//
//  Created by MacBook Pro on 24/9/21.
//

import UIKit

class ViewController: UIViewController {
    var startPoint: CGPoint?
    var endPoint: CGPoint?
    var startDot: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var endDot: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    let shapeLayer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            
            if self.startPoint != nil {
                let point = touch.location(in: view)
                if shapeLayer.contains(point) {
                    shapeLayer.strokeColor = UIColor.green.cgColor
                }
                return
            }
            let position = touch.location(in: view)
            self.startPoint = position
            startDot.center = position
            startDot.backgroundColor = .red
            view.addSubview(startDot)
            let tap = UIPanGestureRecognizer(target: self, action: #selector(self.handleStartPointPan(gesture:)))
            startDot.addGestureRecognizer(tap)
            print(position)
            
        }
    }
    @objc func handleStartPointPan(gesture: UIPanGestureRecognizer) {
        let newStart = gesture.location(in: view)
        if let endPoint = self.endPoint {
            startDot.center = newStart
            self.drawLineFromPoint(start: gesture.location(in: view), toPoint: endPoint, ofColor: UIColor.blue, inView: self.view)
            if gesture.state == UIGestureRecognizer.State.ended {

                self.startPoint = gesture.location(in: view)
             }
        }
        

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.endPoint != nil {
            return
        }
        if let touch = touches.first, let startPoint = self.startPoint{
            
            let position = touch.location(in: view)
            self.drawLineFromPoint(start: startPoint, toPoint: position, ofColor: UIColor.blue, inView: self.view)
            self.endPoint = position
            endDot.center = position
            endDot.backgroundColor = .red
            view.addSubview(endDot)
            let tap = UIPanGestureRecognizer(target: self, action: #selector(self.handleEndPointPan(gesture:)))
            endDot.addGestureRecognizer(tap)
        }
    }
    @objc func handleEndPointPan(gesture: UIPanGestureRecognizer) {
        let newEnd = gesture.location(in: view)
        if let startPoint = self.startPoint {
            endDot.center = newEnd
            self.drawLineFromPoint(start: startPoint , toPoint: gesture.location(in: view), ofColor: UIColor.blue, inView: self.view)
            if gesture.state == UIGestureRecognizer.State.ended {

                self.endPoint = gesture.location(in: view)
             }
        }

    }
    
    //Not sure how to do this part ???
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        
        shapeLayer.removeFromSuperlayer()

        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1.0
        
        view.layer.addSublayer(shapeLayer)
        
    }
    
}

