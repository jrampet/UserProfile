//
//  CustomSlider.swift
//  Users
//
//  Created by Jeyaram on 08/07/21.
//

import UIKit
class SliderView : UIView{
    let sliderThumbImage = SliderThumb()
    var slider = UISlider()
    var maxValue : Float = 0
    var minValue : Float = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func didMoveToSuperview() {
        setSlider()
    }
    func setSlider(){
        slider.backgroundColor = .clear
        addSubview(slider)
        layer.cornerRadius = 8
        backgroundColor = Colors.sliderBackground
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        let minTextLabel = UILabel(frame: CGRect(x: 10, y: 5, width: 10, height: frame.height-10))
        minTextLabel.text = "\(slider.minimumValue)"
        minTextLabel.font = minTextLabel.font.withSize(14)
        minTextLabel.textColor = .white
        let dottedLine = UIView(frame: CGRect(x: 30, y: frame.height/2, width:  frame.width-65, height: 5))
        slider.frame = CGRect(x: 25, y: 0, width: frame.width-60, height: frame.height)
        let maxTextLabel = UILabel(frame: CGRect(x: dottedLine.frame.maxX+5, y: 5, width: frame.maxX-dottedLine.frame.maxX+10, height:frame.height-10))
        dottedLine.createDottedLine(width: 5, color: UIColor.white.cgColor)
        maxTextLabel.text = "\(Int(slider.maximumValue))"
        maxTextLabel.textColor = .white
        maxTextLabel.font = maxTextLabel.font.withSize(14)
        sliderThumbImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        slider.setThumbImage(sliderThumbImage.asImage(), for: .normal)
        
        slider.maximumTrackTintColor = .clear
        slider.minimumTrackTintColor = .clear
       
        addSubview(dottedLine)
        sendSubviewToBack(dottedLine)
        addSubview(minTextLabel)
        addSubview(maxTextLabel)
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @objc func sliderValueDidChange(_ sender:UISlider!)
        {
            let roundedStepValue = round(sender.value)
            sender.value = roundedStepValue
            sliderThumbImage.valueofSlider.text = "\(Int(roundedStepValue))"
        slider.setThumbImage(sliderThumbImage.asImage(), for: .normal)
        slider.setThumbImage(sliderThumbImage.asImage(), for: .highlighted)
           
        }
}




