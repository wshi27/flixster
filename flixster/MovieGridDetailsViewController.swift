//
//  MovieGridDetailsViewController.swift
//  flixster
//
//  Created by Weiwei Shi on 9/23/21.
//

import UIKit

class MovieGridDetailsViewController: UIViewController {
    @IBOutlet weak var backDropImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var sypnosisLabel: UILabel!
    
    var movie:[String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieNameLabel.text = movie["title"] as? String
        sypnosisLabel.text = movie["overview"] as? String
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        
        if let posterPath = movie["poster_path"] as? String {
            let posterUrl = URL(string: baseUrl + posterPath)
            posterImage.af.setImage(withURL: posterUrl!)
        }
        
        if let backdropPath = movie["backdrop_path"] as? String{
            let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
            backDropImage.af.setImage(withURL: backdropUrl!)
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
