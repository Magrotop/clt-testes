//
//  GraficoTableViewCell.swift
//  TableView
//
//  Created by Rodrigo Takumi on 04/07/26.
//

import UIKit
import DGCharts

class GraficoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "GraficoTableViewCell"
    
    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var filtroData: UISegmentedControl = {
        let view = UISegmentedControl(items:  ["Resumo", "24h"])
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
            }
        }
        view.addAction(acao, for: .valueChanged)
        
        return view
    }()
    
    private var chartBarra = GraficoBarraV0Component()
    private var chartLinha = GraficoLinhaV0Component()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Configure
    
    func setGrafico(valor: [Double], label: [String]) {
        chartBarra.configure(
            values: valor,
            labels: label
        )
        chartLinha.configure(
            values: valor,
            labels: label
        )
        chartLinha.isHidden = true
    }
    
    // MARK: - Setup
    private func setupLayout() {
        backgroundColor = .clear
        
        contentView.addSubview(content)
        content.addSubview(filtroData)
        content.addSubview(stackView)
        
        stackView.addArrangedSubview(chartBarra)
        stackView.addArrangedSubview(chartLinha)
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            filtroData.topAnchor.constraint(equalTo: content.topAnchor, constant: 12),
            filtroData.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            filtroData.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: filtroData.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -12)
        ])
    }
}
