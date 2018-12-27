//
//  URLSessionAdaptor.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/24/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import Alamofire

typealias serviceCompletion = ((_ response: [String:Any]?, _ error: Error?) -> Void)

class ServiceManager: NSObject {
    private let manager = Session().manager
    
    public func APICall(_ url: URLRequestConvertible, on completion: @escaping serviceCompletion) {
        self.manager.request(url).validate(statusCode: 200...300).responseJSON { (response) in
            switch response.result {
                case .success(_):
                    completion(response.result.value as? [String : Any], nil)
                case .failure(let error):
                        completion(nil, error)
            }
        }
    }
    
    public func stopSession() {
        self.manager.session.getAllTasks { (task) in
            task.forEach({ $0.cancel() })
        }
    }
}

class Session: SessionManager {
    lazy var manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        if #available(iOS 11, *) {
            configuration.waitsForConnectivity = true
        }
        return SessionManager(configuration: configuration)
    }()
}
