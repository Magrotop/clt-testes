//
//  GraficoViewController.swift
//  TableView
//
//  Created by Rodrigo Takumi on 20/06/26.
//

import UIKit
import DGCharts

class GraficoViewController: UIViewController {

    private let key = "OrdemServicos"
    
    let screen = GraficoScreen()
    
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gráficos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        screen.setDelegateTableView(delegate: self, dataSource: self)
        
        validaOrdemServicos()
    }
    
    private func salvarOrdemServicos() {
        UserDefaults.standard.set(servicos, forKey: key)
    }
    
    private func validaOrdemServicos() {
        if let ordemSalva = UserDefaults.standard.stringArray(forKey: key) {
            let saoIguais = Set(ordemSalva) == Set(servicos)
            if !saoIguais {
                atualizarListaNoUserDefaults(com: servicos)
            } else {
                servicos = ordemSalva
            }
        } else {
            salvarOrdemServicos()
        }
    }
    
    func atualizarListaNoUserDefaults(com novosItensDaAPI: [String]) {
        let chave = "OrdemServicos"
        let defaults = UserDefaults.standard
        
        // 1. Recupera a lista antiga que já estava salva (ou cria uma vazia)
        let listaLocalAntiga = defaults.stringArray(forKey: chave) ?? []
        
        // 2. Transforma as duas em Set para fazer operações rápidas
        let setAPI = Set(novosItensDaAPI)
        let setLocal = Set(listaLocalAntiga)
        
        // 3. Descobre quais itens vieram na API mas NÃO estavam no local (Itens Realmente Novos)
        // subtract() faz: novosItensDaAPI menos listaLocalAntiga
        let itensRealmenteNovos = setAPI.subtracting(setLocal)
        
        // 4. Descobre quais itens devem ser mantidos (Estavam no local E continuam vindo na API)
        // intersection() pega apenas o que existe em ambos ao mesmo tempo
        let itensMantidos = listaLocalAntiga.filter { setAPI.contains($0) }
        
        // 5. Junta os novos itens (no topo) com os itens mantidos (embaixo)
        // Convertemos o Set de novos itens para Array antes de somar
        let listaFinalAtualizada = Array(itensRealmenteNovos) + itensMantidos
        
        // 6. Salva a nova lista limpa e ordenada de volta no UserDefaults
        defaults.set(listaFinalAtualizada, forKey: chave)
    }
    
    //MockDados
    let valores: [Double] = [
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
    
    //1,4,2,3
    //5,1,2,3
    var servicos = ["Item 1", "Item 2", "Item 3", "Item 5"]
}

extension GraficoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return servicos.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: GraficoTableViewCell.reuseIdentifier,
                for: indexPath) as! GraficoTableViewCell
            cell.setGrafico(valor: valores, label: labels)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: GraficoEditarTableViewCell.reuseIdentifier,
                for: indexPath) as! GraficoEditarTableViewCell
            cell.titleLabel.text = "Serviços monitorados"
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: GraficoServicoTableViewCell.reuseIdentifier,
                for: indexPath) as! GraficoServicoTableViewCell
            cell.setTitulo(servicos[indexPath.row])
            return cell
        }
    }
    
    // Mantém a possibilidade de reordenar
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 2 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = servicos.remove(at: sourceIndexPath.row)
        servicos.insert(movedItem, at: destinationIndexPath.row)
        
        salvarOrdemServicos()
    }
    
    // Remove o botão vermelho de exclusão
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension GraficoViewController: GraficoEditarTableViewCellDelegate {
    func didTapEditButton(isEditing: Bool) {
        // Ativa ou desativa nativamente as bolinhas vermelhas de exclusão da TableView com animação
        screen.tableView.setEditing(isEditing, animated: true)
    }
}
