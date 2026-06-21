//
//  GraficoViewController.swift
//  TableView
//
//  Created by Rodrigo Takumi on 20/06/26.
//

import UIKit
import DGCharts

class GraficoViewController: UIViewController {

    let screen = GraficoScreen()
    
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gráficos"
        
        screen.setDelegate(self)
    }
}

extension GraficoViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        screen.setLabel( "Valor: \(entry.y)\nData: \(entry.x)\nLimite: 12")
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        screen.setLabel("Toque em uma barra")
    }
}
