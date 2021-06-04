//
//  ListGroupTableViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.02.2021.
//

import UIKit
import RealmSwift

class ListGroupsTableViewController: UITableViewController {
    
    let vkApi = VKApi()
    let realmService = RealmService.self
    var getApiGroup: Bool = false
//    var activeGroup: [Group] = []
    private lazy var activeGroup: Results<Group> = try! Realm(configuration: realmService.config).objects(Group.self)
    
    var searchActiveGroup : Bool = false
    var filteredGroup : [Group] = []
    var searchText: String = ""
    
    @IBOutlet weak var groupSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupSearchBar.delegate = self
        
        tableView.register(UINib(nibName: GroupsRichXIBCell.nibName, bundle: nil), forCellReuseIdentifier: GroupsRichXIBCell.reuseIdentifier)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.getApiGroup {
            vkApi.vkGroupGet(completion: { [weak self] result in
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(groups):
                    do {
                        try self?.realmService.save(items: groups)
                        self?.tableView.reloadData()
                    } catch {
                        print(error)
                    }
//                    self?.activeGroup = groups
                    self?.getApiGroup = true
                    
                }
            })
//            print(self.activeGroup)
        }
    }
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if let addGroupTableViewController = segue.source as? AddGroupTableViewController,
           let selectedIndexPath = addGroupTableViewController.tableView.indexPathForSelectedRow {
            let selectedGroup = addGroupTableViewController.groups[selectedIndexPath.row]
            
            if !activeGroup.contains(selectedGroup) {
                do {
                    try self.realmService.save(items: selectedGroup)
                    filteredGroup.removeAll()
                    searchActiveGroup = false
                    tableView.reloadData()
                } catch {
                    print(error)
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActiveGroup, filteredGroup.count > 0 {
            return filteredGroup.count
        } else if searchActiveGroup, filteredGroup.count == 0 {
            return 0
        }
        else {
            return activeGroup.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsRichXIBCell.reuseIdentifier, for: indexPath) as? GroupsRichXIBCell else { return UITableViewCell()}
        if searchActiveGroup, filteredGroup.count > 0 {
            cell.configure(with: filteredGroup[indexPath.row])
        }
        else {
            cell.configure(with: activeGroup[indexPath.row])
        }
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if filteredGroup.count > 0 {
                let nameGroup = filteredGroup[indexPath.row].name
                
                if let indexPathActiveGroup = activeGroup.firstIndex(where: {$0.name == nameGroup}) {
                    print(indexPathActiveGroup)
                    try? realmService.delete(items: activeGroup[indexPath.row])
                    filteredGroup.remove(at: indexPath.row)
                    if filteredGroup.count > 0 {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        searchActiveGroup = false
                        groupSearchBar.resignFirstResponder()
                    }
                    tableView.reloadData()
                }
            } else {
                try? realmService.delete(items: activeGroup[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActiveGroup = true
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        filteredGroup.removeAll()
        searchActiveGroup = false
        }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filteredGroup.removeAll()
        searchActiveGroup = false
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        self.searchText = searchText
        filteredGroup = activeGroup.filter{$0.name.contains(searchText)}
        
        if(filteredGroup.count == 0){
            searchActiveGroup = true
        } else {
            searchActiveGroup = true
        }
        tableView.reloadData()
    }
    
}


extension ListGroupsTableViewController: UISearchBarDelegate {
}
