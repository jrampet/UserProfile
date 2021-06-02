//
//  UserDetailController.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class UserDetailController: UIViewController {
    var profileData : UserProfile?
    var userSet = [String:String]()
    @IBOutlet var table : UITableView!
    @IBOutlet var userDp : UIImageView!
    
    let identifier = "UserCell"
    let userProfileId = ["Name","Gender","D.O.B","Phone","Email"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTable()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        createData()
    }
    func createData(){
       
        if let data = profileData{
            let name = data.firstName+" "+data.lastName
            let gender = data.gender.capitalized
            let dob = String(data.dateOfBirth.prefix(10))
            let email = data.email.replacingOccurrences(of: "@", with: "\n@")
            let userProfileData = [name,gender,dob,data.phone,email]
            
            self.userSet = Dictionary(uniqueKeysWithValues: zip(userProfileId, userProfileData))
            
            self.userDp.setImage(urlString: data.picture)
            DispatchQueue.main.async {
                self.userDp.rounded()
            }
           
//            print(userDp.frame.width,userDp.frame.height)
        }
        
    }
    func registerTable(){
        table.register(UINib(nibName: self.identifier, bundle: nil), forCellReuseIdentifier: self.identifier)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = .clear
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserDetailController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! UserCell
        cell.configure(label: userProfileId[indexPath.row], value: userSet[userProfileId[indexPath.row]]!)
        return cell
    }
    
    
}
