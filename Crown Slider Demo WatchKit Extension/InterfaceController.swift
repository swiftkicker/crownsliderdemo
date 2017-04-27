//
//  InterfaceController.swift
//  Crown Slider Demo WatchKit Extension
//
//  Created by Kevin Truss on 2017-04-27.
//  Copyright © 2017 Swiftkick Software. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var valueLabel: WKInterfaceLabel!

    @IBOutlet var valueSlider: WKInterfaceSlider!

    @IBAction func valueSliderChanged(_ value: Float) {
        myValue = Int(value)
    }
    
    var crownAccumulator = 0.0
    var myValue: Int = 0 {
        didSet {
            if myValue < 0 || myValue > 10 {
                myValue = oldValue
            }
            valueLabel.setText("\(myValue)")
            valueSlider.setValue(Float(myValue))
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        crownSequencer.delegate = self
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        crownSequencer.focus()

    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension InterfaceController: WKCrownDelegate {
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        
        crownAccumulator += rotationalDelta
        
        if crownAccumulator > 0.1 {
            myValue += 1
            crownAccumulator = 0.0
        } else if crownAccumulator < -0.1 {
            myValue -= 1
            crownAccumulator = 0.0
        }

    }
    
}

