//
//  TableViewCell.swift
//  WhiteAndFluffyTest
//
//  Created by Дмитрий Мартынов on 29.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    //MARK: - Properties
    static let cellIdentifire = "cellIdentifire"
    
    private lazy var photoImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue", size: 24)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        func addSubviews() {
            contentView.addSubview(photoImageView)
            contentView.addSubview(authorLabel)
        }
        
        func makeConstraints() {
            photoImageView.translatesAutoresizingMaskIntoConstraints = false
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            photoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            photoImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width/2).isActive = true
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
            
            authorLabel.translatesAutoresizingMaskIntoConstraints = false
            authorLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16).isActive = true
            authorLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }
        
        addSubviews()
        makeConstraints()
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with viewModel: ViewModel) {
        photoImageView.image = viewModel.photo
        authorLabel.text = viewModel.author
    }
}

extension TableViewCell {
    struct ViewModel {
        var photo: UIImage
        var author: String
    }
}
