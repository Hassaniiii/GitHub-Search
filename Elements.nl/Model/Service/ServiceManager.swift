//
//  URLSessionAdaptor.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/24/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import Alamofire
import netfox

typealias serviceCompletion = ((_ response: [String:Any]?, _ error: Error?) -> Void)

class ServiceManager: NSObject {
    private let manager = Session().manager
    
    public func APICall(_ url: URLRequestConvertible, on completion: @escaping serviceCompletion) {
        print(url)
        self.manager.request(url).responseJSON { (response) in
            switch response.result {
                case .success(_):
                    completion(response.result.value as? [String : Any], nil)
                case .failure(let error):
                        completion(nil, error)
            }
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
