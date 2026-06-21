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
    
    private let chartView = BarChartView()

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
    
    func setDelegate(_ delegate: ChartViewDelegate) {
        chartView.delegate = delegate
    }
    
    func atualizarInterfaceInterna(para indice: Int) {
        
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            guard let self = self else { return }
            
            // Simula a filtragem ou cálculo dos dados com base no segmento clicado
        let qtdDados = indice == 0 ? Double(4*4) : Double((indice+1)*6*4)
            
            // OBRIGATÓRIO: Voltar para a Thread Principal para mexer na UI
//            DispatchQueue.main.async {
                
                // 1. Envie os novos dados para o seu gráfico
                // self.meuGraficoView.dados = novosDados
                
                // 2. Force o gráfico a se redesenhar com os novos dados
                self.chartView.notifyDataSetChanged()
                self.chartView.setVisibleXRangeMaximum(qtdDados)
                self.chartView.setVisibleXRangeMinimum(qtdDados)
                self.chartView.moveViewToX(self.lastIndex)
//                self.chartView.setNeedsDisplay()
//            }
//        }
    }

    // MARK: - Setup UI

    private func setupView() {
        addSubview(chartView)
        
        chartView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chartView.heightAnchor.constraint(equalToConstant: 200),
            chartView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
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
        
//        chartView.fitScreen()
        
//        chartView.autoScaleMinMaxEnabled = false
        
        // 👇 ESSENCIAL: efeito “Health app”
//        chartView.setVisibleXRangeMaximum(6)
//        chartView.setVisibleXRangeMinimum(3)
        
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
        
//        chartView.drawValueAboveBarEnabled = true
        chartView.data = data

        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)

        chartView.notifyDataSetChanged()
        
        chartView.data = data
        chartView.notifyDataSetChanged()

//        chartView.setVisibleXRangeMaximum(12)

        // opcional: começar do final (estilo Health)
//        chartView.moveViewToX(Double(values.count))

        DispatchQueue.main.async {
            self.lastIndex = Double(values.count - 1)
            
            self.chartView.setVisibleXRangeMaximum(4*4)
            self.chartView.moveViewToX(self.lastIndex)
            
            // simula seleção do último valor
            let highlight = Highlight(x: self.lastIndex, y: values.last ?? 0, dataSetIndex: 0)
            self.chartView.highlightValue(highlight, callDelegate: true)
        }
    }
}
