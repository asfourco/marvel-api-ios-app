//
//  MarvelData.swift
//  MarvelAPIDemo
//
//  Created by Fadi Asfour on 2016-10-27.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import Foundation
import Gloss

public struct APIData: Decodable {
    
    public let offset: Int?
    public let limit: Int?
    public let total: Int?
    public let count: Int?
    public let results: [APIResults]?
    
    public init?(json: JSON) {
        self.offset = "offset" <~~ json
        self.limit = "limit" <~~ json
        self.total = "total" <~~ json
        self.count = "count" <~~ json
        self.results = "results" <~~ json
    }
}

public struct APIResults: Decodable {
    public let id: Int?
    public let title: String?
    public let issueNumber: Int?
    public let description: String?
    public let isbn: String?
    public let pageCount: Int?
    public let thumbnail: APIImageResult?
    public let image:APIImageResult?
    
    
    public init?(json: JSON) {
        self.id = "id" <~~ json
        self.title = "title" <~~ json
        self.issueNumber = "issueNmber" <~~ json
        self.description = "description" <~~ json
        self.isbn = "isbn" <~~ json
        self.pageCount = "pageCount" <~~ json
        self.thumbnail = "thumbnail" <~~ json
        self.image = "image" <~~ json
    }
}

public struct APIImageResult: Decodable {
    public let fileExtension: String?
    
    private var _path: String!
    public var path: String? {
        return self.securePath(path: _path)
    }
    
    public var url: URL? {
        return URL(string: self.securePath(path: self._path) + "." + self.fileExtension!)
    }
    
    
    func securePath(path:String) -> String {
        if path.hasPrefix("http://") {
            let range = path.range(of: "http://")
            var newPath = path
            newPath.removeSubrange(range!)
            return "https://" + newPath
        } else {
            return path
        }
    }
    
    public init?(json:JSON) {
        self._path = "path" <~~ json
        self.fileExtension = "extension" <~~ json
    }
    
}
