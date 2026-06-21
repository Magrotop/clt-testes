//
//  ComponentePadraoTableViewCell.swift
//  TableView
//
//  Created by Rodrigo Takumi on 06/06/26.
//

import UIKit

class ComponentePadraoTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ComponentePadraoTableViewCell"

    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let titulo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup
    private func setupLayout() {
        contentView.addSubview(content)
        content.addSubview(titulo)
        content.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titulo.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
            titulo.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 24),
            titulo.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -24),
            
            stackView.topAnchor.constraint(equalTo: titulo.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Configure
    func setupTitulo(_ valor: String) {
        titulo.text = valor
    }
    
    func addComponente(view: [UIView]) {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        view.forEach({ stackView.addArrangedSubview($0) })
    }
}
