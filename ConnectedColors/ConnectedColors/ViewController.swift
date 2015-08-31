//
//  ViewController.swift
//  ConnectedColors
//
//  Created by Arashi USUKI on 8/31/15.
//  Copyright (c) 2015 Arashi USUKI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let colorService = ColorServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colorService.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var connectionsLabel: UILabel!
  
    @IBAction func redTapped(sender: AnyObject) {
        self.changeColor(UIColor.redColor())
        colorService.sendColor("red")
    }

    @IBAction func yellowTapped(sender: AnyObject) {
        self.changeColor(UIColor.yellowColor())
        colorService.sendColor("yellow")
    }
    
    func changeColor(color : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = color
        }
    }
    
}

extension ViewController : ColorServiceManagerDelegate {
        
    func connectedDevicesChanged(manager: ColorServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
        
    func colorChanged(manager: ColorServiceManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            switch colorString {
            case "red":
                self.changeColor(UIColor.redColor())
            case "yellow":
                self.changeColor(UIColor.yellowColor())
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
}



