//
//  Route.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

enum Route: Hashable {
    case list
    case riverInfo(name: String)
    case error(error: APIResult)
}
