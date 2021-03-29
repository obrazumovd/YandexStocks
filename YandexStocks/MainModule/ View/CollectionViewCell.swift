//
//  CollectionViewCell.swift
//  YandexStocks
//
//  Created by Дмитрий on 25.03.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var symbolLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class var reuseIdentifier: String {
        return "CollectionViewCell"
    }
    class var nibName: String {
        return "CollectionViewCell"
    }
    
    func configureCell(symbol: String) {
        self.symbolLable.text = symbol
        self.backgroundColor = UIColor(named: "collectionGray")
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        
    }

}


