//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Edgar Reyes on 9/18/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit
import AlamofireImage
import WebKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(poseterClicked(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185"+posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780"+backdropPath)
        
        backdropView.af_setImage(withURL: backdropUrl!)
        
        backdropView.addGestureRecognizer(gestureRecognizer)
        backdropView.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func poseterClicked(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "moviesModal", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected movie to the details view controller
        if segue.identifier == "moviesModal"{
            let detailsViewController = segue.destination as! TrailerViewController
            detailsViewController.movie_id = movie["id"] as! Int
        }
        
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
