//
//  ViewController.swift
//  MovieApp
//
//  Created by Otebay Akan on 25.04.2021.
//

import UIKit
import Alamofire

class TrendingMoviesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let TRENDING_MOVIES_URL: String = "https://api.themoviedb.org/3/trending/movie/week?api_key=73433bb96cb41890d8af0367d0ebf88c"
    
    private var movies: [MovieEntity.Movie] = [MovieEntity.Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var pageNumber: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: MovieCell.identifier, bundle: Bundle(for: MovieCell.self)), forCellReuseIdentifier: MovieCell.identifier)
        getTrendingsMovies(pageNumber)
    }


}

extension TrendingMoviesVC {
    private func getTrendingsMovies(_ page: Int? = nil) {
        var params: [String: Any] = [:]
        if let page = page {
            params["page"] = page
        }
        AF.request(TRENDING_MOVIES_URL, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                    let movieJSON = try JSONDecoder().decode(MovieEntity.self, from: data)
                        self.movies += movieJSON.results
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
}

extension TrendingMoviesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailViewController {
            vc.movieId = movies[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 10 && currentOffset > 100 {
            pageNumber += 1
            getTrendingsMovies(pageNumber)
        }
    }
}

extension TrendingMoviesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        return cell
    }
}
