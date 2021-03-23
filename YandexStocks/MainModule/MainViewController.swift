//
//  MainViewController.swift
//  YandexStocks
//
//  Created by Дмитрий on 21.03.2021.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var presentor : ViewToPresenterProtocol?
    var stocksArray = List<IexStockObject>(){
        didSet{
            updateTableDataset()
        }
    }
    var tableDatasource : [IexStockObject] = []
    var isFavorite: Bool{
        return segmentOutlet.selectedSegmentIndex == 1
    }
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presentor?.startFetchingStock()
        setSearchController()
    }
    
    func setSearchController(){
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find company or ticker"
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    }
    
    func updateTableDataset(){
        if isSearchBarEmpty{
            self.tableDatasource = isFavorite ? stocksArray.filter{$0.isFavorit} : Array(stocksArray)
            self.tableView.reloadData()
        } else{
            let searchBar = searchController.searchBar
            filterContentForSearchText(searchBar.text!)
        }
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        updateTableDataset()
   }
    
    func filterContentForSearchText(_ searchText: String) {
//        tableDatasource = stocksArray.filter{$0.symbol.lowercased().contains(searchText.lowercased())}
        if isFavorite{
            tableDatasource = stocksArray.filter { (stocks: IexStockObject) -> Bool in
                return stocks.symbol.lowercased().contains(searchText.lowercased()) && stocks.isFavorit
            }
        } else{
            tableDatasource = stocksArray.filter { (stocks: IexStockObject) -> Bool in
                return stocks.symbol.lowercased().contains(searchText.lowercased())
            }
        }
      tableView.reloadData()
    }

}

extension MainViewController : PresenterToViewProtocol{
    func showStock(stockArray: List<IexStockObject>) {
        self.stocksArray = stockArray
        self.tableView.reloadData()
    }
    
    func showError() {
        print("DEBAG: Error")
    }
}

extension MainViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StocksCell
        let stock = tableDatasource[indexPath.row]
       
        cell.createCell(iexStockObject: stock, index: indexPath.row)
        return cell
    }
    
    
}

extension MainViewController : UITableViewDelegate{
    
}

extension MainViewController: UISearchResultsUpdating {
    
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}

extension MainViewController : UISearchControllerDelegate{
    func didDismissSearchController(_ searchController: UISearchController) {
        updateTableDataset()
    }
}



extension MainViewController : UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        updateTableDataset()
    }
}
