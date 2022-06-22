//
//  PodcastsTableViewController.swift
//  MyHeritagePodcasts
//
//  Created by Mihai-Ionut Ghete on 22.06.2022.
//

import UIKit

private let reuseCellID = "podcastCellReuseID"

class PodcastsTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = PodcastsTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.reloadData.bind { [weak self] reload in
            if reload {
                self?.tableView.reloadData()
            }
        }
        
        // have a default search text so the table view is not empty at launch
        searchBar.text = "myheritage"
        viewModel.fetchPodcasts(searchString: "myheritage")
        
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? PodcastTableViewCell, let destinationVC = segue.destination as? PodcastDetailsViewController {
            destinationVC.viewModel = sender.viewModel
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.itemsCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellID, for: indexPath) as! PodcastTableViewCell
        cell.viewModel = viewModel.viewModels[indexPath.row]
        return cell
    }
}

extension PodcastsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.newSearchString(searchString: searchText)
    }
}
