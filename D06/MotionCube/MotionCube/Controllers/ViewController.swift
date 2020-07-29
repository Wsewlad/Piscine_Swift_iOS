//
//  ViewController.swift
//  MotionCube
//
//  Created by Vladyslav FIL on 10/3/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var elasticity: UIDynamicItemBehavior!
    var motionManager: CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(addShapeObject))
        view.addGestureRecognizer(panGesture)
        self.motionManager = CMMotionManager()
        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        self.gravity = UIGravityBehavior(items: [])
        self.gravity.magnitude = 0.7
        self.animator.addBehavior(self.gravity)
        
        self.collision = UICollisionBehavior(items: [])
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(self.collision)
        
        self.elasticity = UIDynamicItemBehavior(items: [])
        self.elasticity.elasticity = 0.8
        self.animator.addBehavior(self.elasticity)
    }
}


extension ViewController {
    @objc func addShapeObject(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            let newShape = ShapeView(point: gesture.location(in: self.view))
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveShapeObject))
            newShape.addGestureRecognizer(panGesture)
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(resizeShapeObject))
            newShape.addGestureRecognizer(pinchGesture)
            let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateShapeObject))
            newShape.addGestureRecognizer(rotationGesture)
            
            self.view.addSubview(newShape)
            
            self.gravity.addItem(newShape)
            self.collision.addItem(newShape)
            self.elasticity.addItem(newShape)
        }
    }
    
    @objc func moveShapeObject(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            self.gravity.removeItem(gesture.view!)
            gesture.view?.center = gesture.location(in: gesture.view?.superview)
            self.animator.updateItem(usingCurrentState: gesture.view!)
        }
        else if gesture.state == .ended {
            self.gravity.addItem(gesture.view!)
        }
    }
    
    @objc func resizeShapeObject(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            self.gravity.removeItem(gesture.view!)
            self.collision.removeItem(gesture.view!)
            self.elasticity.removeItem(gesture.view!)
            
            let maxPerentWidth = (gesture.view?.superview?.bounds.size.width)!
            let maxPerentHeight = (gesture.view?.superview?.bounds.size.height)!
            let maxSize =  maxPerentWidth < maxPerentHeight ? maxPerentWidth : maxPerentHeight
            let minSize: CGFloat = 25.0
            let currSize = (gesture.view?.bounds.size.width)!
            let newSize =  currSize * gesture.scale

            gesture.view?.bounds.size.width = newSize > minSize && newSize < maxSize ? newSize : currSize
            gesture.view?.bounds.size.height = (gesture.view?.bounds.size.width)!

            let shape = gesture.view! as! ShapeView
            if shape.isCycle == 1 {
                gesture.view?.layer.cornerRadius = (gesture.view?.bounds.size.width)! / 2
            }
        }
        else if gesture.state == .ended {
            self.collision.addItem(gesture.view!)
            self.gravity.addItem(gesture.view!)
            self.elasticity.addItem(gesture.view!)
        }
    }
    
    @objc func rotateShapeObject(gesture: UIRotationGestureRecognizer) {
        if gesture.state == .began {
            self.gravity.removeItem(gesture.view!)
        }
        else if gesture.state == .changed {
            gesture.view?.transform = (gesture.view?.transform.rotated(by: gesture.rotation))!
            self.animator.updateItem(usingCurrentState: gesture.view!)
        }
        else if gesture.state == .ended {
            self.gravity.addItem(gesture.view!)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.motionManager.isAccelerometerAvailable {
            self.motionManager.accelerometerUpdateInterval = 0.2
            let queue = OperationQueue.main
            self.motionManager.startAccelerometerUpdates(to: queue, withHandler: accelerometerHandler)
        }
    }
    
    func accelerometerHandler(data: CMAccelerometerData?, error: Error!) {
        if let d = data {
            let x = d.acceleration.x
            let y = d.acceleration.y
            self.gravity.gravityDirection = CGVector(dx: x, dy: -y)
        }
    }
}
