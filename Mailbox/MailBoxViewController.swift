//
//  MailBoxViewController.swift
//  Mailbox
//
//  Created by Haihong Wang on 11/7/15.
//  Copyright © 2015 Haihong Wang. All rights reserved.
//

import UIKit

class MailBoxViewController: UIViewController {
    
    
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var rightBackground: UIImageView!
    @IBOutlet weak var leftBackground: UIImageView!
    @IBOutlet weak var feed: UIImageView!
    @IBOutlet weak var feedScrollView: UIScrollView!
    
    var initialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedScrollView.contentSize = CGSize(width: feed.image!.size.width, height: feed.image!.size.height + 90)
        rightBackground.alpha = 0
        leftBackground.alpha = 0

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
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageView.center = CGPoint(x: translation.x + initialCenter.x, y: initialCenter.y)
            
            
          
        } else if sender.state == UIGestureRecognizerState.Ended {
           
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