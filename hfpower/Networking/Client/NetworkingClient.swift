//
//  NetworkingClient.swift
//  hfpower
//
//  Created by EDY on 2024/4/12.
//

import Moya
import Alamofire
import KakaJSON

final class NetworkingClient {
    public lazy var authentication: MoyaProvider<AuthAPI> = createProvider(forTarget: AuthAPI.self)
    public lazy var business: MoyaProvider<BusinessAPI> = createProvider(forTarget: BusinessAPI.self)
    public lazy var member: MoyaProvider<MemberAPI> = createProvider(forTarget: MemberAPI.self)
    public lazy var packageCard: MoyaProvider<PackageCardAPI> = createProvider(forTarget: PackageCardAPI.self)
    public lazy var batteryDeposit: MoyaProvider<BatteryDepositAPI> = createProvider(forTarget: BatteryDepositAPI.self)

    private let apiKey: String
    

    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    // 根据泛型类型返回相应的 MoyaProvider
    func provider<T>() -> MoyaProvider<T>? {
        if T.self == AuthAPI.self {
            return authentication as? MoyaProvider<T>
        } else if T.self == BusinessAPI.self {
            return business as? MoyaProvider<T>
        } else if T.self == MemberAPI.self {
            return member as? MoyaProvider<T>
        } else if T.self == PackageCardAPI.self {
            return packageCard as? MoyaProvider<T>
        } else if T.self == BatteryDepositAPI.self {
            return batteryDeposit as? MoyaProvider<T>
        }
        return nil
    }
   
    class RetryPolicy: RequestInterceptor {
        let retryLimit = 3 // 最大重试次数
        let retryDelay: TimeInterval = 1 // 重试延迟时间
        
        func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
            let response = request.task?.response as? HTTPURLResponse
            
            // 仅在服务器错误 (5xx) 或网络错误时重试
            if let response = response, (500...599).contains(response.statusCode), request.retryCount < retryLimit {
                completion(.retryWithDelay(retryDelay))
            } else {
                completion(.doNotRetry)
            }
        }
    }

   
    func createProvider<T: APIType>(forTarget target: T.Type) -> MoyaProvider<T> {
        let endpointClosure = createEndpointClosure(for: target)
        let requestClosure = createRequestClosure(for: target)
        
        let accessTokenPlugin = HFAccessTokenPlugin.init(tokenClosure: { _ in
            TokenManager.shared.accessToken ?? ""
        })
        let loadingPlugin = LoadingPlugin()
        // 创建自定义的 URLSessionConfiguration
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // 请求超时时间
        configuration.timeoutIntervalForResource = 60 // 资源超时时间
        // 创建带重试机制的 Session
        let retrier = RetryPolicy()
        let sessionWithRetry = Session(configuration: configuration, interceptor: retrier)
        return MoyaProvider<T>(endpointClosure: endpointClosure,
                               requestClosure: requestClosure,
                               session: sessionWithRetry,
                               plugins: [accessTokenPlugin,loadingPlugin])
    }
    
    private func createRequestClosure<T: APIType>(for target: T.Type) -> MoyaProvider<T>.RequestClosure {
        // If we are authenticating, skip all logic to get or refresh token, so we return the default request mapping
        if target is AuthAPI.Type { return MoyaProvider<T>.defaultRequestMapping }
        
        // We are hitting another endpoint, so we should check and refresh the token if necessary.
        // We can't use the default request mapping
        let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) -> Void in
            
            self.checkToken(target: target, endpoint: endpoint, done: done)
        }
        
        return requestClosure
    }
    
    private func createEndpointClosure<T: APIType>(for target: T.Type) -> MoyaProvider<T>.EndpointClosure {
        let endpointClosure = { (target: T) -> Endpoint in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            let headers = ["Content-Type": "application/json"]
            return endpoint.adding(newHTTPHeaderFields: headers)
        }
        
        return endpointClosure
    }
    
    func checkToken<T: APIType>(target: T.Type, endpoint: Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) {
        guard let request = try? endpoint.urlRequest() else {
            done(.failure(MoyaError.requestMapping(endpoint.url)))
            return
        }
        
        
        if TokenManager.shared.hasValidToken {
            done(.success(request)) // We have a valid token, so just let the request proceed
        } else {
            refreshToken(target, request, endpoint, done) // We have a invalid token, we should refresh the token
        }
        
    }
    
    private func refreshToken<T: APIType>(_ target: T.Type,
                                                   _ request: URLRequest,
                                                   _ endpoint: Endpoint,
                                                   _ done: @escaping MoyaProvider<T>.RequestResultClosure) {
        let refreshToken = TokenManager.shared.refreshToken  ?? ""
        self.authentication.request(.refreshToken(refreshToken: refreshToken)) { result in
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
                TokenManager.shared.accessToken = jsonBody["accessToken"] as? String
                TokenManager.shared.accessTokenExpiration = jsonBody["accessTokenExpiration"] as? String
                TokenManager.shared.refreshToken = jsonBody["refreshToken"] as? String
                TokenManager.shared.refreshTokenExpiration = jsonBody["refreshTokenExpiration"] as? String
              

                done(.success(request)) // Token refresh success! So we proceed with the original request
            case .failure(let error):
                done(.failure(MoyaError.underlying(error, nil))) // We couldn't refresh the token
            }
        }
    }
    
    
}
