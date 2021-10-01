//
//  MovieGridViewController.swift
//  flixster
//
//  Created by Weiwei Shi on 9/18/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var movies = [[String:Any]]()
    var keyword: String!
    var currPage: Int!
    public var totalPages: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        setCollectionViewLayout()
        getInitialMovies()

    }
    
    func setCollectionViewLayout(){
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2)/3
        layout.itemSize = CGSize(width: width, height: width*3/2)
    }
    
    func getInitialMovies(){
        MoviesAPICAller.client.getNowPlaying() {(movies) in
            guard let movies = movies else{
                return
            }
            self.movies = movies;
            self.collectionView.reloadData()
        }
    }
    
    func loadMoreResults(){
        currPage += 1
        
        MoviesAPICAller.client.searchMovies(keyword: keyword, page: currPage) {(dataDictionary) in
            guard let dataDictionary = dataDictionary else{
                return
            }
            let additionalMovies = dataDictionary["results"] as! [[String:Any]]
            self.movies.append(contentsOf: additionalMovies)
            //print("movies count = \(self.movies.count)")
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        guard let posterPath = movie["poster_path"] as? String else { return cell}
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item + 2 == movies.count && totalPages > currPage {
            loadMoreResults()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        currPage = 1;
        if(searchBar.text != ""){
            self.keyword = searchBar.text!
            MoviesAPICAller.client.searchMovies(keyword: keyword, page: currPage) {(dataDictionary) in
                guard let dataDictionary = dataDictionary  else{
                    return
                }
                self.movies = dataDictionary["results"] as! [[String:Any]];
                self.totalPages = dataDictionary["total_pages"] as? Int
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let detailsViewController = segue.destination as! MovieGridDetailsViewController
        
        detailsViewController.movie = movie
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    

}
