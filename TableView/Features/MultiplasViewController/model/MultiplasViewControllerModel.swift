//
//  Model.swift
//  TableView
//
//  Created by Rodrigo Takumi on 27/05/26.
//

enum  MultiplasListItem {
    case tipo(MultiplasResponseModel)
    case infos(MultiplasPadraoModel)
}

enum MultiplasStatusRequest {
    case loading
    case sucesso([MultiplasResponseModel])
    case sucessoA([MultiplasPadraoModel])
    case erro
}

struct MultiplasResponseModel {
    let tipo: String
    let segmento: String
    let infosA: [InfosA]?
    let infosB: [InfosB]?
    
    struct InfosA {
        let nome: String
        let descricao: String
        let tipo: String
    }
    
    struct InfosB {
        let lugar: String
        let valor: String
    }
}

struct MultiplasPadraoModel {
    let tipo: String
    let dados: [(tipo: String, valor: String)]
}

extension MultiplasResponseModel.InfosA {
    func converteParaPadraoModel() -> MultiplasPadraoModel {
        return MultiplasPadraoModel(
            tipo: "Infos A",
            dados: [
                (tipo: "nome", valor: nome),
                (tipo: "descricao", valor: descricao),
                (tipo: "tipo", valor: tipo)
            ]
        )
    }
}

extension MultiplasResponseModel.InfosB {
    func converteParaPadraoModel() -> MultiplasPadraoModel {
        return MultiplasPadraoModel(
            tipo: "Infos B",
            dados: [
                (tipo: "lugar", valor: lugar),
                (tipo: "valor", valor: valor)
            ]
        )
    }
}
