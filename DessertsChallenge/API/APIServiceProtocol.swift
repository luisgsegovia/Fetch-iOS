//
//  APIServiceProtocol.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func make<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder) -> AnyPublisher<T, Error>
}

extension APIServiceProtocol {
    func make<T>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> where T : Decodable {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
