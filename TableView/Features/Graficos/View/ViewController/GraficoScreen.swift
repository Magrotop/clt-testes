//
//  GraficoScreen.swift
//  TableView
//
//  Created by Rodrigo Takumi on 20/06/26.
//

import UIKit
import DGCharts

class GraficoScreen: UIView {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let valueLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itens = ["Resumo", "24h"]
    private lazy var filtroData: UISegmentedControl = {
        let view = UISegmentedControl(items: self.itens)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selectedSegmentIndex = 0
        
        // 2. Use UIAction (closure interna da View) para capturar o toque
        let acao = UIAction { [weak self] acao in
            guard let segmented = acao.sender as? UISegmentedControl else { return }
            // 3. Dispara a closure externa enviando o índice para a ViewController
            
            if (segmented.selectedSegmentIndex == 1) {
                self?.chartBarra.isHidden = true
                self?.chartLinha.isHidden = false
            } else {
                self?.chartBarra.isHidden = false
                self?.chartLinha.isHidden = true
                self?.chartBarra.atualizarInterfaceInterna(para: segmented.selectedSegmentIndex)
            }
        }
        view.addAction(acao, for: .valueChanged)
        
        return view
    }()
    
    private let chartBarra = GraficoBarraV0Component()
    private let chartLinha = GraficoLinhaV0Component()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configuracaoGraficoBarra()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setDelegate(_ delegate: ChartViewDelegate) {
        chartBarra.setDelegate(delegate)
        chartLinha.setDelegate(delegate)
    }
    
    func configuracaoGraficoBarra() {
        let values: [Double] = [
            10, 20, 5, 40, 30, 60, 25, 80, 50, 70, 5, 40, 10, 20, 5, 40, 30, 60, 25, 80, 50, 70, 5, 40,
            10, 20, 5, 40, 30, 60, 25, 80, 50, 70, 5, 40, 10, 20, 5, 40, 30, 60, 25, 80, 50, 70, 5, 40,
            10, 20, 5, 40, 30, 60, 25, 80, 50, 70, 5, 40, 10, 20, 5, 40, 30, 180, 25, 80, 50, 70, 5, 40,
            10, 20, 5, 40, 30, 60, 25, 80, 50, 70, 5, 40, 10, 20, 5, 40, 30, 60, 25, 80, 50, 70, 5, 40]
        let labels = [
            "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez",
            "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez",
            "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez",
            "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez",
            "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez",
            "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez",
            "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez",
            "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
        
        chartBarra.configure(
            values: values,
            labels: labels
        )
        chartLinha.configure(
            values: values,
            labels: labels
        )
        chartLinha.isHidden = true
    }
    
    func setLabel(_ valor: String) {
        valueLabel.text = valor
        
        UIView.animate(withDuration: 0.2) {
            self.valueLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
    private func setupView() {
        backgroundColor = .systemGroupedBackground
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(filtroData)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(chartBarra)
        stackView.addArrangedSubview(chartLinha)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            valueLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
        ])
    }
}
