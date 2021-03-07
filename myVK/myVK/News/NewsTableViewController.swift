//
//  NewsTableViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 05.03.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var news = [
        News(user: "Анна Петрова", userImage: UIImage(systemName: "person"), dataCreateNews: "2021-01-01 00:00:00", header: "Большая новость 1", image: UIImage(systemName: "person"), photos: [
            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 1", like: true, countsLike: Int.random(in: 0...100)),
            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 2", like: false, countsLike: Int.random(in: 0...100)),
        ], newsComment: [
            NewsComments(comment: "Комментарий 1", like: true, countsLike: Int.random(in: 0...1000)),
            NewsComments(comment: "Комментарий 2", like: false, countsLike: Int.random(in: 0...1000)),
            NewsComments(comment: "Комментарий 3", like: false, countsLike: Int.random(in: 0...1000)),
        ]),
        News(user: "Оля Иванова", userImage: UIImage(systemName: "person.2"), dataCreateNews: "2021-01-01 00:00:00", header: "Большая новость 2", image: UIImage(systemName: "person"), photos: [
            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 1", like: false, countsLike: Int.random(in: 0...100)),
            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 2", like: true, countsLike: Int.random(in: 0...100)),
        ], newsComment: [
            NewsComments(comment: "Комментарий 1", like: false, countsLike: Int.random(in: 0...1000)),
            NewsComments(comment: "Комментарий 2", like: false, countsLike: Int.random(in: 0...1000)),
            NewsComments(comment: "Комментарий 3", like: true, countsLike: Int.random(in: 0...1000)),
        ]),
        News(user: "Катя Ивановна", userImage: UIImage(systemName: "person"), dataCreateNews: "2021-01-01 00:00:00", header: "Большая новость 3", image: UIImage(systemName: "person"), photos: [
            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 1", like: false, countsLike: Int.random(in: 0...100)),
            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 2", like: true, countsLike: Int.random(in: 0...100)),
            NewsPhotos(image: UIImage(systemName: "person"), description: "Описание к фото 3", like: false, countsLike: Int.random(in: 0...100)),
        ], newsComment: [
            NewsComments(comment: "Комментарий 1", like: false, countsLike: Int.random(in: 0...1000)),
            NewsComments(comment: "Комментарий 2", like: true, countsLike: Int.random(in: 0...1000)),
            NewsComments(comment: "Комментарий 3", like: false, countsLike: Int.random(in: 0...1000)),
        ]),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: NewsRichXIBCell.nibName, bundle: nil), forCellReuseIdentifier: NewsRichXIBCell.reuseIdentifier)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsRichXIBCell.reuseIdentifier, for: indexPath) as? NewsRichXIBCell else {return UITableViewCell()}

        cell.configure(with: news[indexPath.row])

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
