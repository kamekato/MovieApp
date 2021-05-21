//
//  MovieCell.swift
//  MovieApp
//
//  Created by Otebay Akan on 25.04.2021.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {

    public static let identifier: String = "MovieCell"
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var ratingContainerView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    public var movie: MovieEntity.Movie? {
        didSet {
            if let movie = movie {
                let posterURL = URL(string: "https://image.tmdb.org/t/p/w500" + (movie.poster ?? ""))
                posterImageView.kf.setImage(with: posterURL)
                ratingLabel.text = "\(movie.rating)"
                movieTitleLabel.text = movie.title
                releaseDateLabel.text = movie.releaseDate
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        posterImageView.layer.cornerRadius = 12
        posterImageView.layer.masksToBounds = true
        posterImageView.backgroundColor = .systemTeal
        ratingContainerView.layer.cornerRadius = 20
        ratingContainerView.layer.masksToBounds = true
    }

    
}
