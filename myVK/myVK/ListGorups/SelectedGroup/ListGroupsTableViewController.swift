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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: GroupsRichXIBCell.nibName, bundle: nil), forCellReuseIdentifier: GroupsRichXIBCell.reuseIdentifier)

    }
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if let addGroupTableViewController = segue.source as? AddGroupTableViewController,
           let selectedIndexPath = addGroupTableViewController.tableView.indexPathForSelectedRow {
            let selectedGroup = addGroupTableViewController.groups[selectedIndexPath.row]
            
            if !activeGroup.contains(selectedGroup) {
                activeGroup.append(selectedGroup)
                tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activeGroup.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsRichXIBCell.reuseIdentifier, for: indexPath) as? GroupsRichXIBCell else { return UITableViewCell()}

        cell.configure(with: activeGroup[indexPath.row])

        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            activeGroup.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
        }
    }
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}