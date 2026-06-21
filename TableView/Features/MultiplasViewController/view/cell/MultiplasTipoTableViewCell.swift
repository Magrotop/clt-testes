//
//  MultiplasTipoTableViewCell.swift
//  TableView
//
//  Created by Rodrigo Takumi on 28/05/26.
//

import UIKit

class MultiplasTipoTableViewCell: UITableViewCell {

    static let reuseIdentifier = "MultiplasTipoTableViewCell"

    private let labelTipo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let buttonTipoA: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tipo A", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let buttonTipoB: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tipo B", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Callbacks
    var onTipoAClick: (() -> Void)?
    var onTipoBClick: (() -> Void)?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupActions()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup
    private func setupLayout() {
        let buttonStack = UIStackView(arrangedSubviews: [buttonTipoA, buttonTipoB])
        buttonStack.spacing = 12
        buttonStack.translatesAutoresizingMaskIntoConstraints = false

        let mainStack = UIStackView(arrangedSubviews: [labelTipo, buttonStack])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    private func setupActions() {
        buttonTipoA.addTarget(self, action: #selector(didTapTipoA), for: .touchUpInside)
        buttonTipoB.addTarget(self, action: #selector(didTapTipoB), for: .touchUpInside)
    }

    @objc private func didTapTipoA() { onTipoAClick?() }
    @objc private func didTapTipoB() { onTipoBClick?() }

    // MARK: - Configure
    func configure(with tipo: MultiplasResponseModel) {
        labelTipo.text = tipo.tipo
    }
}
