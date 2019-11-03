//
//  RecycleWastViewModel.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 10/26/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class RecycleWasteViewModel {
    static let shared = RecycleWasteViewModel()
    private let session = URLSession(configuration: .default)
    
    private func addQueries(_ queries: [String:String], to baseURL: URL) -> URL {
        var components = URLComponents(string: baseURL.absoluteString)
        let queryItems = queries.map { URLQueryItem(name: $0, value: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))}
        components?.queryItems = queryItems
        return components?.url ?? baseURL
    }
    
    func requestWasteType(_ name: String, complition: @escaping ([RecycleWaste]?) -> Void) {
        let ref = Database.database().reference().child("recycleWasteType")
        ref.queryOrdered(byChild: "name").observeSingleEvent(of: .value, with: { (snapshot) in
            
            print(snapshot)
            
        })
//        guard var url = URL(string: search) else { print("no url", search); return}
//        let queries: [String:String] = [project: "project", entity: "ecotrash-7b0d2", term: name]
//        url = addQueries(queries, to: url)
//        let task = session.dataTask(with: url) { data, response, error in
//            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else { complition(nil); return }
//            guard let data = data else { complition(nil); return }
//            guard let result = try? JSONDecoder().decode(Result.self, from: data) else  { complition(nil); return }
//            complition(result.results)
//        }
//        task.resume()
    }
}
