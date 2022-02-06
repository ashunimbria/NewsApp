//
//  NetworkManager.swift
//  News
//
//  Created by Ashish Nimbria on 2/5/22.
//

import Foundation

final class HTTPManager{
    
    static let shared = HTTPManager()
    public var authenticationToken : String? = nil
    public var customJsonDecoder : JSONDecoder? = nil
    
    private init(){}
    
    public func request<T: Decodable>(request: HTTPRequest, resultType: T.Type, completion:@escaping(Result<T?, HTTPError>) -> Void){
        
        switch request.method{
            
        case .get:
            getData(requestUrl: request.url, resultType: resultType) { completion($0)}
            break
        case .post:
            //code for post api
            break
        case .put:
            //code for put api
            break
        case .delete:
            //code for delete api
            break
        }
        
    }
    
    private func createJsonDecoder() -> JSONDecoder
    {
        let decoder =  customJsonDecoder != nil ? customJsonDecoder! : JSONDecoder()
        if(customJsonDecoder == nil) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    private func createUrlRequest(requestUrl: URL) -> URLRequest
    {
        var urlRequest = URLRequest(url: requestUrl)
        if(authenticationToken != nil) {
            urlRequest.setValue(authenticationToken!, forHTTPHeaderField: "authorization")
        }
        
        return urlRequest
    }
    
    private func decodeJsonResponse<T: Decodable>(data: Data, responseType: T.Type) -> T?
    {
        let decoder = createJsonDecoder()
        do {
            return try decoder.decode(responseType, from: data)
        }catch let error {
            debugPrint("deocding error =>\(error.localizedDescription)")
        }
        return nil
    }
    
    // MARK: - GET Api
    private func getData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(Result<T?, HTTPError>)-> Void)
    {
        var urlRequest = self.createUrlRequest(requestUrl: requestUrl)
        urlRequest.httpMethod = HTTPMethods.get.rawValue
        
        performOperation(requestUrl: urlRequest, responseType: T.self) { (result) in
            completionHandler(result)
        }
    }
    
    // MARK: - Perform data task
    private func performOperation<T: Decodable>(requestUrl: URLRequest, responseType: T.Type, completionHandler:@escaping(Result<T?, HTTPError>) -> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (data, httpUrlResponse, error) in
            
            let statusCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode
            if(error == nil && data != nil && data?.count != 0) {
                let response = self.decodeJsonResponse(data: data!, responseType: responseType)
                if(response != nil) {
                    completionHandler(.success(response))
                }else {
                    completionHandler(.failure(HTTPError    (withServerResponse: data, forRequestUrl: requestUrl.url!, withHttpBody: requestUrl.httpBody, errorMessage: error.debugDescription, forStatusCode: statusCode!)))
                }
            }
            else {
                let networkError = HTTPError(withServerResponse: data, forRequestUrl: requestUrl.url!, withHttpBody: requestUrl.httpBody, errorMessage: error.debugDescription, forStatusCode: statusCode!)
                completionHandler(.failure(networkError))
            }
            
        }.resume()
    }
    
}
