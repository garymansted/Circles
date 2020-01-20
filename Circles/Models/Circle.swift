//
//  Circle.swift
//  Circles
//
//  Created by Gary Mansted on 13/7/18.
//  Copyright © 2018 Gary Mansted. All rights reserved.
//

import UIKit

class Circle: UIView {
    
    var colorIsSet = false
    var lastLocation = CGPoint(x: 0, y: 0)
    let colorController = ColorController()
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        let panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(Circle.detectPan(_:)))
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action:#selector(Circle.detectDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action:#selector(Circle.detectPinch(_:)))
        self.gestureRecognizers = [panRecognizer, doubleTapRecognizer, pinchRecognizer]
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    // MARK: - Init Coder
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Circle Pan Guesture
    @objc func detectPan(_ recognizer: UIPanGestureRecognizer) {
        let translation  = recognizer.translation(in: self.superview)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
    
    // MARK: - Circle Double Tap Guesture
    @objc func detectDoubleTap(_ recognizer: UITapGestureRecognizer) {
        colorController.getRandomColor(completion: { (error, color) in
            if error != nil {
                let blue = CGFloat(Int(arc4random() % 255)) / 255.0
                let green = CGFloat(Int(arc4random() % 255)) / 255.0
                let red = CGFloat(Int(arc4random() % 255)) / 255.0
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
                })
            }
            else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundColor = color
                })
            }
        })
    }
    
    // MARK: - Circle Pinch Guesture
    @objc func detectPinch(_ recognizer: UIPinchGestureRecognizer) {
        self.transform = self.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
    }
    
    // MARK: - Touches Began
    override func touchesBegan(_ touches: (Set<UITouch>?), with event: UIEvent!) {
        self.superview?.bringSubviewToFront(self)
        lastLocation = self.center
    }

}
