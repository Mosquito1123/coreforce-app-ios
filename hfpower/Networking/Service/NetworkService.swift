//
//  AuthService.swift
//  hfpower
//
//  Created by EDY on 2024/6/5.
//

import Foundation
import Moya
import KakaJSON
class NetworkService<R:APIType> {
    let refreshProvider: MoyaProvider<AuthAPI> = NetworkingClient(apiKey: "").authentication
    
    let provider: MoyaProvider<R>? = NetworkingClient(apiKey: "").provider()
    
    private var ongoingRequests: [String: Cancellable] = [:]
    
    func request<T: Convertible>(_ target: R, model: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        let requestKey = target.path
        
        if self.ongoingRequests[requestKey] != nil {
            debugPrint("Request already in progress")
            return
        }
        let request = self.provider?.request(target) { result in
            self.ongoingRequests.removeValue(forKey: requestKey)
            
            switch result {
            case .success(let response):
                
                // 尝试将响应数据解析为指定的模型类型
                if let model = try? response.mapString().kj.model(CommonResponse<T>.self) {
                    if model.head?.retFlag == "00000"{
                        // 解析成功，调用成功的 completion 回调
                        
                        completion(.success(model.body))
                        
                    }else{
                        let moyaError = MoyaError.underlying(NSError(domain: target.baseURL.absoluteString, code: Int(model.head?.retFlag ?? "-1") ?? 0, userInfo: [NSLocalizedDescriptionKey:model.head?.retMsg ?? "",NSLocalizedFailureReasonErrorKey:model.head?.retMsg ?? "",NSLocalizedRecoverySuggestionErrorKey:model.head?.retMsg ?? "","body":model.body as Any]), response)
                        
                        completion(.failure(moyaError))
                    }
                    
                }
                
            case .failure(let error):
                // 请求失败，调用失败的 completion 回调
                if error.response?.statusCode == 401 {
                    TokenManager.shared.clearTokens()
                    AccountManager.shared.clearAccount()
                    
                    completion(.failure(error))
                    
                }else{
                    
                    completion(.failure(error))
                    
                }
            }
        }
        self.ongoingRequests[requestKey] = request
        
        
        
    }
    
    private func refresh(completion: @escaping () -> Void) {
        guard let token = TokenManager.shared.refreshToken else {
            // 如果没有刷新令牌或刷新令牌无效，清除所有令牌并返回
            TokenManager.shared.clearTokens()
            AccountManager.shared.clearAccount()
            return
        }
        
        
        refreshProvider.request(.refreshToken(refreshToken: token)) { result in
            switch result {
            case .success(let response):
                configResponse(response)
                
                // 刷新令牌成功，调用 completion 回调
                completion()
                
            case .failure:
                // 请求刷新令牌失败，清除所有令牌
                TokenManager.shared.clearTokens()
                AccountManager.shared.clearAccount()
                
            }
        }
        func configResponse(_ response:Moya.Response){
            do{
                // 尝试将响应数据解析为 TokenResponse 模型
                let commonResponse:CommonResponse<TokenResponse> = try response.mapString().kj.model(CommonResponse<TokenResponse>.self) ?? CommonResponse()
                
                // 更新访问令牌和其过期时间
                TokenManager.shared.accessToken = commonResponse.body?.accessToken
                TokenManager.shared.accessTokenExpiration = commonResponse.body?.accessTokenExpiration
                TokenManager.shared.refreshToken = commonResponse.body?.refreshToken
                TokenManager.shared.refreshTokenExpiration = commonResponse.body?.refreshTokenExpiration
            } catch _ {
                // 解析错误，清除所有令牌
                TokenManager.shared.clearTokens()
            }
        }
        
    }
}

