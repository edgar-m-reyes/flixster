//
//  TrailerViewController.swift
//  flixster
//
//  Created by Edgar Reyes on 9/21/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit
import WebKit
import Foundation

class TrailerViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var movie_id : Int!
    var videos = [[String:Any]]()
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myRequest()
        let key: String = videos[0]["key"] as! String
        let myURL = URL(string:"https://www.youtube.com/watch?v=\(key)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    
    public func myRequest() {
        var done = false
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie_id!)))/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
              self.videos = dataDictionary["results"] as! [[String:Any]]
              done = true
           }
        }
        task.resume()
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !done
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
