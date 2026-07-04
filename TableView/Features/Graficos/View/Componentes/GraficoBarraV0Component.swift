//
//  GraficoBarraV0Component.swift
//  TableView
//
//  Created by Rodrigo Takumi on 20/06/26.
//

import UIKit
import DGCharts

final class GraficoBarraV0Component: UIView {
    
    var lastIndex: Double = .zero
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.text = "descricao"
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var chartView: BarChartView = {
        let view  = BarChartView()
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

        chartView.dragEnabled = true
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = true
        chartView.scaleYEnabled = false
        chartView.dragYEnabled = false

        chartView.rightAxis.enabled = false

        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.granularity = 1

        chartView.legend.enabled = false
        
        chartView.animate(yAxisDuration: 0.6)
    }

    // MARK: - Public API
    func configure(values: [Double], labels: [String]) {

        var entries: [BarChartDataEntry] = []

        for i in 0..<values.count {
            entries.append(BarChartDataEntry(x: Double(i), y: values[i]))
        }

        let dataSet = BarChartDataSet(entries: entries, label: "Gráfico de Barra")
        dataSet.colors = [.systemBlue]
        dataSet.drawValuesEnabled = true

        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.8
        
        chartView.data = data
        chartView.notifyDataSetChanged()
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)

        self.lastIndex = Double(values.count - 1)
            
        self.chartView.setVisibleXRangeMaximum(4*4)
        self.chartView.moveViewToX(self.lastIndex)
            
        let highlight = Highlight(x: self.lastIndex, y: values.last ?? 0, dataSetIndex: 0)
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

extension GraficoBarraV0Component: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        valueLabel.text = "Valor: \(entry.y) - Data: \(entry.x) - Limite: 12"
        
//        UIView.animate(withDuration: 0.2) {
//            self.valueLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//        }
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
    }
}
