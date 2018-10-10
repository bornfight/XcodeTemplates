//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

protocol NetworkRequestHandler {
    
    var successfulStatusCodes: CountableClosedRange<Int> { get }
    
    var defaultNetworkError: RequestError { get }
    
    func extractedError(data: Data) -> RequestError
    
    func parseJSONArray<T: Decodable>(data: Data) -> Result<[T]>
    
    func parseJSONAsTopLevelArray<T: Decodable>(data: Data, response: HTTPURLResponse) -> Result<[T]>
    
    func parseJSONDictionary<T: Decodable>(data: Data) -> Result<T>
    
    func parseJSONAsTopLevelDictionary<T: Decodable>(data: Data, response: HTTPURLResponse) -> Result<T>
}

protocol Parsable: Decodable {
    static func parse(response: HTTPURLResponse, data: Data) -> Result<Self>
}

extension Array: Parsable where Element: Parsable {
    static func parse(response: HTTPURLResponse, data: Data) -> Result<[Element]> {
        return parser.parseJSONAsTopLevelArray(data: data, response: response)
    }
}

extension Parsable {
    static func parse(response: HTTPURLResponse, data: Data) -> Result<Self> {
        return parser.parseJSONAsTopLevelDictionary(data: data, response: response)
    }
}

class ___VARIABLE_sceneName___ {
    
    private let decoder = JSONDecoder()
    
    let successfulStatusCodes = (200 ... 299)
    let defaultNetworkError = RequestError(message: "Network Error")
    
    func extractedError(data: Data) -> RequestError {
        logJSON(data: data)
        
        if let errors = try? decoder.decode([RequestError].self, from: data), let error = errors.first {
            return error
        }
        if let error = try? decoder.decode(RequestError.self, from: data) {
            return error
        }
        
        return RequestError(message: "Network Error")
    }
    
    func isResponseSuccessful(data: Data, response: HTTPURLResponse) -> Result<Void> {
        if successfulStatusCodes.contains(response.statusCode) {
            return .success(())
        }
        return .failure(extractedError(data: data))
    }
    
    func parseJSONArray<T: Decodable>(data: Data) -> Result<[T]> {
        if let mappedData = try? decoder.decode([T].self, from: data) {
            return .success(mappedData)
        } else {
            return .failure(extractedError(data: data))
        }
    }
    
    func parseJSONAsTopLevelArray<T: Decodable>(data: Data, response: HTTPURLResponse) -> Result<[T]> {
        logJSON(data: data)
        if successfulStatusCodes.contains(response.statusCode) {
            return parseJSONArray(data: data)
        } else {
            return .failure(extractedError(data: data))
        }
    }
    
    func parseJSONDictionary<T: Decodable>(data: Data) -> Result<T> {
        if let mappedData = try? decoder.decode(T.self, from: data) {
            return .success(mappedData)
        } else {
            return .failure(defaultNetworkError)
        }
    }
    
    func parseJSONAsTopLevelDictionary<T: Decodable>(data: Data, response: HTTPURLResponse) -> Result<T> {
        logJSON(data: data)
        if successfulStatusCodes.contains(response.statusCode) {
            return parseJSONDictionary(data: data)
        } else {
            return .failure(extractedError(data: data))
        }
    }
    
    func logJSON(data: Data) {
        //MARK: TODO use a compile time if directive to only log debug builds
        DispatchQueue.global(qos: .background).async {
            if let json = String(data: data, encoding: .utf8) {
                print(json)
            }
        }
    }
    
}
