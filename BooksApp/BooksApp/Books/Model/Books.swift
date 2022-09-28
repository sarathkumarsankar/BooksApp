//
//  Home.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import Foundation

struct Books: Decodable {
    let books: [Book]?
}

struct Book: Decodable {
    let bookId: String?
    let bookName: String?
    let publishedDate: String?
    let author: String?
    let description: String?
    let image: String?
    
    private enum CodingKeys : String, CodingKey {
        case bookId = "book_id"
        case bookName = "book_name"
        case publishedDate = "published_date"
        case author
        case description
        case image
    }
}
