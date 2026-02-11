//
//  RepoCollectionViewCell.swift
//  DevSpace
//
//  Created by K Bimala Singha on 04/02/26.
//


import UIKit

class RepoCollectionViewCell: UICollectionViewCell {
    
    
    //    @IBOutlet weak var repoImageView: UIImageView!
    
    @IBOutlet weak var repoTitleLabel: UILabel!
    
    
    //    func configure(with repo: Repository) {
    //        repoTitleLabel.text = repo.name
    //        repoImageView.image = UIImage(systemName: "person.circle") // Placeholder icon
    //         posterImageView.backgroundColor = .systemGreen
    //         loadImage(from: repo.owner.avatarUrl)
    //    }
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false  // will set constraints using autolayout APIs
        print("posterImageView is nil", imageView)
        return imageView
    }()
    
    //    Use this initializer for programmatic cells
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgrammaticUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupProgrammaticUI()
    }
    
    
    // called when loading from Storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        setupProgrammaticUI()
    }
    
    private func setupProgrammaticUI() {
        // existing posterImageView to avoid duplicates
        posterImageView.removeFromSuperview()
        
        contentView.addSubview(posterImageView)
        
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 8
    
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            posterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
        ])
        
        
        //label configure
        if let label = repoTitleLabel {
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.numberOfLines = 2
            label.textAlignment = .center
        }
        
    }
    
    // Use this version of configure for your DevIcons
    func configure(with repo: Repository, customIconUrl: String, fallbackUrl: String) {
        repoTitleLabel?.text = repo.name
        
        //reset image
        posterImageView.image = nil
        
        guard let url = URL(string: customIconUrl) else {
            loadFallbackImage(from: fallbackUrl)
            print("invalid URL: \(customIconUrl)")
            return
        }
        print("image for \(repo.name) from \(customIconUrl)")
        
        
     
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Image load error: \(error.localizedDescription)")
                self?.loadFallbackImage(from: fallbackUrl)
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("HTTP error \(httpResponse.statusCode), using fallback")
                self?.loadFallbackImage(from: fallbackUrl)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                    print("Image loaded")
                }
            } else {
                self?.loadFallbackImage(from: fallbackUrl)
            }
        }.resume()
    }
    
    private func loadFallbackImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        print("fallback image from \(urlString)")
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                    print("Fallback image loaded")
                }
            }
        }.resume()
    }
        
        
        override func prepareForReuse() {
            super.prepareForReuse()
            posterImageView.image = nil
            repoTitleLabel?.text = nil
        }
        
}
