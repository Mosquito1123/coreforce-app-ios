//
//  NetworkingClient.swift
//  hfpower
//
//  Created by EDY on 2024/4/12.
//

import Moya

final class NetworkingClient {
    public lazy var authentication: MoyaProvider<AuthAPI> = createProvider(forTarget: AuthAPI.self)
    
    private let apiKey: String
    

    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public var hasValidToken: Bool {
        guard let lastTokenDateString = UserDefaults.standard.string(forKey: "accessTokenExpiration") else {return false}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         
        guard let tokenDate = dateFormatter.date(from: lastTokenDateString) else { return false }
        
        let diff = Date().timeIntervalSince1970 - tokenDate.timeIntervalSince1970
        
        // If last token is > 23 hours, we should refresh the token
        return diff < 82800
    }
    
    func createProvider<T: APIType>(forTarget target: T.Type) -> MoyaProvider<T> {
        let endpointClosure = createEndpointClosure(for: target)
        let requestClosure = createRequestClosure(for: target)
        
        let accessTokenPlugin = HFAccessTokenPlugin.init(tokenClosure: { _ in
            UserDefaults.standard.string(forKey: "accessToken") ?? ""
        })
        let loadingPlugin = LoadingPlugin()
                
        return MoyaProvider<T>(endpointClosure: endpointClosure,
                               requestClosure: requestClosure,
                               plugins: [accessTokenPlugin,loadingPlugin])
    }
    
    private func createRequestClosure<T: APIType>(for target: T.Type) -> MoyaProvider<T>.RequestClosure {
        // If we are authenticating, skip all logic to get or refresh token, so we return the default request mapping
        if target is AuthAPI.Type { return MoyaProvider<T>.defaultRequestMapping }
        
        // We are hitting another endpoint, so we should check and refresh the token if necessary.
        // We can't use the default request mapping
        let requestClosure = { [weak self] (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) -> Void in
            self?.checkToken(target: target, endpoint: endpoint, done: done)
        }
        
        return requestClosure
    }
    
    private func createEndpointClosure<T: APIType>(for target: T.Type) -> MoyaProvider<T>.EndpointClosure {
        let endpointClosure = { (target: T) -> Endpoint in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            let headers = ["Content-type": "application/json",
                           "Accept": "application/vnd.thetvdb.v2.1.2"]
            return endpoint.adding(newHTTPHeaderFields: headers)
        }
        
        return endpointClosure
    }
    
    func checkToken<T: APIType>(target: T.Type, endpoint: Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) {
        guard let request = try? endpoint.urlRequest() else {
            done(.failure(MoyaError.requestMapping(endpoint.url)))
            return
        }
        
        
        if hasValidToken {
            done(.success(request)) // We have a valid token, so just let the request proceed
        } else {
            refreshToken(target, request, endpoint, done) // We have a invalid token, we should refresh the token
        }
        
    }
    
    private func refreshToken<T: APIType>(_ target: T.Type,
                                                   _ request: URLRequest,
                                                   _ endpoint: Endpoint,
                                                   _ done: @escaping MoyaProvider<T>.RequestResultClosure) {
        self.authentication.request(.refreshToken(refreshToken: UserDefaults.standard.string(forKey: "refreshToken") ?? "")) { result in
            switch result {
            case .success(let response):
                let jsonResponse: Any
                do {
                    jsonResponse = try response.mapJSON()
                } catch {
                    done(.failure(MoyaError.objectMapping(error, response)))
                    return
                }
                
                guard let json = jsonResponse as? [String: Any] else {
                    done(.failure(MoyaError.jsonMapping(response)))
                    return
                }
                
                guard let jsonBody = json["body"] as? [String:Any] else {
                    done(.failure(MoyaError.jsonMapping(response)))
                    return
                }
                UserDefaults.standard.set(jsonBody["accessToken"], forKey: "accessToken")
                UserDefaults.standard.set(jsonBody["accessTokenExpiration"], forKey: "accessTokenExpiration")
                UserDefaults.standard.set(jsonBody["refreshToken"], forKey: "refreshToken")
                UserDefaults.standard.set(jsonBody["refreshTokenExpiration"], forKey: "refreshTokenExpiration")

                done(.success(request)) // Token refresh success! So we proceed with the original request
            case .failure(let error):
                done(.failure(MoyaError.underlying(error, nil))) // We couldn't refresh the token
            }
        }
    }
    
    
}
