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
    
//    var groups = [
//        Group(json: <#JSON#>, name: "Cats", image: UIImage(named: "iconCat")),
//        Group(name: "Dogs", image: UIImage(named: "iconDog")),
//        Group(name: "Flowers", image: UIImage(named: "iconFlower")),
//        Group(name: "Cars", image: UIImage(named: "iconCar")),
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: GroupsRichXIBCell.nibName, bundle: nil), forCellReuseIdentifier: GroupsRichXIBCell.reuseIdentifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vkApi.vkGroupSearch(searchString: "mail.ru",completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(groups):
                self?.groups = groups
                self?.tableView.reloadData()
            }
        })
        print(self.groups)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsRichXIBCell.reuseIdentifier, for: indexPath) as? GroupsRichXIBCell else { return UITableViewCell()}
        
        cell.configure(with: groups[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddGroupsSegue", sender: nil)
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "ShowAvailableGroupsSegue", sender: nil)
//    }

}
