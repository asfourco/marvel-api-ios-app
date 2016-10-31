//
//  MarvelAPI.swift
//  MarvelAPIDemo
//
//  Created by Fadi Asfour on 2016-10-27.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import Foundation
import Alamofire
import Gloss
import CryptoSwift

struct KeyDict {
    let publicKey: String!
    let privateKey: String!
}

class APICall {
    
    private var keys: NSDictionary?
    
    /// Read API Keys from stored property list
    ///
    /// - Returns: A dictionary containing the public key and private kye
    func getKeys() -> KeyDict {
        if let path = Bundle.main.path(forResource: "apikeys", ofType: "plist") {
            self.keys = NSDictionary(contentsOfFile: path)!
        }
        
        if let data = keys {
            return KeyDict(publicKey: data["publicKey"] as! String, privateKey: data["privateKey"] as! String)
        } else {
            return KeyDict(publicKey: "", privateKey: "")
        }
    }
   
    /**
        Forms the API url to retrieve a list of comics from marvel.com
        
        - Parameter limit:  The number of records to retrieve
        - Parameter offset: The number of records to skip
     
        - Parameter completion:  A completion block with the returned data
        - Parameter dataSet: Swift object translation of JSON response
        - Parameter results: Just the results part of the returned dataSet
        - Parameter errorString: reported errors from the transaction
    */
    func downloadComics(limit:Int, offset:Int, completion:  @escaping (_ dataSet: APIReturnDataSet?, _ results: [APIResult]?, _ errorString:String) -> Void) {
        
        let dict: KeyDict = self.getKeys()
        
        let baseMarvelURL = "https://gateway.marvel.com/v1/public/comics"
        let ts = NSDate().timeIntervalSince1970.description
        
        let params: Parameters = [
            "apikey": dict.publicKey!,
            "ts": ts,
            "hash": (ts + dict.privateKey! + dict.publicKey!).md5(),
//            "format":"comic",
//            "noVariants": "true",
            "orderBy": "-focDate",
            "limit" : limit,
            "offset" : offset,
//            "hasDigitalIssue": "true"
        ]
        
        
        Alamofire.request(baseMarvelURL, parameters: params).responseJSON { response in
            
            // debug request
//            print("ts I used: \(ts)")
//            print("Original URL Request: \(response.request)")
            
            guard let marvelReturnData = APIReturnDataSet(json: response.result.value as! JSON) else {
//                print("Error initializating marvel data object")
                completion(nil, [], "Error initializating marvel data object")
                return
            }
            
            guard marvelReturnData.code == 200 else {
//                print("Return Code: \(marvelReturnData.code)")
                completion(nil, [], "Error Return Code: \(marvelReturnData.code)")
                return
            }
            
            guard let results = marvelReturnData.data?.results else {
//                print("No data returned")
                completion(nil, [], "No data returned")
                return
            }
            
            completion(marvelReturnData, results, "No Errors")
            
        }
    }

}
