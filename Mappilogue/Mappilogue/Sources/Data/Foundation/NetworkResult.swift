//
//  NetworkResult.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/27.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestError(T) // 요청 에러
    case serverError // 서버 내부 에러
    case pathError // 경로 에러
    case networkFail // 네트워크 연결 실패
}
