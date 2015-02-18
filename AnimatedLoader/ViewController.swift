//
//  ViewController.swift
//  AnimatedLoader
//
//  Created by Ryan Ackermann on 2/17/15.
//  Copyright (c) 2015 Ryan Ackermann. All rights reserved.
//
//  Created following http://www.ios-animations-by-emails.com/posts/welcome-issue#tutorial
//  Check it out

import UIKit

class ViewController: UIViewController {
    
    let bigSize = CGSize(width: 200, height: 200)
    let bigCircleView = UIView()
    let bigCircleLayer = CAShapeLayer()
    
    let smallSize = CGSize(width: 160, height: 160)
    let smallCircleView = UIView()
    let smallCircleLayer = CAShapeLayer()
    
    var currentInnerRotation: CGFloat = 0.0
    var currentOuterRotation: CGFloat = 0.0
    
    var blurEffect: UIBlurEffect! = UIBlurEffect(style: .Dark)
    var blurView: UIVisualEffectView!
    var vibrancyView: UIVisualEffectView!
    
    let imageView = UIImageView()
    
    let loadingLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Big circle view's initial frame size
        bigCircleView.frame.size = bigSize
        
        // Big circle layer's defined properties
        bigCircleLayer.path = UIBezierPath(ovalInRect: bigCircleView.frame).CGPath
        bigCircleLayer.lineWidth = 6.0
        bigCircleLayer.strokeStart = 0.0
        bigCircleLayer.strokeEnd = 0.4
        bigCircleLayer.lineCap = kCALineCapRound
        bigCircleLayer.fillColor = UIColor.clearColor().CGColor
        bigCircleLayer.strokeColor = UIColor(white: 1.0, alpha: 0.85).CGColor
        
        bigCircleView.layer.addSublayer(bigCircleLayer)
        bigCircleView.center = view.center
        
        // Small circle view's initial frame size
        smallCircleView.frame.size = smallSize
        
        // Small circle layer's defined properties
        smallCircleLayer.path = UIBezierPath(ovalInRect: smallCircleView.frame).CGPath
        smallCircleLayer.lineWidth = 3.0
        smallCircleLayer.strokeStart = 0.7
        smallCircleLayer.strokeEnd = 1.0
        smallCircleLayer.lineCap = kCALineCapRound
        smallCircleLayer.fillColor = UIColor.clearColor().CGColor
        smallCircleLayer.strokeColor = UIColor(white: 1.0, alpha: 0.6).CGColor
        
        smallCircleView.layer.addSublayer(smallCircleLayer)
        smallCircleView.center = view.center
        
        // Add an image to show the blurred effect
        imageView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame))
        imageView.image = UIImage(named: "bluemarblewest.jpg")
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        imageView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))
        view.addSubview(imageView)
        
        // Add the loading label
        loadingLabel.frame.size = CGSize(width: bigSize.width/2, height: bigSize.height/2)
        loadingLabel.text = "Loading..."
        loadingLabel.font = UIFont(name: "Avenir", size: 17.0)
        loadingLabel.center = view.center
        loadingLabel.textColor = UIColor(white: 1.0, alpha: 0.85)
        loadingLabel.textAlignment = .Center
        
        // Make the background match the picture
        view.backgroundColor = UIColor.blackColor()
        
        // Animate the arcs
        animateBig()
        animateSmall()
        
        // Add the blur effect
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        
        // Add the vibrancy effect to the blur
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.frame = view.bounds
        view.addSubview(vibrancyView)
        
        // Add the arcs to the vibrancy view
        vibrancyView.addSubview(bigCircleView)
        vibrancyView.addSubview(smallCircleView)
        vibrancyView.addSubview(loadingLabel)
    }

    func animateBig() {
        UIView.animateWithDuration(0.6, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.currentOuterRotation += CGFloat(M_PI_4)
            self.bigCircleView.transform = CGAffineTransformMakeRotation(self.currentOuterRotation)
            
            }, completion: { _ in
                self.animateBig()
        })
    }
    
    func animateSmall() {
        UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.currentInnerRotation += CGFloat(M_PI/3)
            self.smallCircleView.transform = CGAffineTransformMakeRotation(self.currentInnerRotation)
            
            }, completion: { _ in
                self.animateSmall()
        })
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

