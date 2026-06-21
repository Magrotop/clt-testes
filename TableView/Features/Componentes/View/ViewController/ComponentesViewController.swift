//
//  ComponentesViewController.swift
//  TableView
//
//  Created by Rodrigo Takumi on 06/06/26.
//

import UIKit

class ComponentesViewController: UIViewController {
    
    private let componentes = [
        "Sparkline"
    ]
    
    private let dadosSparkline: [CGFloat] = [
        150.2, 148.5, 155.0, 162.3, 9.1, 8.4, 5.0, 2.8, 150.2, 148.5, 155.0, 162.3, 159.1, 168.4, 165.0, 172.8,
        172.8, 150.2, 148.5, 155.0, 162.3, 159.1, 168.4, 165.0, 172.8, 150.2, 448.5, 455.0, 462.3, 459.1, 468.4, 465.0,
        172.8, 150.2, 148.5, 155.0, 162.3, 159.1, 168.4, 165.0, 172.8, 150.2, 148.5, 155.0, 162.3, 159.1, 168.4, 165.0,
        172.8, 150.2, 148.5, 155.0, 162.3, 159.1, 168.4, 165.0, 172.8, 150.2, 148.5, 155.0, 162.3, 759.1, 768.4, 165.0,
        172.8, 150.2, 148.5, 155.0, 162.3, 159.1, 168.4, 165.0, 172.8, 150.2, 148.5, 155.0, 162.3, 159.1, 168.4, 165.0,
        172.8, 150.2, 148.5, 155.0, 162.3, 159.1, 168.4, 165.0, 172.8, 150.2, 148.5, 155.0, 162.3, 759.1, 768.4, 165.0
    ]
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.register(ComponentePadraoTableViewCell.self,
                      forCellReuseIdentifier: ComponentePadraoTableViewCell.reuseIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configView()
        
        title = "Componentes"
        view.backgroundColor = .lightGray
    }
    
    private func configView() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ComponentesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        componentes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ComponentePadraoTableViewCell.reuseIdentifier,
            for: indexPath) as! ComponentePadraoTableViewCell
        
        let sparkline = SparklineView()
        sparkline.baselineValue = 155.0
        sparkline.baselineColor = .systemRed
        sparkline.lineColor = .systemBlue
        sparkline.lineWidth = 2.0
        sparkline.dataPoints = dadosSparkline
        
        let tituloSparkline = UILabel()
        tituloSparkline.text = "Um nome de serviço grande"
        tituloSparkline.numberOfLines = 0
        tituloSparkline.textColor = .black
        
        NSLayoutConstraint.activate([
            sparkline.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        cell.setupTitulo(componentes[indexPath.row])
        cell.addComponente(view: [tituloSparkline, sparkline])
        
        return cell
    }
}
