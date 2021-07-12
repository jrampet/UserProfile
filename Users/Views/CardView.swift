//
//  CardView.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//


import UIKit

@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var shadowOffsetWidth: Int = 2
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.5

    override func layoutSubviews() {
        cornerRadius = frame.width/15
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        clipsToBounds = false

    }

}

extension UIView{
    func makeCard(cornerRadius: CGFloat = 0,shadowOffsetWidth:Int = 0,shadowOffsetHeight:Int = 0,shadowColor:UIColor = UIColor.lightGray,shadowOpacity:Float = 0.5){
//        cornerRadius = frame.width/15
        let radius = (cornerRadius == 0) ? (self.frame.width/15) : cornerRadius
        layer.cornerRadius = radius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        clipsToBounds = false
    }
}
