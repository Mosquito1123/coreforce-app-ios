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
    func request<T: Convertible>(_ target: R, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        provider?.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    // 尝试将响应数据解析为指定的模型类型
                    if let model = try response.mapString().kj.model(T.self) {
                        // 解析成功，调用成功的 completion 回调
                        completion(.success(model))
                    } else {
                        // 解析失败，抛出 JSON 解析错误
                        throw MoyaError.jsonMapping(response)
                    }
                } catch {
                    // 如果响应状态码是 401，则尝试刷新令牌
                    if response.statusCode == 401 {
                        self.refresh {
                            // 令牌刷新成功后，重试原始请求
                            self.request(target, model: model, completion: completion)
                        }
                    } else {
                        // 其他错误，调用失败的 completion 回调
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                // 请求失败，调用失败的 completion 回调
                completion(.failure(error))
            }
        }
    }

    private func refresh(completion: @escaping () -> Void) {
        guard let token = TokenManager.shared.refreshToken else {
            // 如果没有刷新令牌或刷新令牌无效，清除所有令牌并返回
            TokenManager.shared.clearTokens()
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
            }
        }
        func configResponse(_ response:Moya.Response){
            do{
                // 尝试将响应数据解析为 TokenResponse 模型
                let commonResponse:CommonResponse<TokenResponse> = try response.mapString().kj.model(CommonResponse<TokenResponse>.self) ?? CommonResponse()
                
                // 更新访问令牌和其过期时间
                TokenManager.shared.accessToken = commonResponse.body?.accessToken
                TokenManager.shared.accessTokenExpiration = commonResponse.body?.accessTokenExpiration
            } catch _ {
                // 解析错误，清除所有令牌
                TokenManager.shared.clearTokens()
            }
        }
        
    }
}

