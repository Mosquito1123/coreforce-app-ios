//
//  HFNetworkingType.swift
//  hfpower
//
//  Created by EDY on 2024/4/12.
//

import Moya

public protocol APIType: TargetType, HFAccessTokenAuthorizable,LoadingPluginDelegate {}

public extension APIType {

    var baseURL: URL { return URL(string: "http://www.coreforce.cn/app/api/")! }

    var headers: [String: String]? { return nil }

    var method: Moya.Method { return .get }

    var authorizationType: HFAuthorizationType { return .bearer }
    
    var shouldShowLoadingView: Bool? {return true}

    var sampleData: Data { return Data() }
}
