//
//  ViewController.swift
//  GETAndPOSTPicture
//
//  Created by Anna Oksanichenko on 23.11.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func downloadButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toPictureVC", sender: nil)
        
    }
    
    
    @IBAction func coursesButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toCoursesVC", sender: nil)
    }
    
    
    @IBAction func getButton(_ sender: UIButton) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let session = URLSession.shared
        let newSession = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let response = response,
                  let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
               print("get")
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let userData = ["Course" : "GET and POST Lesson", "Lesson" : "Networking"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let session = URLSession.shared
       let task = session.dataTask(with: request) { (data, response, error) in
            guard let response = response,
                  let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("post")
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

