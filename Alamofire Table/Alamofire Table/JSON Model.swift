//
//  JSON Model.swift
//  Alamofire Table
//
//  Created by Александр Пархамович on 1.10.22.
//

import Foundation
import UIKit

// MARK: - Posts model

struct PostModel: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
