//
//  EmptyView.swift
//  YandexStocks
//
//  Created by Дмитрий on 25.03.2021.
//

import UIKit
import RealmSwift

class EmptyView: UIView {

    var presenter: EmptyViewToPresenterProtocol?
    var delegate : EmptyViewToParent?
    var popularyArray = [String]()
    var historyArray = List<HistoryObject>()
    
    
    @IBOutlet weak var historyCollection: UICollectionView!
    @IBOutlet weak var popularCollection: UICollectionView!
    @IBOutlet var contentView: UIView!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("EmptyView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let presenter: EmptyViewToPresenterProtocol & EmptyInteractorToPresenterProtocol = EmptyPresenter()
        let interactor: EmptyPresenterToInteractorProtocol = EmptyInteractor()
            
        self.presenter = presenter
        presenter.view = self
        presenter.interactor = interactor
        interactor.presenter = presenter

        registerNib()
    }
    
    func updateData(){
        presenter?.startFetchingHistory()
        presenter?.startFetchingPopulary()
    }
    
    func registerNib() {
        let nib = UINib(nibName: CollectionViewCell.nibName, bundle: nil)
        popularCollection?.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        historyCollection?.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        if let flowLayout = self.popularCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        if let flowLayout = self.historyCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func returnSymbol(collectionView: UICollectionView, indexPath: IndexPath)-> String{
        return collectionView == popularCollection ? popularyArray[indexPath.row] : historyArray[indexPath.row].symbol
    }
}

extension EmptyView : EmptyPresenterToViewProtocol{
    
    func showPopulary(popularyArray: [String]) {
        self.popularyArray = popularyArray
        popularCollection.reloadData()
    }
    
    func showHistory(historyArray: List<HistoryObject>) {
        self.historyArray = historyArray
        historyCollection.reloadData()
    }
    
    func popularyFetchFailed(error: String) {
        print(error)
    }
}

extension EmptyView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularCollection{
            return popularyArray.count
        } else{
//            return testHistory.count
            return historyArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier,
                                                         for: indexPath) as? CollectionViewCell {
            
            let symbol = returnSymbol(collectionView: collectionView, indexPath: indexPath)
            cell.configureCell(symbol: symbol)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension EmptyView: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let symbol = returnSymbol(collectionView: collectionView, indexPath: indexPath)
        self.delegate?.didSelectSymbol(symbol: symbol)
    }
}

extension EmptyView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let symbol = returnSymbol(collectionView: collectionView, indexPath: indexPath)
        let label = UILabel(frame: CGRect.zero)
        label.text = symbol
        label.sizeToFit()
        let size = symbol.size(withAttributes: nil)
        return CGSize(width: size.width, height: 40)
    }

}
