//
//  StocksCell.swift
//  YandexStocks
//
//  Created by Дмитрий on 23.03.2021.
//

import UIKit
import RealmSwift

class StocksCell: UITableViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var change: UILabel!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    var iexStockObject : IexStockObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createCell(iexStockObject: IexStockObject, index: Int){
        self.iexStockObject = iexStockObject
        container.backgroundColor = index % 2 == 0 ? UIColor(named: "lightGray") : .clear
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 16
        let symbol = iexStockObject.symbol
        DispatchQueue(label: "com.geek-is-stupid.queue.configure-cell").async { [weak self] in
            self?.logoView.imageFromServerURL(symbol: symbol, placeHolder: UIImage(named: "placeholder"))
        }
            self.logoView?.layer.masksToBounds = true
            self.logoView?.layer.cornerRadius = 16
            self.symbol.text = iexStockObject.symbol
            self.name.text = "name \(iexStockObject.symbol)"
            self.price.text = String(format: "%.2f", iexStockObject.close)
            self.change.text = String(format: "%.2f (%.2f", iexStockObject.change, iexStockObject.changePercent) + "%)"
            self.change.textColor = iexStockObject.change > 0 ? UIColor(named: "green") : UIColor(named: "red")
            self.favoriteButtonOutlet.tintColor = iexStockObject.isFavorit ? UIColor(named: "yellow") : UIColor(named: "gray")
        
    }
    @IBAction func favoriteButtonAction(_ sender: Any) {
        let realm = try! Realm()
        try! realm.safeWrite {
            iexStockObject?.isFavorit.toggle()
        }
    }
    
}
