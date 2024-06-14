//
//  AuthService.swift
//  hfpower
//
//  Created by EDY on 2024/6/5.
//

import Alamofire
import Moya
import KakaJSON
import SVProgressHUD
class NetworkService<R:APIType,T: Convertible> {
    
    
    private var provider: MoyaProvider<MultiTarget>?
    init() {
        let networkLoggerPlugin = NetworkLoggerPlugin()
        let loadingPlugin = LoadingPlugin()
        // 创建自定义的 URLSessionConfiguration
        let configuration = URLSessionConfiguration.default
        configuration.shouldUseExtendedBackgroundIdleMode = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .useProtocolCachePolicy
        if #available(iOS 13.0, *) {
            configuration.allowsExpensiveNetworkAccess = true
        }
        configuration.waitsForConnectivity = true
        // 创建带重试机制的 Session
        //        let retrier = RetryPolicy()
        let sessionWithRetry = Session(configuration: configuration)
        provider = MoyaProvider<MultiTarget>(session: sessionWithRetry,plugins: [loadingPlugin,networkLoggerPlugin],trackInflights: true)
    }
    private var ongoingRequests: [String: Cancellable] = [:]
    
    func request(_ target: R, completion: @escaping (Result<T?, Error>) -> Void) {
        let requestKey = target.path
        let needHUD = target.shouldShowLoadingView
        if needHUD == true{
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setMinimumDismissTimeInterval(2)
            SVProgressHUD.show()
            
            
        }
        if self.ongoingRequests[requestKey] != nil {
            return
        }
        let request = self.provider?.request(MultiTarget(target),callbackQueue: DispatchQueue.main) { result in
            self.ongoingRequests.removeValue(forKey: requestKey)
            if needHUD == true{
                SVProgressHUD.dismiss() // 请求完成时隐藏 Toast
                
                
            }
            switch result {
            case .success(let response):
                do{
                    // 尝试将响应数据解析为指定的模型类型
                    let model = try response.mapString().kj.model(CommonResponse<T>.self)
                    // 解析成功，调用成功的 completion 回调
                    
                    completion(.success(model?.body))
                }catch let error{
                    if needHUD == true{
                        SVProgressHUD.showError(withStatus: error.localizedDescription)
                        
                    }
                    completion(.failure(MoyaError.jsonMapping(response)))
                    
                }
                
                
                
                
            case .failure(let error):
                if needHUD == true{
                    DispatchQueue.main.async {
                        SVProgressHUD.showError(withStatus: error.localizedDescription)
                    }
                }
                // 请求失败，调用失败的 completion 回调
                if error.response?.statusCode == 401{
                    TokenManager.shared.clearTokens()
                    AccountManager.shared.clearAccount()
                    MainManager.shared.resetAll()
                }
                completion(.failure(error))
            }
        }
        self.ongoingRequests[requestKey] = request
        
        
        
    }
    
    
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
