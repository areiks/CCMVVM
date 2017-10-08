//
//  RequestWrapper.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 08.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import Foundation
import Alamofire

enum RequestWrapper {
    case randomUsers
    
    // MARK: - Properties
    private static let baseURL = "https://randomuser.me/api/"
    private static let randomUsersURL = ""
    
    /// Complete URL path.
    var path: String {
        var component: String!
        switch self {
        case .randomUsers:
            component = RequestWrapper.randomUsersURL
        }
        return RequestWrapper.baseURL + component
    }
    
    /// HTTP method.
    var method: HTTPMethod {
        switch self {
        case .randomUsers:
            return .get
        }
    }
    
    /// A dictionary containing additional request parameters.
    var parameters: [String : String]? {
        switch self {
        case .randomUsers:
            return ["results" : "100"]
        }
    }
    
    /// Prameters encoding type.
    var encoding: ParameterEncoding {
        switch self {
        case .randomUsers:
            return URLEncoding.default
        /*default:
            return JSONEncoding.default*/
        }
    }
    
    /// Request headers
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type" : "application/json"]
        }
    }

}
