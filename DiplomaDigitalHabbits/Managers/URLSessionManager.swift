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
        $0.keyDecodingStrategy = .convertFromSnakeCase
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

    func requestWithEndPoint(endPoint: EndPoint, completion: @escaping (PriceHandler) -> Void) {
        guard let url = endPoint.components.url else {
            completion(.failure(.unknown))
            return
        }
        let request = URLRequest(url: url)
        let handler: Handler = { rawData, response, error in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                self.stockResponse = try self.decoder.decode(TradingModel.self, from: data)
                print("<--------------")
                print(response?.url ?? "")
                if self.stockResponse?.status == "error"{
                    DispatchQueue.main.async {
                        completion(.failure(.runOutOfRequest))
                    }
                }
                DispatchQueue.main.async {
                    completion(.success(self.stockResponse))
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure((error as? NetworkServiceError) ?? .unknown))
                }
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
    
    func process (endPoint: EndPoint, completion: @escaping (LogoHandler) -> Void) {
        guard let url = endPoint.components.url else {
            completion(.failure(.unknown))
            return
        }
        let request = URLRequest(url: url)
        let handler: Handler = { rawData, response, error in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                let dopUrl = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                if dopUrl?["status"] as? String ?? "" == "error" {
                    completion(.failure(.network))
                }
                
                let logoEntity = LogoModel(from: dopUrl ?? [:])
                guard let url = URL(string: logoEntity.url ?? "") else {
                    completion(.failure(.network))
                    return
                }
             
                self.processDataLogo(url: url) { result in
                    switch result {
                    case .success(let data):
                        logoEntity.data = data
                        DispatchQueue.main.async {
                            completion(.success(logoEntity))
                        }
                    case .failure(let err):
                        completion(.failure(err))
                    }
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure((error as? NetworkServiceError) ?? .unknown))
                }
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }

    private func processDataLogo(url: URL, completion: @escaping (Result<Data, NetworkServiceError>) -> Void) {
        let request = URLRequest(url: url)
        let handler: Handler = { rawData, response, error in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                completion(.success(data))
            } catch {
                print(error)
                completion(.failure(.decodable))
            }
        }
        session.dataTask(with: request, completionHandler: handler).resume()
    }
}
