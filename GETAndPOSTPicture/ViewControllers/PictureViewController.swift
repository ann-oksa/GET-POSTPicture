//
//  PictureViewController.swift
//  GETAndPOSTPicture
//
//  Created by Anna Oksanichenko on 23.11.2020.
//

import UIKit

class PictureViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ActivityIndicator.isHidden = true
        ActivityIndicator.hidesWhenStopped = true
        ActivityIndicator.startAnimating()
        fetch()
    }
    

    func fetch() {
        
        guard let url = URL(string: "https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg") else { return }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.ActivityIndicator.stopAnimating()
                    self.imageView.image = image
                }
                
            }
        }
        task.resume()
    }

}
