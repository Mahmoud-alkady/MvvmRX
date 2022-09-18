//
//  APIRouter.swift
//  TestRX
//
//  Created by Mahmoud Alkady on 13/09/2022.
//


import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // The endpoint name
    case getPosts
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getPosts:
            return [Constants.Parameters.key : Constants.Parameters.keyValue,
                    Constants.Parameters.q : Constants.Parameters.qValue,
                    Constants.Parameters.imageType : Constants.Parameters.imageTypeValue]
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getPosts:
            return ""
        }
    }
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
            
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
//        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
}
