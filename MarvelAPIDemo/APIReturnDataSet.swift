//
//  APIRetunData.swift
//  MarvelAPIDemo
//
//  Created by Fadi Asfour on 2016-10-27.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import Foundation
import Gloss

public struct APIReturnDataSet: Decodable {
    public let code: Int?
    public let status: String?
    public let attributionText: String?
    
    public let data: APIData?
    // MARK: - Deserialization
    
    public init?(json: JSON) {
        self.code = "code" <~~ json
        self.status = "status" <~~ json
        self.attributionText = "attributionText" <~~ json
        self.data = "data" <~~ json
    }
    
}
