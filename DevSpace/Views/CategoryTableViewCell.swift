
//
//  CategoryTableViewCell.swift
//  DevSpace
//
//  Created by K Bimala Singha on 04/02/26.
//

import Foundation
import UIKit


protocol CategoryTableViewCellDelegate: AnyObject {
    func didSelectRepository(_ repo: Repository, iconUrl: String, language: String)
}


class CategoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var delegate: CategoryTableViewCellDelegate?
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var repos: [Repository] = []
    {
        didSet {
            collectionView.reloadData()
            print("Repos count: \(repos.count)")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //table view cell background
        backgroundColor = .black
        contentView.backgroundColor = .black
        
        //label style
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = .clear
        categoryLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        //layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        
        //collection view ----- register programmatic cell - posterImage
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RepoCollectionViewCell.self, forCellWithReuseIdentifier: "RepoCell")   // Register programmatic cell class
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepoCell", for: indexPath) as! RepoCollectionViewCell
        
        let repo = repos[indexPath.item]
        
        // text from label to tell the Mapper which language icons to pick
        // using a fallback just in case the label is empty
        let language = categoryLabel.text ?? ""
        let iconUrl = IconMapper.getIconUrl(for: repo.name)
        
        let fallbackUrl = repo.owner.avatarUrl
        
        cell.configure(with: repo, customIconUrl: iconUrl, fallbackUrl: fallbackUrl)
        return cell
    }
    
    
    //// Protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRepo = repos[indexPath.item]
        let language = categoryLabel.text ?? ""
        let iconUrl = IconMapper.getIconUrl(for: selectedRepo.name)
        
        delegate?.didSelectRepository(selectedRepo, iconUrl: iconUrl, language: language)
    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 200)
    }
}
