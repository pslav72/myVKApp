//
//  GroupAddTableViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 24.02.2021.
//

import UIKit

class AddGroupTableViewController: UITableViewController {
    
    let vkApi = VKApi()
    
    var groups: [Group] = []
    
    var searchActiveGroup : Bool = false
    var searchText: String = ""
    
    @IBOutlet weak var groupSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupSearchBar.delegate = self
        
        tableView.register(UINib(nibName: GroupsRichXIBCell.nibName, bundle: nil), forCellReuseIdentifier: GroupsRichXIBCell.reuseIdentifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsRichXIBCell.reuseIdentifier, for: indexPath) as? GroupsRichXIBCell else { return UITableViewCell()}
        cell.photoService = PhotoService.init(container: self.tableView)
        cell.configure(with: groups[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddGroupsSegue", sender: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActiveGroup = true
        searchBar.showsCancelButton = true
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchActiveGroup = false
        groups.removeAll()
        searchActiveGroup = false
        }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        groups.removeAll()
        searchActiveGroup = false
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        self.searchText = searchText
        
        if searchText.count > 2 {
            vkApi.vkGroupSearch(searchString: searchText,completion: { [weak self] result in
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(groups):
                    self?.groups = groups
                    self?.tableView.reloadData()
                }
            })
        }
    }

}


extension AddGroupTableViewController: UISearchBarDelegate {
    
}
