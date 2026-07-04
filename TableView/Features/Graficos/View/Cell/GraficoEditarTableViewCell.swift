//
//  GraficoHeaderComponent.swift
//  TableView
//
//  Created by Rodrigo Takumi on 04/07/26.
//

import UIKit

protocol GraficoEditarTableViewCellDelegate: AnyObject {
    func didTapEditButton(isEditing: Bool)
}

class GraficoEditarTableViewCell: UITableViewCell {
        
    static let reuseIdentifier = "GraficoEditarTableViewCell"
    
    weak var delegate: GraficoEditarTableViewCellDelegate?
    private var isTableEditing = false
    
    // Instancie seus elementos exatamente como fez antes (sempre com contentView)
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let editButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Editar"
        configuration.imagePadding = 4
        
        let button = UIButton(configuration: configuration)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    @objc private func editButtonTapped() {
        // Altera o estado interno
        isTableEditing.toggle()
        
        // Atualiza o texto e ícone do botão visualmente
        editButton.configuration?.title = isTableEditing ? "Salvar" : "Editar"
        
        // Avisa a ViewController que o botão foi clicado passando o novo estado
        delegate?.didTapEditButton(isEditing: isTableEditing)
    }
    
    private func setupLayout() {
        isSelected = false
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(editButton)
        
        // Alvo de ação do clique do botão
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            // Label colada no lado esquerdo
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: editButton.leadingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Botão colado no lado direito
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ])
    }
}
