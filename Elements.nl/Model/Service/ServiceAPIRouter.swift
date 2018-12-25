//
//  ServiceAPIRouter.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/25/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import Alamofire

protocol ServiceAPIRouter: URLRequestConvertible {
    var hostURL: String! { get }
    var method: HTTPMethod? { get }
    var path: String {get }
    var params: Parameters? { get }
    func asURLRequest() throws -> URLRequest
}

extension ServiceAPIRouter {
    var hostURL: String! {
        return "https://api.github.com/search/"
    }
    
    func asURLRequest() throws -> URLRequest {
        if let url = URL(string: self.hostURL.appending(self.path)) {
            var request = URLRequest(url: url)
            request.httpMethod = method?.rawValue
            request.setValue("application/vnd.github.mercy-preview+json", forHTTPHeaderField: "Accept")
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.setValue("hassaniiii", forHTTPHeaderField: "User-Agent")
            request = try URLEncoding.queryString.encode(request, with: self.params)
            
            return request
        }
        return URLRequest(url: URL(string: "http://google.com")!)
    }
}
