//
//  Filters.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class Filters: UITableView {
   
   let identifier = "FiltersCell"
    var lastContentOffset: CGFloat = 0
    var filteredData = [UserData](){
        didSet{
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    var dataOfUsers = [UserData](){
        didSet{
            filteredData = dataOfUsers
        }
    }
    var showUserData:((UserProfile)->())?
    var tableScroll:((_ distance: CGFloat)->())?
    override func awakeFromNib() {
    register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        delegate = self
        dataSource = self
        backgroundColor = .clear
    }
}
extension Filters : UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as! FiltersCell
        cell.configure(data: filteredData[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileUrl = api.userProfile + filteredData[indexPath.row].id
        FetchApi.request(url: profileUrl, completion:  {[weak self]
            (data) in
            guard let self = self else{return}
            let userData : UserProfile = data.decode()
            self.showUserData?(userData)
        })
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return getHeader(with: "Filters")
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func getHeader(with text:String)->UIView{
        let headerView = UIView.init(frame: CGRect.init(x: 15, y: 25, width: self.frame.width-60, height: 70))
                let label = UILabel()
                label.frame = CGRect.init(x: 25, y: 5, width: headerView.frame.width-50, height: headerView.frame.height-10)
                label.text = text
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
                label.textColor = Colors.headertextColor
  
        headerView.layer.cornerRadius = 30
                headerView.addSubview(label)
                return headerView
    }
  
   

 
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }

 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let d = scrollView.contentOffset.y - self.lastContentOffset
//        print("Diff:",lastContentOffset-d)
        tableScroll?(d)
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
