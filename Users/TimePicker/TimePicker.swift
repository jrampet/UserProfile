//
//  TimePicker.swift
//  Users
//
//  Created by Jeyaram on 11/07/21.
//

import UIKit

class TimePicker: UIView {
    @IBOutlet var hourWheel : TimePickerWheel!
    @IBOutlet var minuteWheel : TimePickerWheel!
    @IBOutlet var meridianWheel : TimePickerWheel!
    @IBOutlet var delimeter : UILabel!
    @IBOutlet var hourSelectionView : UIView!
    @IBOutlet var minuteSelectionView : UIView!
    @IBOutlet var meridianSelectionView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        setContent()
        setStyleforSelectionCell(cells: [hourSelectionView,minuteSelectionView,meridianSelectionView])
    }
    func setContent(){
        var items = [String]()
        for hours in 1...12{
            items.append("\(hours)")
        }
        hourWheel.items = items
        items.removeAll()
        for minutes in 0...59{
            items.append("\(minutes)")
        }
        minuteWheel.items = items
        items = ["AM","PM"]
        meridianWheel.items = items
        print(hourSelectionView.frame,minuteSelectionView.frame,meridianSelectionView.frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    static func getTimePicker() -> TimePicker?{
        return Bundle.main.loadNibNamed("TimePicker", owner: nil, options: nil)![0] as? TimePicker
    }
    func setStyleforSelectionCell(cells : [UIView]){
        let cellBackground = Colors.timeSelectionBackground
        for cell in cells{
            cell.backgroundColor = cellBackground
            cell.layer.cornerRadius = 10
        }
    }
}
