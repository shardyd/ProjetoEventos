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
    var eventos = [Eventos]()

    //MARK: funcoes API carrega detalhes
    public func buscarDetalheEventosViaApi (idEvento: String) -> EventoDetalhe? {
        //-- url para buscar os eventos, estava com http mas so aceita https
        let urlString = "https://5f5a8f24d44d640016169133.mockapi.io/api/events/\(idEvento)"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return parseJSONDetalheEvento(quoteData: data)
            }
        }

        return nil
    }

    //-- decodificar o json para usar na array
    func parseJSONDetalheEvento(quoteData: Data) -> EventoDetalhe? {
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
    
    //MARK: funcoes api chamada eventos
    
    //MARK: funcoes swift
    func buscarEventosViaApi () -> [Eventos] {
        //-- url para buscar os eventos, estava com http mas so aceita https
        let urlString = "https://5f5a8f24d44d640016169133.mockapi.io/api/events"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                //let str = String(decoding: data, as: UTF8.self)
                //let data2 = Data(str.utf8)
                eventos = parseJSON(quoteData: data)
            }
        }
        
        return eventos
    }

    //-- decodificar o json para usar na array
    func parseJSON(quoteData: Data) -> [Eventos] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Eventos].self, from: quoteData)
            eventos = decodedData
        } catch {
            print(error)
            return eventos
        }

        return eventos
    }
 
}

