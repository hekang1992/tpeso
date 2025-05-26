//
//  NetworkRequest.swift
//  Tpeso
//
//  Created by tom on 2025/5/22.
//

import Alamofire
import Combine
import UIKit
import KRProgressHUD

let API_URL = "http://8.212.151.134:10193/tpesoapi"

enum ContentType: String {
    case json = "application/json"
    case formUrlEncoded = "application/x-www-form-urlencoded"
    case multipartFormData = "multipart/form-data"
}

final class NetworkRequest {
    private let session: Session
    private let dictionary: [String: String]
    
    init(session: Session = Session.default) {
        self.session = session
        self.dictionary = DeviceInfo.toDictionary()
    }
    // MARK: - GET
    func getRequest(url: String,
                    parameters: [String: Any]? = nil,
                    contentType: ContentType? = nil) -> AnyPublisher<Data, Error> {
        return Future { promise in
            var headers: HTTPHeaders = [:]
            if let contentType = contentType {
                headers.add(name: "Content-Type", value: contentType.rawValue)
            }
            let apiUrl = URLQueryAppender.appendQueryParameters(to: API_URL + url, parameters: self.dictionary)!
            self.session.request(apiUrl, method: .get, parameters: parameters, headers: headers)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - POST
    func postRequest(url: String,
                     parameters: [String: Any]? = nil,
                     contentType: ContentType? = nil)
    -> AnyPublisher<Data, Error> {
        return Future { promise in
            var headers: HTTPHeaders = [:]
            if let contentType = contentType {
                headers.add(name: "Content-Type", value: contentType.rawValue)
            }
            let apiUrl = URLQueryAppender.appendQueryParameters(to: API_URL + url, parameters: self.dictionary)!
            self.session.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    func requsetData(url: String,
                     parameters: [String: String]? = nil,
                     contentType: ContentType? = nil)
    -> AnyPublisher<Data, Error> {
        return Future { promise in
            var headers: HTTPHeaders = [:]
            if let contentType = contentType {
                headers.add(name: "Content-Type", value: contentType.rawValue)
            }
            let apiUrl = URLQueryAppender.appendQueryParameters(to: API_URL + url, parameters: self.dictionary)!
            self.session.upload(multipartFormData: { multipartFormData in
                if let parameters = parameters {
                    for (key, value) in parameters {
                        multipartFormData.append(Data(value.utf8), withName: key)
                    }
                }
            }, to: apiUrl, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    promise(.success(data))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}

final class URLQueryAppender {
    
    static func appendQueryParameters(to url: String, parameters: [String: String]) -> String? {
        guard var urlComponents = URLComponents(string: url) else {
            return nil
        }
        
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        
        return urlComponents.url?.absoluteString
    }
}

class ToastConfig {
    static func showMessage(form view: UIView, message: String) {
        KRProgressHUD.showMessage(message)
    }
}
