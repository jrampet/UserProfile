//
//  Recents.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class Recents: UICollectionView {
    let identifier = "CollectionCell"
    var cellData = [userData]()
    override func awakeFromNib() {
        self.register(UINib(nibName: self.identifier, bundle: nil), forCellWithReuseIdentifier: self.identifier)
        delegate = self
        dataSource = self
        isOpaque = false
        backgroundColor = .clear
    }

}
extension Recents : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count - 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionCell
        cell.configure(data: cellData[indexPath.row+1])
        return cell
    }
    
    
    
}
