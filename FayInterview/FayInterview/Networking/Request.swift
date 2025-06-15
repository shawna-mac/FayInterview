//
//  Request.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import Foundation

public struct Request {

    public enum HttpRequest: String {
        case get = "GET"
        case post = "POST"
    }

    struct EmptyBody: Encodable {}

    public static func performRequest<T: Sendable>(
        _ responseType: T.Type = T.self,
        endpoint: String,
        method: HttpRequest = .get
    ) async throws -> T where T: Decodable {
        return try await performRequest(responseType, endpoint: endpoint, method: method, body: nil as EmptyBody?)
    }

    /// Makes the network request
    /// - Parameters:
    ///     - type: Generic object to return after decode
    ///     - endpoint: Location to retrieve requested data
    ///     - method: Type of requested data retrieval
    /// - Returns:
    ///     - object: Decoded object
    public static func performRequest<T: Decodable & Sendable, Body: Encodable>(
        _ : T.Type = T.self,
        endpoint: String,
        method: HttpRequest = .get,
        body: Body? = nil
    ) async throws -> T where T: Decodable {

        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        if let token = KeychainHelper.get(forKey: "jwt_token") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(body)
        }

        let (data, response) = try await URLSession(configuration: .default).data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let items = try decoder.decode(T.self, from: data)
        if let httpResponse = response as? HTTPURLResponse {
            // Token is most likely expired. I would prefer a way to refresh the token, but that doesn't exist so catching
            // through 401 for now
            if httpResponse.statusCode == 401 {
                // as the app explodes in size, we don't want to send back an error where we would have to have repeat code
                AppCoordinator.shared.handle401()
            }
        }

        return items
    }
}
