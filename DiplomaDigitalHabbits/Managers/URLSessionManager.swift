//
//  URLSessionManager.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 22.11.2021.
//

import Foundation

class URLSessionManager {
 
    let session: URLSession = .shared
    private let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .useDefaultKeys
        return $0
    }(JSONDecoder())
    private var stockResponse: TradingModel?
    
    private func httpResponse (data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
                  throw NetworkServiceError.network
              }
        return data
    }
}

extension URLSessionManager: NetworkServiceProtocol {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    func requestPrice(symbol: String, completion: @escaping (PriceHandler) -> Void) {
        // request
        var components = URLComponents(string: Constants.StockRequest.baseURLForStock)
        components?.queryItems = [
            URLQueryItem(name: "symbol", value: symbol),
            URLQueryItem(name: "interval", value: "1min"),
            URLQueryItem(name: "apikey", value: "e4e382a154f846648a9c8c327aa703a6")
        ]
        guard let url = components?.url else {return completion(.failure(.unknown))}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print("-------------------------->")
        print("\(request.httpMethod ?? "") \(url)")
        let handler: Handler = { rawData, response, error in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                self.stockResponse = try self.decoder.decode(TradingModel.self, from: data)
                print("<--------------")
                print(response?.url)
                print(data)
            } catch {
                completion(.failure((error as? NetworkServiceError) ?? .unknown))
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
}
