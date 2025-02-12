//
//  NetworkResults.swift
//  Picknic-iOS
//
//  Created by 황지은 on 2020/12/05.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
