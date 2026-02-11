//
//  DetailViewController.swift
//  DevSpace
//
//  Created by K Bimala Singha on 04/02/26.
//


import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    // added to catch the data
    var selectedRepo: Repository?
    var iconUrl: String?
    var language: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background
        view.backgroundColor = .black
                
        // Configure labels
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0 // Allow multiple lines
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
                
        // Configure image view
        detailImageView.contentMode = .scaleAspectFit
        detailImageView.backgroundColor = .clear
        detailImageView.tintColor = .white
        
        // Populate the UI with the selected repo's data
        if let repo = selectedRepo {
            self.title = repo.name
            descriptionLabel.text = repo.description ?? "No description available."
            // detailImageView.image = ...
            
            if let iconUrl = iconUrl, !iconUrl.isEmpty {
                            loadImage(from: iconUrl)
                        } else {
                            loadImage(from: repo.owner.avatarUrl)
                        }
        }
        
    }
    
    func loadImage(from urlString: String) {
            guard let url = URL(string: urlString) else {
                return
            }
            
            print("Loading detail image from: \(urlString)")
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let error = error {
                    print("Image load error: \(error)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.detailImageView.image = image
                        print("Detail image loaded")
                    }
                }
            }.resume()
        }

    
    @IBAction func viewOnGotHubTapped(_ sender: UIButton) {

        // Assuming your Repository model has an 'html_url' property from GitHub
        if let urlString = selectedRepo?.html_url, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

