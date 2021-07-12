//
//  Slider.swift
//  Users
//
//  Created by Jeyaram on 08/07/21.
//

import UIKit

class Slider: UIViewController {
    @IBOutlet var sliderContainer : UIView!
    @IBOutlet var timePickerView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createSlider()
        createTimePicker()
        // Do any additional setup after loading the view.
    }
    func createSlider(){
        let customSlider = SliderView()
        customSlider.frame = sliderContainer.bounds
        customSlider.maxValue = 100
        customSlider.minValue = 0
        sliderContainer.addSubview(customSlider)
    }
    func createTimePicker(){
        let timePicker = TimePicker.getTimePicker()
        timePicker?.frame = timePickerView.bounds
        print(timePicker?.frame)
        timePickerView.addSubview(timePicker!)
        
    }
    

}
