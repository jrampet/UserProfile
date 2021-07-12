//
//  SliderThumb.swift
//  Users
//
//  Created by Jeyaram on 08/07/21.
//

import UIKit

class SliderThumb: UIView {
    var valueofSlider = UILabel()
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        backgroundColor = .white
        setSliderValue()
    }
    func setSliderValue(){
        valueofSlider.frame = self.bounds
        valueofSlider.text = "0"
        valueofSlider.textColor = UIColor(red: 39/255, green: 164/255, blue: 60/255, alpha: 1)
        valueofSlider.textAlignment = .center
        addSubview(valueofSlider)
        makeRound()
    }
 

}
extension UIView{
    func asImage() -> UIImage {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        }
    func makeRound(){
        layer.cornerRadius = frame.width/2
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    func createDottedLine(width: CGFloat, color: CGColor) {
          let caShapeLayer = CAShapeLayer()
          caShapeLayer.strokeColor = color
          caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [0.01,10]
        
        caShapeLayer.lineCap = CAShapeLayerLineCap.round;
          let cgPath = CGMutablePath()
          let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
          cgPath.addLines(between: cgPoint)
          caShapeLayer.path = cgPath
          layer.addSublayer(caShapeLayer)
       }
}

