//
//  CVCryptoViewController.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 29.08.2024.
//

import UIKit
import SwiftUI

class CVCryptoViewController: CVLoadingDataViewController {

    var crypto: Crypto
    
    var header: CVCryptoHeaderTitle?
    var segmentedControl: UISegmentedControl?
    var chart: UIHostingController<CVChartView>?
    
    init(crypto: Crypto) {
        self.crypto = crypto
        super.init(nibName: nil, bundle: nil)
        self.header = CVCryptoHeaderTitle(crypto: crypto)
        getChartData(crypto: crypto, days: 2)
        
    }
    
    
    private func getChartData(crypto: Crypto, days: Int) {
        self.showLoadingView()
        
        let isDailyInterval = days > 2
        
        NetworkManager.shared.getChartData(for: crypto.id, days: days, daily: isDailyInterval) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let chartData):
            
                DispatchQueue.main.async {
                    
                    var priceData = chartData.prices
                    priceData.sort { $0.price < $1.price }
                    
                    guard priceData.count > 0 else { return }
                    
                    self.chart = UIHostingController(rootView:
                                                        CVChartView(minY: priceData.first!.price,
                                                                    maxY: priceData.last!.price,
                                                                    list: chartData.prices))
                    self.updateChart()
                }
                
                
//                for pair in success.prices {
//                    //print("Date: \(pair.time) : price: \(pair.price) $")
//                    print("PriceData(time: \"\(pair.time)\", price: \(pair.price)),")
//                }
            case .failure(let _):
                print("error")
            }
            
            
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        setupLayout()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = crypto.name
    }
    
    
    private func setupSegmentedControl() {
        let items = ["1 Day", "2 Days", "7 Days", "30 Days", "90 Days"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        self.segmentedControl = segmentedControl
    }
    
    
   
    private func setupLayout() {
        
        setupSegmentedControl()
        
        guard let header = header else { return }
        guard let segmentedControl = segmentedControl else { return }
        
        view.addSubviews(header, segmentedControl)
        
        header.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
       
        let horizontalPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            header.heightAnchor.constraint(equalToConstant: 100),
            
            segmentedControl.topAnchor.constraint(equalTo: header.bottomAnchor, constant: horizontalPadding),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    private func updateChart() {
        guard let segmentedControl = segmentedControl else  { return }
        guard let chartView = chart?.view else { return }
        
        let padding: CGFloat = 12
        
        view.addSubview(chartView)
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            chartView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 2*padding),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            chartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
        
    }
    
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
            let days: Int
            switch sender.selectedSegmentIndex {
            case 0:
                days = 1
            case 1:
                days = 2
            case 2:
                days = 7
            case 3:
                days = 30
            case 4:
                days = 90
            default:
                days = 2
            }
            getChartData(crypto: crypto, days: days)
        }
    
}




//#Preview {
//    CVCryptoViewController(crypto:
//                            Crypto(id: "StarC",
//                                   symbol: "ccrpt",
//                                   name: "StarCoin",
//                                   image: "",
//                                   currentPrice: 68000))
//}
