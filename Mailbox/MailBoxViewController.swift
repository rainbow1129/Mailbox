//
//  MailBoxViewController.swift
//  Mailbox
//
//  Created by Haihong Wang on 11/7/15.
//  Copyright © 2015 Haihong Wang. All rights reserved.
//

import UIKit

class MailBoxViewController: UIViewController {
    
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var rightBackground: UIImageView!
    @IBOutlet weak var leftBackground: UIImageView!
    @IBOutlet weak var feed: UIImageView!
    @IBOutlet weak var feedScrollView: UIScrollView!
    
    var initialCenter: CGPoint!
    
    // let grayColor = UIColor(red: 0xEA, green: 0xEA, blue: 0xEA, alpha: 1)
    let grayColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
    let yellowColor = UIColor(red: 0.96, green: 0.8, blue: 0, alpha: 1)
    let brownColor = UIColor(red: 0.83, green: 0.55, blue: 0.34, alpha: 1)
    let greenColor = UIColor(red: 0.38, green: 0.67, blue: 0.38, alpha: 1)
    let redColor = UIColor(red: 0.89, green: 0.3, blue: 0.3, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedScrollView.contentSize = CGSize(width: feed.image!.size.width, height: feed.image!.size.height + 90)
        rightBackground.alpha = 0
        leftBackground.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            initialCenter = messageView.center
            rightBackground.backgroundColor = grayColor
            leftBackground.backgroundColor = grayColor
            
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            messageView.center = CGPoint(x: translation.x + initialCenter.x, y: initialCenter.y)
            let diff = self.messageView.center.x - self.view.center.x
            if (diff < 0) {
                self.leftBackground.alpha = 1
                self.rightBackground.alpha = 0
                
                // Later icon
                // Change opacity
                if (diff > -60) {
                    leftBackground.backgroundColor = grayColor
                    laterIcon.alpha = (-diff/60)
                    listIcon.alpha = 0
                    
                } else if (diff > -260) {
                    leftBackground.backgroundColor = yellowColor
                    laterIcon.center = CGPoint(x: (initialCenter.x + translation.x + 190), y: laterIcon.center.y)
                    laterIcon.alpha = 1
                    listIcon.alpha = 0
                    print(laterIcon.frame.origin)
                    
                } else {
                    leftBackground.backgroundColor = brownColor
                    listIcon.center = CGPoint(x: (initialCenter.x + translation.x + 190), y: listIcon.center.y)
                    laterIcon.alpha = 0
                    listIcon.alpha = 1
                }
                /*
                if ((self.messageView.center.x + self.messageView.frame.width / 2) < (self.laterIcon.frame.origin.x + self.laterIcon.frame.width)) {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.laterIcon.alpha = 1
                    })
                } else if (self.messageView.center.x < (self.view.center.x - 60)) {
                    laterIcon.transform = CGAffineTransformMakeTranslation(messageView.center.x + 170, laterIcon.center.y)
                    leftBackground.backgroundColor = UIColor.yellowColor()
                }
                */
                
            } else {
                self.rightBackground.alpha = 1
                self.leftBackground.alpha = 0
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                if self.messageView.center.x > self.view.center.x - 60 {
                    self.messageView.frame.origin.x = 0
                    self.laterIcon.alpha = 0
                }
                
            })
            
        }
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}