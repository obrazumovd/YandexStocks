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
    
    @IBOutlet weak var emptyView: EmptyView!
    @IBOutlet weak var collectionContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionContainerBottomConstraint: NSLayoutConstraint!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var refreshControl = UIRefreshControl()
    
    
    var presentor : ViewToPresenterProtocol?
    var stocksArray = List<IexStockObject>(){
        didSet{
            updateTableDataset()
        }
    }
    var tableDatasource : [IexStockObject] = []
    var isFavorite: Bool{
        segmentOutlet.selectedSegmentIndex == 1
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var myCollectionView:UICollectionView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.delegate = self
        setRefreshControl()
        refresh(self)
        setSegmentController()
    }
    
    func showHideCollectionContainer(){
        if searchController.isActive && isSearchBarEmpty{
            emptyView.isHidden = false
            emptyView.updateData()
            collectionContainerHeightConstraint.priority = UILayoutPriority(rawValue: 999)
            collectionContainerBottomConstraint.priority = UILayoutPriority(rawValue: 1000)
        } else{
            emptyView.isHidden = true
            collectionContainerHeightConstraint.priority = UILayoutPriority(rawValue: 1000)
            collectionContainerBottomConstraint.priority = UILayoutPriority(rawValue: 999)
        }
    }
    
    func setSegmentController(){
        segmentOutlet.backgroundColor = .white
        segmentOutlet.tintColor = .clear
        segmentOutlet.selectedSegmentTintColor = .clear
        
        segmentOutlet.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Bold", size: 18) ?? UIFont(),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)

        segmentOutlet.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Bold", size: 28) ?? UIFont(),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], for: .selected)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            for i in 0...(self.segmentOutlet.numberOfSegments-1)  {
                let backgroundSegmentView =  self.segmentOutlet.subviews[i]
                backgroundSegmentView.isHidden = true
                }
            }
        
    }
    
    
    
    
    func setSearchController(){
        searchController.searchBar.heightAnchor.constraint(equalToConstant: 148).isActive = true

        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find company or ticker"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    func setRefreshControl(){
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject){
        refreshControl.beginRefreshing()
        presentor?.startFetchingStock()
    }
    
    func updateTableDataset(){
        if !searchController.isActive{
            self.tableDatasource = isFavorite ? stocksArray.filter{$0.isFavorit} : Array(stocksArray)
            self.tableView.reloadData()
        } else{
            let searchBar = searchController.searchBar
            filterContentForSearchText(searchBar.text!)
        }
        showHideCollectionContainer()
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
        showHideCollectionContainer()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setSearchController()
    }

}

extension MainViewController : PresenterToViewProtocol{
    func showStock(stockArray: List<IexStockObject>) {
        self.stocksArray = stockArray
        self.tableView.reloadData()
        refreshControl.endRefreshing()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentor?.showStockView(navigationController: self.navigationController ?? UINavigationController(), symbol: tableDatasource[indexPath.row].symbol)
    }
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

extension MainViewController : EmptyViewToParent{
    func didSelectSymbol(symbol: String) {
        searchController.searchBar.text = symbol
        presentor?.saveSymbolToHistory(symbol: symbol)
    }
    
    
}




