//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by AMAR on 30/12/23.
//

import UIKit

class SearchViewController: UIViewController {

    private var titles:[Title] = [Title]()
    
    private let searchController : UISearchController = {
            let controller = UISearchController(searchResultsController: SearchViewController())
        controller.searchBar.placeholder = "Search for Movies or a TV Show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private let discovertableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discovertableView)
        discovertableView.delegate = self
        discovertableView.dataSource = self
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        fetchDiscoverMovies()
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discovertableView.frame = view.bounds
    }
    
    func fetchDiscoverMovies(){
        APICaller.shared.getDiscoverMovies { result in
            switch result{
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async {
                    self.discovertableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell 
        else { return UITableViewCell()}
        
        
        let title = titles[indexPath.row]
        let model = TitleViewModel(titlename: title.original_name ?? title.original_title ?? "Unknown title name", posterURL: title.poster_path ?? "")
        
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let titles):
                    resultController.titles = titles
                    resultController.searchresultColleactionView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
