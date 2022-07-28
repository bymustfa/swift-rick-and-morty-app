//
//  Data.swift
//  RickAndMorty
//
//  Created by Mustafa  on 19.07.2022.
//

import Foundation
import SwiftUI

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

struct Character: Codable {
  var id: Int
  var name: String
  var status: String
  var image: String
  var species: String
  var gender: String
}

struct Info: Codable {
  var count: Int
  var pages: Int
  var next: String
  var prev: String!
}

struct ResponseData: Codable {
  var info: Info
  var results: [Character]
}

class Api {
  var responseData = [ResponseData]()

    func getCharacters(completion: @escaping ([Character]) -> Void  ) {
 
        
    if let url = URL(string: "https://rickandmortyapi.com/api/character") {
      if let data = try? Data(contentsOf: url) {

        parse(json: data)
        completion(responseData[0].results)
      }
    }

  }

  func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonDatas = try? decoder.decode(ResponseData.self, from: json) {
      responseData = [jsonDatas]

    }
  }

}
