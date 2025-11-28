//
//  Camera.swift
//  Absorve-Visual
//
//  Created by Beatriz Perotto Muniz on 07/11/25.
//

import Foundation
import OpenAI


struct Absorvente : Codable, JSONSchemaConvertible {
    var nome: String
    var fluxo: String
    var temAbas: String
    var cobertura: String
    var tamanho: String
    var categoria: String
    var quantidade: Int
    var temFragancia: String
    var descricaoGeral: String

    static let example: Self = .init(
                nome: "Absorvente Always",
                fluxo: "baixo",
                temAbas: "sim",
                cobertura: "seca",
                tamanho: "P",
                categoria: "diario",
                quantidade: 10,
                temFragancia: "sim",
                descricaoGeral: "Absorvente com embalagem rosa e branca"
            )
    
    init(nome: String = "", fluxo: String = "", temAbas: String = "", cobertura: String = "", tamanho: String = "", categoria: String = "", quantidade: Int = 0, temFragancia: String = "", descricaoGeral: String = "") {
        self.nome = nome
        self.fluxo = fluxo
        self.temAbas = temAbas
        self.cobertura = cobertura
        self.tamanho = tamanho
        self.categoria = categoria
        self.quantidade = quantidade
        self.temFragancia = temFragancia
        self.descricaoGeral = descricaoGeral
    }
}


//Descreva detalhadamente a imagem de um produto absorvente seguindo as instruções abaixo:
//    1.    Informações principais (obrigatórias):
//    •    Nome: (Nome completo do produto conforme aparece na embalagem)
//    •    Tipo do produto: (Informe se tem abas ou não; se a cobertura é suave ou seca; se houver tamanho — P, M, G, XG, XXG — inclua)
//    •    Categoria: (Indique se é noturno, diário ou normal)
//    •    Quantidade: (Número de absorventes contido na embalagem)
//    •    Fragrância: (Informe se o produto tem fragrância ou não)
//    2.    Descrição geral:
//Faça uma descrição ampla e clara da embalagem, incluindo:
//    •    Cores predominantes
//    •    Elementos visuais (ícones, ilustrações, logotipos, selos, destaques como “novo”, “proteção”, etc.)
//    •    Textos em destaque (e.g. “tripla proteção”, “5x absorção”, “fluxo intenso”, “4 unidades grátis”)
//    •    Material visualizado (plástico, brilho, transparência)
//    •    Contexto da foto, caso visível (e.g. sobre uma mesa, com computador ao fundo, iluminação do ambiente)

