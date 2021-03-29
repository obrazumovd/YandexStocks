//
//  StockView.swift
//  YandexStocks
//
//  Created by Дмитрий on 27.03.2021.
//

import UIKit
import Charts

class StockView: UIViewController , StockPresenterToViewProtocol{

    @IBOutlet var periodButtonOutlet: [UIButton]!
    @IBOutlet weak var buyButtonOutlet: UIButton!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    var presentor : StockViewToPresenterProtocol?
    var lineChartEntry = [ChartDataEntry]()
    var selectedPeriodTag = 0{
        didSet{
            setupPeriodButton()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setapChart()
    }
    
    func setapChart(){
        lineChartView.xAxis.drawLabelsEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawAxisLineEnabled = false
        
        lineChartView.leftAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false
        lineChartView.legend.enabled = false
    }
    
    func updateChartView(data: [ChartDataEntry]) {
        
        
        let line = LineChartDataSet(entries: data, label: "Lable")
        line.colors = [UIColor.black]
        
        line.mode = .cubicBezier
        line.lineWidth = 2.5
        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false
        line.drawHorizontalHighlightIndicatorEnabled = false
        line.drawVerticalHighlightIndicatorEnabled = false
        
        let gradientColors = [
            UIColor.black.cgColor,
            UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 0).cgColor] as CFArray //
        let colorLocations:[CGFloat] = [0.5, 0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        line.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        line.drawFilledEnabled = true
        
        let data = LineChartData()
        data.addDataSet(line)
        lineChartView.data = data
         
    }
    
    func setupView(){
        self.navigationController?.navigationItem.title = "Test"
        setupPeriodButton()
        buyButtonOutlet.layer.masksToBounds = true
        buyButtonOutlet.layer.cornerRadius = 16
    }
    
    func setupPeriodButton(){
        for button in periodButtonOutlet{
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 12
            button.backgroundColor = button.tag == selectedPeriodTag ? .gray : UIColor(named: "collectionGray")
            
        }
    }
    
    @IBAction func periodButtonAction(_ button: UIButton) {
        print(button.tag)
        var period = ChartPeriod.day
        switch button.tag {
        case 0:
            period = .day
        case 1:
            period = .week
        case 2:
            period = .month
        case 3:
            period = .halfYear
        case 4:
            period = .year
        case 5:
            period = .fiveYear
        default:
            period = .day
        }
        selectedPeriodTag = button.tag
        presentor?.startFetchQuote(period: period)
    }
    @IBAction func buyButtonAction(_ sender: Any) {
        presentor?.startFetchQuote(period: ChartPeriod.day)
    }
    
    func fetchStockSuccess(iexStockObject: IexStockObject) {
        self.title = iexStockObject.symbol
        self.priceLabel.text = "\(iexStockObject.close)$"
        self.changeLabel.text = String(format: "%.2f", iexStockObject.changePercent) + "%"
        self.changeLabel.textColor = iexStockObject.change > 0 ? UIColor(named: "green") : UIColor(named: "red")
        self.buyButtonOutlet.setTitle("Buy for $\(iexStockObject.close)", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentor?.fetchStock()
        presentor?.startFetchQuote(period: ChartPeriod.day)
    }
}
