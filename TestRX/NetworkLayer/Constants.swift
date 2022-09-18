//
//  Constants.swift
//  TestRX
//
//  Created by Mahmoud Alkady on 13/09/2022.
//

import Foundation
struct Constants {
    
    // The API's base URL
    static let baseUrl = "https://pixabay.com/api"
    
    // The parameters (Queries)
    struct Parameters {
        static let key = "key"
        static let q = "q"
        static let imageType = "image_type"
        
        static let keyValue = "11778875-bd18dbcb72c8cc6ad02f06b46"
        static let qValue = "animal+love"
        static let imageTypeValue = "photo"
    }
    
    // The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    // The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}
