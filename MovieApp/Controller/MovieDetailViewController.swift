//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Otebay Akan on 25.04.2021.
//

import UIKit
import Alamofire
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var ratingContainer: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    public var movieId: Int?
    
    private var TRENDING_MOVIE_BY_ID = "https://api.themoviedb.org/3/movie/"
    
    private var titleMovie: String?
    private var ratingMovie: String?
    private var releaseDateMovie: String?
    private var descriptionMovie: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingContainer.layer.cornerRadius = 20
        ratingContainer.layer.masksToBounds = true
        self.setURL()
        getMovie()
    }
    
    func setURL() {
        TRENDING_MOVIE_BY_ID += "\(movieId!)" + "?api_key=73433bb96cb41890d8af0367d0ebf88c"
    }
    
    @IBAction func favouriteButtonPressed(_ sender: Any) {
    }
}
extension MovieDetailViewController {
    func getMovie() {
        AF.request(TRENDING_MOVIE_BY_ID, method: .get, parameters: [:]).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                    let movieJSON = try JSONDecoder().decode(MovieDetailEntity.self, from: data)
                        self.title = movieJSON.title
                        self.ratingMovie = "\(movieJSON.rating)"
                        self.titleMovie = movieJSON.title
                        self.descriptionMovie = movieJSON.overview
                        self.releaseDateMovie = movieJSON.releaseDate
                        self.setLabels()
                        let posterURL = URL(string: "https://image.tmdb.org/t/p/w500" + (movieJSON.poster ?? ""))
                        self.imageView.kf.setImage(with: posterURL)
                    }
                    catch{
                        print(error)
                    }
                }
                break
            case .failure:
                print("Fail")
            }
        }
    }
    func setLabels() {
        self.ratingLabel.text = self.ratingMovie
        self.titleLabel.text = self.titleMovie
        self.descriptionLabel.text = self.descriptionMovie
        self.releaseDateLabel.text = self.releaseDateMovie
    }
}
