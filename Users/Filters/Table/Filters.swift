//
//  Filters.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class Filters: UITableView {
    let apiFetch = FetchApi()
   let identifier = "FiltersCell"
    var dataArray = [userData]()
    var showUserData:((UserProfile)->())?
    override func awakeFromNib() {
    register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        delegate = self
        dataSource = self
        backgroundColor = .clear
    
    }
}
extension Filters : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as! FiltersCell
        cell.configure(data: dataArray[indexPath.row])
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        apiFetch.requestuserProfile(for: dataArray[indexPath.row].id, completion: {
            (data) in
            self.showUserData?(data)
        })
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return getHeader(with: "Filters")
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func getHeader(with text:String)->UIView{
        let headerView = UIView.init(frame: CGRect.init(x: 15, y: 25, width: self.frame.width, height: 70))
                let label = UILabel()
                label.frame = CGRect.init(x: 25, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
                label.text = text
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
                label.textColor = Colors.headertextColor
        headerView.backgroundColor = .white
   
        headerView.layer.cornerRadius = 30
                headerView.addSubview(label)
                return headerView
    }
    
    
}
/*
 apifetch.request(url: api.url, completion: {
     data in
     print(data.data.count)
     table.dataArray = data.data
     collection.cellData = data.data
     print(table.dataArray.count)
     DispatchQueue.main.async {
         table.reloadData()
         collection.reloadData()
     }
 })
 */
