//
//  TableViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Дмитрий Мартынов on 29.01.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var favPhotos: [Post] = [
        Post(photo: UIImage(named: "mary")!,
             author: "mary"),
        Post(photo: UIImage(named: "lagut")!,
             author: "lagut"),
        Post(photo: UIImage(named: "tambi")!,
             author: "tambi"),
        Post(photo: UIImage(named: "kama")!,
             author: "kama"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifire)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//       1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return favPhotos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifire, for: indexPath) as! TableViewCell
        let favPhoto = favPhotos[indexPath.row]
        let viewModel = TableViewCell.ViewModel(
            photo: favPhoto.photo,
            author: favPhoto.author)
        
        cell.configure(with: viewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let selectCell = favPhotos[indexPath.row]
            vc.selectedImage = selectCell
            navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }


}
