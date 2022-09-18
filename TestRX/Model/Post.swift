//
//  Post.swift
//  TestRX
//
//  Created by Mahmoud Alkady on 13/09/2022.
//

import Foundation

struct Post: Codable {
    var user: String = ""
    var likes: Int = 0
    var tags: String = ""
    var userImageURL: String = ""
    var largeImageURL: String = ""
    
    func getImageURL() -> URL {
        return URL(string: largeImageURL) ?? URL(fileURLWithPath: "")
    }
    
    func getUserImageURL() -> URL {
        return URL(string: userImageURL) ?? URL(fileURLWithPath: "")
    }
    
    func getTags() -> String {
        var result = ""
        for tag in tags.split(separator: ",") {
            var newTag = "#" + tag.trimmingCharacters(in: .whitespaces)
            newTag = newTag.replacingOccurrences(of: " ", with: "_")
            result += newTag + " "
        }
        return result.trimmingCharacters(in: .whitespaces)
    }
}
