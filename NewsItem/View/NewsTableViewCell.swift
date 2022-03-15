//
//  NewsTableViewCell.swift
//  NewsItem
//
//  Created by Garima Ashish Bisht on 13/03/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.textColor = UIColor.black
        titleLabel.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.sizeToFit()
        return titleLabel
    }()
    
    var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .left
        descLabel.font = UIFont.systemFont(ofSize: 14.0)
        descLabel.textColor = UIColor.black
        descLabel.backgroundColor = .clear
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        return descLabel
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = UIColor.white
        return stackView
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       // setup()
    }
    
    private func setup() {
        contentView.backgroundColor = .white
        stackView.addArrangedSubview(newsImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descLabel)
        stackView.addArrangedSubview(activityIndicatorView)
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView.heightAnchor.constraint(equalToConstant: self.frame.height - 100).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10.0).isActive = true

        newsImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0.0).isActive = true
        newsImageView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive = true
        newsImageView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5.0).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60.0).isActive = true
        descLabel.topAnchor.constraint(lessThanOrEqualTo:titleLabel.bottomAnchor, constant: 5.0).isActive = true
        descLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5.0).isActive = true
        descLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5.0).isActive = true
        descLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 90.0).isActive = true
        descLabel.bottomAnchor.constraint(equalTo:stackView.bottomAnchor, constant: 2.0).isActive = true
    }
    
    func configure(with dataModel: NewsDataModel) {
        
        guard newsImageView.image == nil else {
            return
        }
        activityIndicatorView.startAnimating()
    
        if let url = URL(string: dataModel.url ?? "") {
            DispatchQueue.main.async {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                self.activityIndicatorView.stopAnimating()
                    self.newsImageView.image = UIImage(data: imageData)?.resizedImage(with: CGSize(width: self.frame.size.width, height: 200))
                self.titleLabel.text = dataModel.title
                self.descLabel.text = dataModel.detail
              }
            }
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        titleLabel.text = nil
        descLabel.text = nil
    }
    
    
}
