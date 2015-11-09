//
//  MailBoxViewController.swift
//  Mailbox
//
//  Created by Haihong Wang on 11/7/15.
//  Copyright © 2015 Haihong Wang. All rights reserved.
//

import UIKit

class MailBoxViewController: UIViewController {
    
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var menuView: UIImageView!
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
    let brownColor = UIColor(red: 0.81, green: 0.64, blue: 0.52, alpha: 1)
    let greenColor = UIColor(red: 0.38, green: 0.67, blue: 0.38, alpha: 1)
    let redColor = UIColor(red: 0.89, green: 0.3, blue: 0.3, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedScrollView.contentSize = CGSize(width: feed.image!.size.width, height: feed.image!.size.height + 90)
        rightBackground.alpha = 0
        leftBackground.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
        menuView.alpha = 0
        listView.alpha = 0
        rescheduleView.alpha = 0
        
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
                    archiveIcon.alpha = 0
                    deleteIcon.alpha = 0
                    
                } else if (diff > -260) {
                    leftBackground.backgroundColor = yellowColor
                    laterIcon.center = CGPoint(x: (initialCenter.x + translation.x + 190), y: laterIcon.center.y)
                    laterIcon.alpha = 1
                    listIcon.alpha = 0
                    archiveIcon.alpha = 0
                    deleteIcon.alpha = 0
                    print(laterIcon.frame.origin)
                    
                } else {
                    leftBackground.backgroundColor = brownColor
                    listIcon.center = CGPoint(x: (initialCenter.x + translation.x + 190), y: listIcon.center.y)
                    laterIcon.alpha = 0
                    listIcon.alpha = 1
                    archiveIcon.alpha = 0
                    deleteIcon.alpha = 0
                }
                
                
            } else {
                self.rightBackground.alpha = 1
                self.leftBackground.alpha = 0
                if (diff < 60) {
                    rightBackground.backgroundColor = grayColor
                    archiveIcon.alpha = (diff/60)
                    deleteIcon.alpha = 0
                    laterIcon.alpha = 0
                    listIcon.alpha = 0
                    
                } else if (diff < 260) {
                    rightBackground.backgroundColor = greenColor
                    archiveIcon.center = CGPoint(x: (initialCenter.x + translation.x - 190), y: laterIcon.center.y)
                    archiveIcon.alpha = 1
                    deleteIcon.alpha = 0
                    laterIcon.alpha = 0
                    listIcon.alpha = 0
                    
                } else {
                    rightBackground.backgroundColor = redColor
                    deleteIcon.center = CGPoint(x: (initialCenter.x + translation.x - 190), y: laterIcon.center.y)
                    archiveIcon.alpha = 0
                    deleteIcon.alpha = 1
                    laterIcon.alpha = 0
                    listIcon.alpha = 0
                }
                
            }
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            let diff = self.messageView.center.x - self.view.center.x
            if (diff < 0) {
                self.leftBackground.alpha = 1
                self.rightBackground.alpha = 0
                if (diff > -60) {
                    //  If released at this point, the message should return to its initial position.
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.messageView.frame.origin.x = 0
                    })
                } else if (diff > -260) {
                    // Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
                    UIView.animateWithDuration(0.3, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                        self.messageView.frame.origin.x = -320
                        self.laterIcon.frame.origin.x = 30
                        self.laterIcon.alpha = 0
                        }, completion: { (finished: Bool) -> Void in
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.rescheduleView.alpha = 1
                            })
                    })
                } else {
                    // Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
                    UIView.animateWithDuration(0.3, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                        self.messageView.frame.origin.x = -320
                        self.listIcon.frame.origin.x = 30
                        self.listIcon.alpha = 0
                        }, completion: { (finished: Bool) -> Void in
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.listView.alpha = 1
                            })
                    })
                }
                
            } else {
                self.rightBackground.alpha = 1
                self.leftBackground.alpha = 0
                if (diff < 60) {
                    //If released at this point, the message should return to its initial position.
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.messageView.frame.origin.x = 0
                    })
                    
                } else if (diff < 260) {
                    //Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
                    UIView.animateWithDuration(0.3, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        self.messageView.frame.origin.x = 320
                        self.archiveIcon.frame.origin.x = 290
                        self.archiveIcon.alpha = 0
                        }, completion: { (finished: Bool) -> Void in
                            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut , animations: { () -> Void in
                                self.feed.frame.origin.y = 0
                                self.rightBackground.alpha = 0
                                self.leftBackground.alpha = 0
                                }, completion: { (finished: Bool) -> Void in
                                    
                            })
                            
                    })
                    
                } else {
                    //Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
                    UIView.animateWithDuration(0.3, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { () -> Void in
                        self.messageView.frame.origin.x = 320
                        self.deleteIcon.frame.origin.x = 290
                        self.deleteIcon.alpha = 0
                        }, completion: { (finished: Bool) -> Void in
                            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut , animations: { () -> Void in
                                self.feed.frame.origin.y = 0
                                self.rightBackground.alpha = 0
                                self.leftBackground.alpha = 0
                                }, completion: { (finished: Bool) -> Void in
                                    
                            })
                            
                    })
                }
                
                
            }
        }
    }
    
    @IBAction func didTapReschedule(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: { () -> Void in
            self.rescheduleView.alpha = 0
            self.feed.frame.origin.y = 0
            self.rightBackground.alpha = 0
            self.leftBackground.alpha = 0
            }, completion: { (finished: Bool) -> Void in
        })
    }
    
    @IBAction func didTapList(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: { () -> Void in
            self.listView.alpha = 0
            self.feed.frame.origin.y = 0
            self.rightBackground.alpha = 0
            self.leftBackground.alpha = 0
            }, completion: { (finished: Bool) -> Void in
        })
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