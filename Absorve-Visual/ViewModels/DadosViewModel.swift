//
//  SwiftUIView.swift
//  Absorve-Visual
//
//  Created by Beatriz Perotto Muniz on 07/11/25.
//

import OpenAI
import SwiftUI

//o que isso faz : chama o chat, mosrra se esta carregando
class DadosViewModel: ObservableObject {
    //esta carregando
    //image
    @Published var estaCaregando: Bool = false
    @Published var absorventeDescricao: Absorvente = Absorvente()
    @Published var dadosAbsorvente: [ComponentData] = [ComponentData]()

    private let repositorio = ChatGPTRepository()
    
    func chamarGPT(base64String: String) {
        estaCaregando = true

        Task{
            do{
//                print("chamei")
                //funcao chamar gpt
                let absorvente = try await repositorio.descreverImagemJson(imagemBase64: base64String)
                await MainActor.run {
                    absorventeDescricao = absorvente
                    conversaoDadoAbsorvente()
                    estaCaregando = false
                }
            }catch{
                await MainActor.run {
                    estaCaregando = false
                }
            }
            
        }
    }
    func conversaoDadoAbsorvente() {
        if (absorventeDescricao.nome != "não encontrado"){
            let descricao = absorventeDescricao
            
            let descricaoAbas = (descricao.temAbas == "Não" || descricao.temAbas == "não") ? "Sem abas" : "Com abas"
            let descricaoTamanho = (descricao.tamanho.contains("ão")) ? "não possui indicação de tamanho (único)" : "tamanho \(descricao.tamanho)"
            let descricaoFragancia = (descricao.temFragancia == "Não" || descricao.temFragancia == "não") ? "Sem fragrância" : "Com fragrância"
            
            let caracteristicas = "\(descricaoAbas); cobertura \(descricao.cobertura); \(descricaoTamanho); fluxo \(descricao.fluxo)"
            
            dadosAbsorvente = [
                ComponentData(title: "Tipo de uso", text: descricao.categoria.prefix(1).uppercased() + descricao.categoria.dropFirst().lowercased()),
                ComponentData(title: "Características", text: caracteristicas),
                ComponentData(title: "Quantidade", text: "\(String(descricao.quantidade)) protetores"),
                ComponentData(title: "Fragrância", text: descricaoFragancia)
            ]
        }
        else{
            dadosAbsorvente = [
                ComponentData(title: "Tipo de uso", text: ""),
                ComponentData(title: "Características", text: ""),
                ComponentData(title: "Quantidade", text: ""),
                ComponentData(title: "Fragrância", text: "")
            ]
        }
    }
    
    func inicializar(base64String:String){
        chamarGPT(base64String: base64String)
    }
    
}

struct ComponentData {
    let title: String
    let text: String
    
    init(title: String = "", text: String = "") {
        self.title = title
        self.text = text
    }
}
