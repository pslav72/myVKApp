//
//  ListGroupTableViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.02.2021.
//

import UIKit

class ListGroupsTableViewController: UITableViewController {
    
    var activeGroup = [
        Group(name: "New", image: UIImage(named: "iconCat"))
    ]
    
    var searchActiveGroup : Bool = false
    var filteredGroup : [Group] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        tableView.register(UINib(nibName: GroupsRichXIBCell.nibName, bundle: nil), forCellReuseIdentifier: GroupsRichXIBCell.reuseIdentifier)

    }
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if let addGroupTableViewController = segue.source as? AddGroupTableViewController,
           let selectedIndexPath = addGroupTableViewController.tableView.indexPathForSelectedRow {
            let selectedGroup = addGroupTableViewController.groups[selectedIndexPath.row]
            
            if !activeGroup.contains(selectedGroup) {
                activeGroup.append(selectedGroup)
//                returnFromAddGroup = true
                filteredGroup.removeAll()
                searchActiveGroup = false
                tableView.reloadData()
            }
        }
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActiveGroup, filteredGroup.count > 0 {
            return filteredGroup.count
        } else {
            return activeGroup.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsRichXIBCell.reuseIdentifier, for: indexPath) as? GroupsRichXIBCell else { return UITableViewCell()}
        if searchActiveGroup, filteredGroup.count > 0 {
            cell.configure(with: filteredGroup[indexPath.row])
        } else {
            cell.configure(with: activeGroup[indexPath.row])
        }

        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        searchActiveGroup = false
        filteredGroup.removeAll()
        searchBar.resignFirstResponder()
        if editingStyle == .delete {
            if filteredGroup.count > 0 {
                searchBar.showsCancelButton = false
                searchBar.text = nil
                filteredGroup.removeAll()
                searchActiveGroup = false
            }
            activeGroup.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActiveGroup = false
        searchBar.showsCancelButton = true
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
        filteredGroup.removeAll()
        searchActiveGroup = false
        }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
        filteredGroup.removeAll()
        searchActiveGroup = false
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        filteredGroup = activeGroup.filter{$0.name == searchText}
        
        if(filteredGroup.count == 0){
            searchActiveGroup = false
        } else {
            searchActiveGroup = true
        }
        tableView.reloadData()
    }
    
}

extension ListGroupsTableViewController: UISearchBarDelegate {
}
