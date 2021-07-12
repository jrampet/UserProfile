//
//  TimePickerWheel.swift
//  Users
//
//  Created by Jeyaram on 11/07/21.
//

import UIKit

class TimePickerWheel: UITableView {
    let cellId = "Cell"
    var items = [String]()
    var itemHeight : CGFloat = 0
    var timePickerView : TimePicker?
    override func awakeFromNib() {
        register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.delegate = self
        self.dataSource = self
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        bounces = false
        backgroundColor = .clear
        backgroundView = nil
    }
    var isviewloaded = false
    var selectedIndexPath = IndexPath(row: 0, section: 0) {
        didSet {
            guard  isviewloaded, items.count > 0,
                selectedIndexPath.row >= 0, selectedIndexPath.row < items.count else {
                    return
            }
            
           scrollToRow(at: selectedIndexPath, at: .top, animated: true)
//            delegate?.wheelViewController(self, didSelectItemAtRow: selectedIndexPath.row)
        }
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if(superview != nil){
            isviewloaded = true
        }
        
    }
   

}
extension TimePickerWheel : UITableViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let point = CGPoint(
            x: scrollView.center.x + scrollView.contentOffset.x,
            y: scrollView.center.y + scrollView.contentOffset.y
        )
        guard let indexPath = indexPathForRow(at: point) else { return }
        print(indexPath)
        selectedIndexPath = indexPath
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        
        scrollViewDidEndDecelerating(scrollView)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = CGPoint(
            x: scrollView.center.x + scrollView.contentOffset.x,
            y: scrollView.center.y + scrollView.contentOffset.y
        )
        guard let indexPath = indexPathForRow(at: point) else { return }
        print(indexPath)
        changeFont(at: indexPath)
    }
    func changeFont(at indexPath:IndexPath){
        if(indexPath.row > 0){
            setDefault(at: IndexPath(row: indexPath.row - 1, section: 0))
        }
        if items.count > indexPath.row + 1 {
            let nextIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
            setDefault(at: nextIndexPath)
        }
        let cell = self.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = Colors.themeGreen
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    func setDefault(at indexPath:IndexPath){
        
        let cell = self.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = Colors.gray
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.frame.height / 3
    }
    
}
extension TimePickerWheel : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = Colors.gray
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        if(indexPath == selectedIndexPath){
            cell.textLabel?.textColor = Colors.themeGreen
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.frame.height / 3
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        self.frame.height / 3
    }
    
    
}
