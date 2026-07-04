//
//  GraficoScreen.swift
//  TableView
//
//  Created by Rodrigo Takumi on 20/06/26.
//

import UIKit
import DGCharts

class GraficoScreen: UIView {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(
            GraficoTableViewCell.self,
            forCellReuseIdentifier: GraficoTableViewCell.reuseIdentifier)
        view.register(
            GraficoServicoTableViewCell.self,
            forCellReuseIdentifier: GraficoServicoTableViewCell.reuseIdentifier)
        view.register(
            GraficoEditarTableViewCell.self,
            forCellReuseIdentifier: GraficoEditarTableViewCell.reuseIdentifier)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setDelegateTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    private func setupView() {
        backgroundColor = .systemGroupedBackground
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
