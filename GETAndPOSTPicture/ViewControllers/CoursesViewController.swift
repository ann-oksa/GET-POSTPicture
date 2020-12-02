//
//  CoursesViewController.swift
//  GETAndPOSTPicture
//
//  Created by Anna Oksanichenko on 23.11.2020.
//

import UIKit

class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("cell")
        return courses.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
           configureCell(with: cell, indexPath: indexPath )
           return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var courses = [CourseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        
        
        tableView.delegate = self
        tableView.dataSource = self
//        let nib = UINib(nibName: "CustomCell", bundle: nil)
//        self.tableView.register(nib, forCellReuseIdentifier: "CustomCell")
       tableView.register(TableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
    }
        
    
    
    func fetchData() {
        
        let urlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
         guard let url = URL(string: urlString) else { return  }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                self.courses = try JSONDecoder().decode([CourseModel].self, from: data)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(self.courses)
            } catch  let error {
                    print("Some error", error)
                }
            
        }
        
        task.resume()
    }

    private func configureCell(with cell: TableViewCell, indexPath: IndexPath) {
        let course = courses[indexPath.row]
        
        cell.courseName.text = "ha"
        
        if let numberOfLessons = course.numberOfLessons {
            cell.numberOfLessons.text = "Number of lessons: \(numberOfLessons)"
        }
        
        if let numberOfTests = course.numberOfTests {
            cell.numberOfTests.text = "Number of tests: \(numberOfTests)"
        }
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: course.imageUrl!) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: imageData)
 
            }
        }
        
    }
    
    

}



