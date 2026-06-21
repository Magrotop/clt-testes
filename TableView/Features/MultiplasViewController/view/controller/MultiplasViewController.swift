//
//  MultiplasViewController.swift
//  TableView
//
//  Created by Rodrigo Takumi on 27/05/26.
//

import UIKit

class MultiplasViewController: UIViewController {
    
    private let viewModel = MultiplasViewControllerViewModel()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MultiplasTipoTableViewCell.self, forCellReuseIdentifier: MultiplasTipoTableViewCell.reuseIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configView()
        viewModel.fetch()
        
        title = "consolidado"
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

extension MultiplasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.state {
        case .loading:
            return UITableViewCell()
        case .sucesso(let dados):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MultiplasTipoTableViewCell.reuseIdentifier,
                for: indexPath) as! MultiplasTipoTableViewCell
            cell.configure(with: dados[indexPath.row])
            
            cell.onTipoAClick = { [weak self] in
                self?.viewModel.upDateDataSourceIndoA(by: dados[indexPath.row])
            }
            cell.onTipoBClick = { [weak self] in
                self?.viewModel.upDateDataSourceIndoB(by: dados[indexPath.row])
//                self?.viewModel.upDateDataSourceIndoB(by: tipo)
            }
            return cell
        case .sucessoA(let dados):
            return UITableViewCell()
//        case .sucesso:
//            switch viewModel.dataSource[indexPath.row] {
//            case .tipo(let tipo):
//                let cell = tableView.dequeueReusableCell(
//                    withIdentifier: MultiplasTipoTableViewCell.reuseIdentifier,
//                    for: indexPath) as! MultiplasTipoTableViewCell
//                cell.configure(with: tipo)
//                
//                cell.onTipoAClick = { [weak self] in
//                    self?.viewModel.upDateDataSourceIndoA(by: tipo)
//                }
//                cell.onTipoBClick = { [weak self] in
//                    self?.viewModel.upDateDataSourceIndoB(by: tipo)
//                }
//                return cell
//            case .infos(_):
//                return UITableViewCell()
//            }
        case .erro:
            return UITableViewCell()
        }
    }
}
