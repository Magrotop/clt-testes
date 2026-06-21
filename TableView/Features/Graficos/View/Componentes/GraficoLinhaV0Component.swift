//
//  GraficoLinhaV0Component.swift
//  TableView
//
//  Created by Rodrigo Takumi on 20/06/26.
//

import UIKit
import DGCharts

final class GraficoLinhaV0Component: UIView {
    
    private let valueLabel = UILabel()
    private let chartView = LineChartView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupChart()
        
        valueLabel.numberOfLines = 0
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupChart()
        
        valueLabel.numberOfLines = 0
    }
    
    func setDelegate(_ delegate: ChartViewDelegate) {
        chartView.delegate = delegate
    }

    // MARK: - Setup UI

    private func setupView() {
        addSubview(valueLabel)
        addSubview(chartView)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            chartView.heightAnchor.constraint(equalToConstant: 200),
            chartView.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 16),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupChart() {
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.scaleYEnabled = false
        
        chartView.xAxis.labelPosition = .bottom
        
//        chartView.dragEnabled = true
//        chartView.setScaleEnabled(false)
//        chartView.pinchZoomEnabled = true
//        chartView.scaleYEnabled = false
//        chartView.dragYEnabled = false
//
//        chartView.rightAxis.enabled = false
//
//        chartView.xAxis.labelPosition = .bottom
//        chartView.xAxis.granularity = 1
//
//        chartView.legend.enabled = false
//        
//        chartView.animate(yAxisDuration: 0.6)
    }

    // MARK: - Public API

    func configure(values: [Double], labels: [String]) {

        var entries: [ChartDataEntry] = []

        for i in 0..<values.count {
            entries.append(ChartDataEntry(x: Double(i), y: values[i]))
        }

        let dataSet = LineChartDataSet(entries: entries, label: "Gráfico de Barra")
        dataSet.colors = [.systemBlue]
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        
        let data = LineChartData(dataSet: dataSet)

        chartView.data = data

        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)

        chartView.notifyDataSetChanged()
        
        chartView.data = data
        chartView.notifyDataSetChanged()

        DispatchQueue.main.async {
            let lastIndex = Double(values.count - 1)
            
//            self.chartView.setVisibleXRangeMaximum(6*4)
//            self.chartView.moveViewToX(lastIndex)
            
            // simula seleção do último valor
            let highlight = Highlight(x: lastIndex, y: values.last ?? 0, dataSetIndex: 0)
            self.chartView.highlightValue(highlight, callDelegate: true)
        }
    }
    
    func setLabel(_ valor: String) {
        valueLabel.text = valor
        
        UIView.animate(withDuration: 0.2) {
            self.valueLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
}
