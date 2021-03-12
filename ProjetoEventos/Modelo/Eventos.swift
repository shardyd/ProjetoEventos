//
//  File.swift
//  ProjetoEventos
//
//  Created by Horr on 12/03/21.
//

import Foundation

//MARK: api eventos
struct Eventos: Codable {
    let people: [String]
    let date: Int
    let description: String
    let image: String
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
    let id: String
}
