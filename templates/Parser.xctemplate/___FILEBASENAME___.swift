//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

fileprivate let parseHandler = ParseHandler()
fileprivate let successfulStatusCodes = (200 ... 299)
fileprivate let defaultParsingError = RequestError(message: "Parsing Error")

protocol NetworkRequestHandler {
    func extractedError(data: Data) -> RequestError
    
    func parseJSONArray<T: Decodable>(data: Data) -> Result<[T]>
    
    func parseJSONAsTopLevelArray<T: Decodable>(data: Data, response: HTTPURLResponse) -> Result<[T]>
    
    func parseJSONDictionary<T: Decodable>(data: Data) -> Result<T>
    
    func parseJSONAsTopLevelDictionary<T: Decodable>(data: Data, response: HTTPURLResponse) -> Result<T>
}

protocol ResponseParsable {
    func parse<T: Parsable>(_ object: T.Type) -> ((HTTPURLResponse, Data) -> Result<T>)
    
    func parse<T: Parsable>(_ object: T.Type) -> ((DataResponse<Data>) -> Result<T>)
    
    func checkStatusCodeOK() -> ((HTTPURLResponse, Data) -> Result<Void>)
    
    func checkStatusCodeOK() -> ((DataResponse<Data>) -> Result<Void>)
}

protocol Parsable: Decodable {
    static func parse(response: HTTPURLResponse, data: Data) -> Result<Self>
}

class ___VARIABLE_sceneName___: ResponseParsable {
    
    func parse<T: Parsable>(_ object: T.Type) -> ((HTTPURLResponse, Data) -> Result<T>) {
        return T.parse
    }
    
    func parse<T: Parsable>(_ object: T.Type) -> ((DataResponse<Data>) -> Result<T>) {
        return parseDataResponse
    }
    
    func checkStatusCodeOK() -> ((HTTPURLResponse, Data) -> Result<Void>) {
        return checkStatusCode
    }
    
    func checkStatusCodeOK() -> ((DataResponse<Data>) -> Result<Void>) {
        return checkStatusCode
    }
    
    private func parseDataResponse<T: Parsable>(response: DataResponse<Data>) -> Result<T> {
        guard let httpResponse = response.response, let data = response.data else {
            return .failure(defaultParsingError)
        }
        
        return T.parse(response: httpResponse, data: data)
    }
    
    private func checkStatusCode(response: HTTPURLResponse, data: Data) -> Result<Void> {
        if successfulStatusCodes.contains(response.statusCode) {
            return .success(())
        } else {
            return .failure(defaultParsingError)
        }
    }
    
    private func checkStatusCode(response: DataResponse<Data>) -> Result<Void> {
        if let statusCode = response.response?.statusCode, successfulStatusCodes.contains(statusCode) {
            return .success(())
        } else {
            return .failure(defaultParsingError)
        }
    }
}

extension Array: Parsable where Element: Parsable {
    static func parse(response: HTTPURLResponse, data: Data) -> Result<[Element]> {
        return parseHandler.parseJSONAsTopLevelArray(data: data, response: response)
    }
}

extension Parsable {
    static func parse(response: HTTPURLResponse, data: Data) -> Result<Self> {
        return parseHandler.parseJSONAsTopLevelDictionary(data: data, response: response)
    }
}

class ParseHandler: NetworkRequestHandler {
    
    private let decoder = JSONDecoder()
    
    func extractedError(data: Data) -> RequestError {
        logJSON(data: data)
        
        if let errors = try? decoder.decode([RequestError].self, from: data), let error = errors.first {
            return error
        }
        if let error = try? decoder.decode(RequestError.self, from: data) {
            return error
        }
        
        return defaultParsingError
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
            return .failure(defaultParsingError)
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
