//
//  DetailViewController.swift
//  WhiteAndFluffyTest
//
//  Created by Дмитрий Мартынов on 29.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
    static let detailIdentifire = "detailIdentifire"
    
    var selectedImage: Post?
    var authorsName: String?
    var date: Date?
    var location: String?
    var downloads: Int?
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo by: \("authorsName")"
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of shoot: \("date")"
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location of shoot: \("location")"
        return label
    }()
    private let downloadsLabel: UILabel = {
        let label = UILabel()
        label.text = "Downloads: \("downloads")"
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorLabel,
                                                       dateLabel,
                                                       locationLabel,
                                                       downloadsLabel
                                                      ])
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveToFav))
        
        if let imageToLoad = selectedImage?.photo {
            imageView.image = imageToLoad
        }
        
        func addSubviews() {
            view.addSubview(imageView)
            view.addSubview(labelStackView)
        }
        
        func makeCostraints() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            
            labelStackView.translatesAutoresizingMaskIntoConstraints = false
            labelStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            labelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            labelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        
        addSubviews()
        makeCostraints()
    }
    
    @objc func saveToFav() {
        let ac = UIAlertController(title: "Save to favourite", message: "Do you want to save or delete this photo to your favorite photos?", preferredStyle: .alert)
        
        let acAction1 = UIAlertAction(title: "Save", style: .default) { [self] (action1) in
            guard let newItem = selectedImage else { return }
            
            TableViewController().favPhotos.append(newItem)
            
            TableViewController().tableView.reloadData()
            print(TableViewController().favPhotos)
        }
        
        let acAction2 = UIAlertAction(title: "Delete", style: .destructive) { _ in
            
            TableViewController().favPhotos.remove(at: TableViewController().tableView.indexPath(for: TableViewCell())!.row)
            TableViewController().tableView.reloadData()
            print(TableViewController().favPhotos)
        }
        
        let acAction3 = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(acAction1)
        ac.addAction(acAction2)
        ac.addAction(acAction3)
        
        present(ac, animated: true)
    }
}

