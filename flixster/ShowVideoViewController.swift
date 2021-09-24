//
//  ShowVideoViewController.swift
//  flixster
//
//  Created by Weiwei Shi on 9/23/21.
//

import UIKit
import WebKit

class ShowVideoViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    var id: String!
    var video = [[String: Any]]()
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/" + id + "/videos?api_key=e20b71915f2d062863f1830ec2e92b43&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){(data, response, error) in
            // This will run when the network request returns
            if let error = error{
                print(error.localizedDescription)
                
            }else if let data = data {
                let videoDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
          
                self.video = videoDictionary["results"] as! [[String:Any]]

                let key = self.video[1]["key"] as!String
                let videoURL = URL(string: "https://www.youtube.com/watch?v=" + key)
                let videoRequest = URLRequest(url: videoURL!)
       
                self.webView.load(videoRequest)
            }
        }
        task.resume()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
