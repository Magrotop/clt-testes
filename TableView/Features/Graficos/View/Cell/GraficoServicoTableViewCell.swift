//
//  GraficoServicoTableViewCell.swift
//  TableView
//
//  Created by Rodrigo Takumi on 04/07/26.
//

import UIKit

class GraficoServicoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "GraficoServicoTableViewCell"
    
    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.text = "descricao"
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var accessoryImageView: UIImageView = {
        let chevronImage = UIImage(systemName: "chevron.right")
        let view = UIImageView(image: chevronImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Configure
    func setTitulo(_ valor: String) {
        valueLabel.text = valor
    }
    
    // MARK: - Setup
    private func setupLayout() {
        backgroundColor = .clear
        
        contentView.addSubview(content)
        content.addSubview(valueLabel)
        content.addSubview(accessoryImageView)
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            valueLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 12),
            valueLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            valueLabel.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -12),

            accessoryImageView.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 4),
            accessoryImageView.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            accessoryImageView.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor)
        ])
    }
}
