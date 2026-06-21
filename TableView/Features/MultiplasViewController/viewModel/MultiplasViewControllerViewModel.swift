//
//  MultiplasViewControllerViewModel.swift
//  TableView
//
//  Created by Rodrigo Takumi on 27/05/26.
//

class MultiplasViewControllerViewModel {
    
    var onStateRequest: ((MultiplasStatusRequest) -> Void)?
    private(set) var state: MultiplasStatusRequest = .loading {
        didSet { onStateRequest?(state) }
    }

    var response: [MultiplasResponseModel]?
    private(set) var dataSource = [MultiplasListItem]()
    
    func fetch() {
        response = mockDados
        
        if let lista = response {//?.map({ MultiplasListItem.tipo($0) }) {
//            dataSource = lista
            state = .sucesso(lista)
        }
    }
    
    func upDateDataSourceIndoA(by dados: MultiplasResponseModel) {
        if let lista = dados.infosA?.map({ $0.converteParaPadraoModel() }) { //MultiplasListItem.infos($0.converteParaPadraoModel()) }) {
//            dataSource = lista
            state = .sucessoA(lista)
        }
    }
    
    func upDateDataSourceIndoB(by dados: MultiplasResponseModel) {
        if let lista = dados.infosB?.map({ $0.converteParaPadraoModel() }) {
//            dataSource = lista
            state = .sucessoA(lista)
        }
        
//        if let lista = dados.infosB?.map({ MultiplasListItem.infos($0.converteParaPadraoModel()) }) {
//            dataSource = lista
//            state = .sucesso
//        }
    }
    
    let mockDados = [
        MultiplasResponseModel(
            tipo: "tipo um",
            segmento: "segmento um",
            infosA: [
                MultiplasResponseModel.InfosA(
                    nome: "Tipo 1 Infos A 1",
                    descricao: "Tipo Um Infos A 1",
                    tipo: "Tipo 1 Infos A 1"),
                MultiplasResponseModel.InfosA(
                    nome: "Tipo 1 Infos A 2",
                    descricao: "Tipo 1 Infos A 2",
                    tipo: "Tipo 1 Infos A 2")
            ],
            infosB: [
                MultiplasResponseModel.InfosB(
                    lugar: "Tipo 1 Infos B 1",
                    valor: "Tipo Um Infos B 1")
            ]
        ),
        MultiplasResponseModel(
            tipo: "tipo dois",
            segmento: "segmento dois",
            infosA: [
                MultiplasResponseModel.InfosA(
                    nome: "Tipo 2 Infos A 1",
                    descricao: "Tipo 2 Infos A 1",
                    tipo: "Tipo 2 Infos A 1"),
                MultiplasResponseModel.InfosA(
                    nome: "Tipo 2 Infos A 2",
                    descricao: "Tipo 2 Infos A 2",
                    tipo: "Tipo 2 Infos A 2")
            ],
            infosB: [
                MultiplasResponseModel.InfosB(
                    lugar: "Tipo 1 Infos B 1",
                    valor: "Tipo Um Infos B 1")
            ]
        )
    ]
}
