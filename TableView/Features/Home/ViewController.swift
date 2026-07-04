//
//  ViewController.swift
//  TableView
//
//  Created by Rodrigo Takumi on 26/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    private let titulosCelulas = [
        "MultiplasView",
        "Componentes",
        "Gráficos"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configView()
        
        title = "Home"
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    private func configView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titulosCelulas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titulosCelulas[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .systemRed
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            let viewController = MultiplasViewController()
            navigationController?.pushViewController(viewController, animated: true)
        } else if (indexPath.row == 1) {
            let viewController = ComponentesViewController()
            navigationController?.pushViewController(viewController, animated: true)
        } else if (indexPath.row == 2) {
            let viewController = GraficoViewController()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // Mantém a possibilidade de reordenar
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    // Remove o botão vermelho de exclusão
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
