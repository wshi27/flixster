//
//  MoviesAPICaller.swift
//  flixster
//
//  Created by Weiwei Shi on 10/1/21.
//

import Foundation

class MoviesAPICAller {
    static let client = MoviesAPICAller ()
    func getNowPlaying(completion: @escaping ([[String:Any]]?) -> Void){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)

        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String:Any]]
                return completion(movies)
             }
        }
        task.resume()
    }
    
    func getVideos(id: String,completion: @escaping (String?) -> Void){
        let url = URL(string: "https://api.themoviedb.org/3/movie/" + id + "/videos?api_key=e20b71915f2d062863f1830ec2e92b43&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)

        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                let videoDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
          
                let video = videoDictionary["results"] as! [[String:Any]]

                let key = video[1]["key"] as!String
                
                return completion(key)
             }
        }
        task.resume()
    }
    
    func searchMovies(keyword: String, page: Int, completion: @escaping ([String:Any]?) -> Void){
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=e20b71915f2d062863f1830ec2e92b43&language=en-US&query=" + keyword + "&page=\(page)&include_adult=false")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)

        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                print(dataDictionary)
//                print(page)
                return completion(dataDictionary)
             }
        }
        task.resume()
    }
}

