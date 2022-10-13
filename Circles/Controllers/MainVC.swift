//
//  MainVC.swift
//  Circles
//
//  Created by Gary Mansted on 13/7/18.
//  Copyright © 2018 Gary Mansted. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    private var circles = [Circle]()
    private let colorService = ColorService()
    
    // MARK: - View Did Load -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
    }
    
    // MARK: - Can Become First Responder
    override var canBecomeFirstResponder: Bool {
        get { return true }
    }

    // MARK: - Shake Motion Ended
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            for c in circles {
                c.removeFromSuperview()
            }
            circles.removeAll()
        }
    }
    
    // MARK: - Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let xy = touches.first?.location(in: view) {
            let randomRadius = arc4random_uniform(101) + 40
            let x = xy.x - (CGFloat(randomRadius) - (CGFloat(randomRadius) / 2))
            let y = xy.y - (CGFloat(randomRadius) - (CGFloat(randomRadius) / 2))
            DispatchQueue.main.async { [weak self] in
                let circle = Circle(frame: CGRect(x: x, y: y, width: CGFloat(randomRadius), height: CGFloat(randomRadius)))
                circle.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
                self?.circles.append(circle)
                self?.view.addSubview(circle)
                UIView.animate(withDuration: 0.1, animations: {
                    circle.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.1, animations: {
                        circle.transform = .identity
                    })
                })
            }
            colorService.getRandomColor(completion: { [weak self] (error, color) in
                if error != nil {
                    let blue = CGFloat(Int(arc4random() % 255)) / 255.0
                    let green = CGFloat(Int(arc4random() % 255)) / 255.0
                    let red = CGFloat(Int(arc4random() % 255)) / 255.0
                    guard let circleObjects = self?.circles else { return }
                    for c in circleObjects where !c.colorIsSet {
                        c.colorIsSet = true
                        UIView.animate(withDuration: 0.3, animations: {
                            c.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
                        })
                        break
                    }
                }
                else {
                    guard let circleObjects = self?.circles else { return }
                    for c in circleObjects where !c.colorIsSet {
                        c.colorIsSet = true
                        UIView.animate(withDuration: 0.3, animations: {
                            c.backgroundColor = color
                        })
                        break
                    }
                }
            })
        }
    }
}

// END REGION
