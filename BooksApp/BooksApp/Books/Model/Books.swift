//
//  Home.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import Foundation

struct Books: Decodable {
    let bookId: String?
    let bookName: String?
    let text: String?
    let image: String?
    
    private enum CodingKeys : String, CodingKey {
        case bookId = "book_id"
        case bookName = "book_name"
        case text
        case image
    }
}
