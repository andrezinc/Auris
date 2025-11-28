//
//  SwiftUIView.swift
//  Absorve-Visual
//
//  Created by Beatriz Perotto Muniz on 07/11/25.
//
import OpenAI
import Foundation

protocol QuestoesRepository{
    func respostaChagptJson(
        
    ) async throws -> Absorvente
    func respostaChagptString(
    ) async throws -> String
    func descreverImagemJson(
        imagemBase64: String,
    ) async throws -> Absorvente
    func descreverImagemString(
        imagemBase64: String,
    ) async throws -> String
}
final class ChatGPTRepository : QuestoesRepository{
    private let gpt: OpenaiService
    private let modeloIA: Model = .gpt4_o_mini
    private let prompt = """
        Caso a imagem não mostrar nenhum tipo de absorvente descreva em todas os campos como não encontrado
        Descreva detalhadamente a imagem de um produto absorvente seguindo as instruções abaixo:
            1.    Informações principais (obrigatórias):
            •    Nome: (Nome completo do produto conforme aparece na embalagem)
            •   Fluxo do Absorvente: (Informe se o fluxo é para alto, medio ou baixo) 
            •    Tipo do produto: (Informe se tem abas ou não; se a cobertura é suave ou seca; se houver tamanho — P, M, G, XG, XXG — inclua)
            •    Categoria: (Indique se é noturno, diário ou normal)
            •    Quantidade: (Número de absorventes contido na embalagem)
            •    Fragrância: (Informe se o produto tem fragrância ou não)
            2.    Descrição geral:
        Faça uma descrição ampla e clara da embalagem, incluindo:
            •    Cores predominantes
            •    Elementos visuais (ícones, ilustrações, logotipos, selos, destaques como “novo”, “proteção”, etc.)
            •    Textos em destaque (e.g. “tripla proteção”, “5x absorção”, “fluxo intenso”, “4 unidades grátis”)
            •    Material visualizado (plástico, brilho, transparência)
            •    Contexto da foto, caso visível (e.g. sobre uma mesa, com computador ao fundo, iluminação do ambiente)
        
        A resposta deve ser objetiva, estruturada e descritiva, mantendo linguagem neutra e informativa, sem julgamentos ou opiniões.
        
        """
    init(
        gpt: OpenaiService = PadraoOpenaiService()
    ) {
        self.gpt = gpt
    }
    func respostaChagptJson() async throws -> Absorvente {
        return try await gpt.getTextoParaTextoJsonConvertible(textoUsario: prompt, modeloChat: modeloIA, nomeConversaoJson: "Absorvente") as Absorvente
    }
    
    func respostaChagptString() async throws -> String {
        return try await gpt.getTextoParaTexto(textoUsario: prompt, modeloChat: modeloIA)
    }
    
    func descreverImagemJson(imagemBase64: String) async throws -> Absorvente {
        
        let resultado = "data:image/jpeg;base64,\(imagemBase64)"
        
        return try await gpt.getImagemParaTextoJsonConvertible(textoParadescricao: prompt, imagemBase64urlComExtensao: resultado, modeloChat: modeloIA, nomeConversaoJson: "Absorvente") as Absorvente
    }
    
    func descreverImagemString(imagemBase64: String) async throws -> String {
        let resultado = "data:image/jpeg;base64,\(imagemBase64)"

        return try await gpt.getImagemParaTexto(textoParadescricao: prompt, imagemBase64urlComExtensao: resultado, modeloChat: modeloIA)

    }
}
