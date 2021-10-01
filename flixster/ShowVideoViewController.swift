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
    var key: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: CGRect(x: 0, y: 90, width: self.view.frame.width, height: self.view.frame.height-90))
        self.view.addSubview(webView)
        
        loadVideo()
    }
    
    func loadVideo(){
        MoviesAPICAller.client.getVideos(id: id){(key) in
            guard let key = key else{
                return
            }
            self.key = key;
            let videoURL = URL(string: "https://www.youtube.com/watch?v=" + key)
            let videoRequest = URLRequest(url: videoURL!)
            self.webView.load(videoRequest)
        }
    }

    @IBAction func dismissWebView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
