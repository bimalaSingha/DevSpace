//
//  HomeViewController.swift
//  DevSpace
//
//  Created by K Bimala Singha on 04/02/26.
//


import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // dummy data for now ---- later will use API
//    let categories = [
//        LanguageCategory(title: "Swift", repos: [
//            Repository(name: "Alamofire", ownerName: "Alamofire",
//                       description: "Elegant Networking"),
//            Repository(name: "SnapKit", ownerName: "SnapKit",
//                       description: "Autolayout"),
//            Repository(name: "Kingfisher", ownerName: "onevcat",
//                       description: "Image Downloading & Caching"),
//            Repository(name: "RxSwift", ownerName: "ReactiveX",
//                       description: "Reactive Programming in Swift"),
//            Repository(name: "SwiftLint", ownerName: "realm",
//                       description: "Swift Style and Conventions")
//        ]),
//        
//        LanguageCategory(title: "JavaScript", repos: [
//            Repository(name: "React", ownerName: "facebook",
//                       description: "UI Library"),
//            Repository(name: "Vue", ownerName: "vuejs",
//                       description: "Progressive Framework"),
//            Repository(name: "Node", ownerName: "nodejs",
//                       description: "JavaScript Runtime")
//        ]),
//
//        LanguageCategory(title: "Python", repos: [
//            Repository(name: "Django", ownerName: "django",
//                       description: "Web Framework"),
//            Repository(name: "Flask", ownerName: "pallets",
//                       description: "Lightweight Web Framework"),
//            Repository(name: "NumPy", ownerName: "numpy",
//                       description: "Numerical Computing")
//        ]),
//
//        LanguageCategory(title: "Java", repos: [
//            Repository(name: "Spring Boot", ownerName: "spring-projects",
//                       description: "Java Application Framework"),
//            Repository(name: "Hibernate", ownerName: "hibernate",
//                       description: "ORM Framework"),
//            Repository(name: "JUnit", ownerName: "junit-team",
//                       description: "Testing Framework")
//        ]),
//    ]

    var categories: [LanguageCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.backgroundColor = .black
        view.backgroundColor = .black
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData()
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        // Use the data which already defined in the categories
        let category = categories[indexPath.row]
        cell.categoryLabel.text = category.title // Set the title
        cell.repos = category.repos             // Pass the repos to the collection view
        
        cell.delegate = self  //telss the cell that the viewcontroller is its delegate
        
        
        return cell
    }
    
    
    func fetchData() {
        let languages = ["Swift", "Python", "JavaScript", "Java"]
        
        for language in languages {
            GitHubService.shared.fetchRepositories(for: language) { [weak self] downloadedRepos in
                
                DispatchQueue.main.async {
                    var repos: [Repository] = []
                    if downloadedRepos.count < 5 {
                        repos = downloadedRepos
                    } else {
                        repos.append(contentsOf: downloadedRepos[0...5])
                    }
                    let newCategory = LanguageCategory(title: language, repos: repos)
                    
                    self?.categories.append(newCategory)
                    self?.tableView.reloadData() // This wakes up the black screen!
                    print("Successfully loaded \(downloadedRepos.count) repos!")
                }
            }
        }
    }
    
}

extension HomeViewController: CategoryTableViewCellDelegate {
    func didSelectRepository(_ repo: Repository, iconUrl: String, language: String) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailVC.selectedRepo = repo
            detailVC.iconUrl = iconUrl
            detailVC.language = language
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
