//
//  ArticleCell.swift
//  IOS-Final-Assignment
//
//  Created by  on 4/8/21.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    let titleLabel = UITextView()
    let descLabel = UITextView()
    let authorLabel = UILabel()
    let articleImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        titleLabel.isEditable = false
        
        descLabel.textAlignment = .left
        descLabel.font = UIFont.boldSystemFont(ofSize: 12)
        descLabel.backgroundColor = .clear
        descLabel.textColor = .black
        descLabel.sizeToFit()
        descLabel.isEditable = false
        
        authorLabel.textAlignment = .left
        authorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        authorLabel.backgroundColor = .clear
        authorLabel.textColor = .darkGray
        authorLabel.sizeToFit()
        authorLabel.isEnabled = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(articleImageView)
    }
    
    override func layoutSubviews() {
        titleLabel.frame = CGRect(x: 150, y: 5, width: 250, height: 500)
        descLabel.frame = CGRect(x: 150, y: 110, width: 250, height: 500)
        authorLabel.frame = CGRect(x: 300, y: 180, width: 100, height: 100)
        articleImageView.frame = CGRect(x: 5, y: 20, width: 140, height: 140)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
