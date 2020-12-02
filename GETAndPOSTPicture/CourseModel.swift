//
//  CourseModel.swift
//  GETAndPOSTPicture
//
//  Created by Anna Oksanichenko on 24.11.2020.
//

import Foundation

struct CourseModel: Codable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case link
        case imageUrl
        case numberOfLessons = "number_of_lessons"
        case numberOfTests = "number_of_tests"
    }
    
}


struct WebsiteDescription: Codable {
    let websiteDescription: String
    let websiteName: String
    let courses: [CourseModel]
}
