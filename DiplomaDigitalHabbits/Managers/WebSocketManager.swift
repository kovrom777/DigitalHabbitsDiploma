//
//  WebSocketManager.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 27.10.2021.
//

import Foundation

class WebSocketManager{
    public static let shared = WebSocketManager()
    private init() {}
    let apiKey = "e4e382a154f846648a9c8c327aa703a6"

    private var data: TradingModel?

    let webSocketTask = URLSession(configuration: .default).webSocketTask(with: URL(string: "wss://ws.twelvedata.com/v1/quotes/price?apikey=e4e382a154f846648a9c8c327aa703a6")!)

    public func connectToWebSocket(){
        webSocketTask.resume()
        self.receiveData { _ in}
    }
    
    public func subscribeOnSMTH() {
        let message = URLSessionWebSocketTask.Message.string("{\"action\": \"subscribe\",\"params\": {\"symbols\": \"AAPL,EUR/USD,BTC/USD\"}}")
        webSocketTask.send(message) { error in
            if let error = error {
                print("Failed to send req \(error.localizedDescription)")
            }
        }
    }

    func receiveData(completion: @escaping (TradingModel?) -> Void) {
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    guard let data = text.data(using: .utf8) else {return}
                    let jsonDecoder = try? JSONDecoder().decode(TradingModel.self, from: data)
                    print("Received string: \(text)")
                case .data(let data):
                    print("Received data: \(data)")
                }
            @unknown default:
                debugPrint("Unknown message")
            }
            self.receiveData() {_ in }
        }
    }
}
