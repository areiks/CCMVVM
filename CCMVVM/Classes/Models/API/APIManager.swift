//
//  APIManager.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 08.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//
import Alamofire

typealias apiResponseHandler = (_ responseObject: Any?, _ error: NSError?) -> (Void)
typealias successHandler = (Any?) -> Void
typealias failureHandler = (NSError?) -> Void

final class APIManager: NSObject {
    
    // MARK: - Properties
    
    static let sharedInstance = APIManager()
    
    // MARK: - Private methods
    
    private func send(wrappedRequest: RequestWrapper, success: successHandler?, failure: failureHandler?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let request = Alamofire.request(wrappedRequest.path,
                                        method: wrappedRequest.method,
                                        parameters: wrappedRequest.parameters,
                                        encoding: wrappedRequest.encoding,
                                        headers: wrappedRequest.headers).validate().responseJSON { (response) in
                                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                            switch response.result {
                                            case .success(let JSONdata):
                                                success?(JSONdata)
                                            case .failure(let genericError):
                                                failure?(genericError as NSError)
                                            }
        }
        print("\n==============\n")
        debugPrint(request)
        print("\n==============")
    }
    
    // MARK: - Public methods
    
    /// Cancels all current API calls.
    func cancel() {
        Alamofire.SessionManager.default.session.getAllTasks { tasks in
            tasks.forEach( {$0.cancel()} )
        }
    }
    
    /// get new random users list
    func getNewRandomUsers(completion: apiResponseHandler?) {
        let wrappedRequest = RequestWrapper.randomUsers
        send(wrappedRequest: wrappedRequest,
             success: { (responseObject) in
                completion?(responseObject, nil)
        }, failure: { (error) in
            completion?(nil, error)
        })
    }
    
}
