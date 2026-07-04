//
//  GraficoLinhaV0Component.swift
//  TableView
//
//  Created by Rodrigo Takumi on 20/06/26.
//

import UIKit
import DGCharts

final class GraficoLinhaV0Component: UIView {
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.text = "destalhe"
        return view
    }()
    
    private lazy var chartView: LineChartView = {
        let view  = LineChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupChart()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupChart()
    }

    private func setupChart() {
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.scaleYEnabled = false
        
        chartView.xAxis.labelPosition = .bottom
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
        chartView.notifyDataSetChanged()
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)

        let lastIndex = Double(values.count - 1)
        let highlight = Highlight(x: lastIndex, y: values.last ?? 0, dataSetIndex: 0)
        self.chartView.highlightValue(highlight, callDelegate: true)
    }
    
    // MARK: - Setup UI
    private func setupView() {
        addSubview(valueLabel)
        addSubview(chartView)
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            chartView.heightAnchor.constraint(equalToConstant: 200),
            chartView.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            chartView.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension GraficoLinhaV0Component: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        valueLabel.text = "Valor: \(entry.y) - Data: \(entry.x) - Limite: 12"
        
//        UIView.animate(withDuration: 0.2) {
//            self.valueLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//        }
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
    }
}
