//
//  SearchBar.swift
//  Users
//
//  Created by Jeyaram on 17/06/21.
//

import UIKit
protocol CustomSearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
}
class CustomSearchBar: UISearchBar {
    var customSearchBardelegate: CustomSearchBarDelegate?
    override func awakeFromNib() {
        delegate = self
    }
}
extension CustomSearchBar : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        customSearchBardelegate?.searchBar(searchBar, textDidChange: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        customSearchBardelegate?.searchBarSearchButtonClicked(searchBar)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
        customSearchBardelegate?.searchBarTextDidBeginEditing(searchBar)
       
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.showsCancelButton = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        customSearchBardelegate?.searchBarCancelButtonClicked(searchBar)
    }
}

