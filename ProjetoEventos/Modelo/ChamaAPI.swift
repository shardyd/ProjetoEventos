//
//  ChamaAPI.swift
//  ProjetoEventos
//
//  Created by Chardson Miranda on 13/03/21.
//

import Foundation
import UIKit

class ChamaAPI{
    //MARK: variavel
    var eventoDetalhe = [EventoDetalhe]()

    //MARK: funcoes API
    public func buscarEventosViaApi (idEvento: String) -> EventoDetalhe? {
        //-- url para buscar os eventos, estava com http mas so aceita https
        let urlString = "https://5f5a8f24d44d640016169133.mockapi.io/api/events/\(idEvento)"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return parseJSON(quoteData: data)
            }
        }

        return nil
    }

    //-- decodificar o json para usar na array
    func parseJSON(quoteData: Data) -> EventoDetalhe? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(EventoDetalhe.self, from: quoteData)
            
            return decodedData
            //self.setupView(detalhes: decodedData)
            
        } catch {
            print(error)
            return nil
        }
    }

}

