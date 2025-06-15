//
//  Endpoints.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

struct Endpoints {

    private static let baseURL = "https://node-api-for-candidates.onrender.com"

    // Each struct corelates to the microservice 
    struct AppointmentsService {
        public static let appointments = "\(baseURL)/appointments"
    }

    struct AuthService {
        public static let signin = "\(baseURL)/signin"
    }
}
