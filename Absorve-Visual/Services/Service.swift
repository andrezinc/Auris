//
//  SwiftUIView.swift
//  Absorve-Visual
//
//  Created by Beatriz Perotto Muniz on 07/11/25.
//
import Foundation
import OpenAI

protocol OpenaiService {
    var gpt: OpenAI {
        get
    }
}

final class PadraoOpenaiService: OpenaiService {
    let gpt: OpenAI
    init(
        gpt: OpenAI = OpenAI(
            apiToken: Segredinho.OPENAI_KEY
        )
    ) {
        self.gpt = gpt
    }
}

extension OpenaiService {
    func getTextoParaTextoJsonConvertible<T: JSONSchemaConvertible>(
        // não sei se faz sentido fazer um tipo tão generico se é algo tão especifico...
        // o JSONSchemaConvertible é do OpenAi há problema de acoplamento nessa parte
        textoUsario: String,
        modeloChat: Model,
        // ver dependencia desse modelo como explorar também para ser classe nossa
        nomeConversaoJson: String
    ) async throws -> T {
        let query = ChatQuery(
            messages: [
                .user(
                    .init(
                        content:
                        .string(
                            textoUsario
                        )
                    )
                ),
            ],

            model: modeloChat,
            responseFormat:
            .jsonSchema(
                .init(
                    name: nomeConversaoJson,
                    schema:
                    .derivedJsonSchema(
                        T.self
                    ),
                    strict: true
                )
            )
        )
        let result = try await gpt.chats(
            query: query
        )

        guard let process = result.choices.first?.message.content else {
            throw NSError(
                domain: "Erro ao processar texto Json",
                code: 42069
            ) // qualquer erro aqui vamos padronizar depois
        }
        return try JSONDecoder()
            .decode(
                T.self,
                from: Data(
                    process.utf8
                )
            )
    }

    func getTextoParaTexto(
        textoUsario: String,
        modeloChat: Model
    ) async throws -> String {
        let query = ChatQuery(
            messages: [
                .user(
                    .init(
                        content:
                        .string(
                            textoUsario
                        )
                    )
                ),
            ],

            model: modeloChat
        )
        let result = try await gpt.chats(
            query: query
        )

        guard let process = result.choices.first?.message.content else {
            throw NSError(
                domain: "Erro ao processar texto : String",
                code: 42070
            ) // qualquer erro aqui vamos padronizar depois enum
        }

        return process
    }

    func getImagemParaTextoJsonConvertible<T: JSONSchemaConvertible>(
        textoParadescricao: String,
        imagemBase64urlComExtensao: String,
        modeloChat: Model,
        nomeConversaoJson: String
    ) async throws -> T {
        let query = ChatQuery(
            messages: [
                .user(
                    .init(
                        content:
                        .contentParts(
                            [
                                .text(
                                    .init(
                                        text: textoParadescricao // texto recebido
                                    )
                                ),
                                .image(
                                    .init(
                                        imageUrl: .init(
                                            url: imagemBase64urlComExtensao,
                                            // base64 url
                                            // "data:image/jpeg;base64,\(base64Image)"
                                            detail: .auto // imutavel no repository...
                                        )
                                    )
                                ),
                            ]
                        )
                    )
                ),
            ],
            model: modeloChat,
            responseFormat:
            .jsonSchema(
                .init(
                    name: nomeConversaoJson,
                    schema:
                    .derivedJsonSchema(
                        T.self
                    ),
                    strict: true
                )
            )
        )
        let result = try await gpt.chats(
            query: query
        )

        guard let process = result.choices.first?.message.content else {
            throw NSError(
                domain: "Erro ao processar texto da imagem : Json",
                code: 42071
            ) // qualquer erro aqui vamos padronizar depois
        }
        return try JSONDecoder()
            .decode(
                T.self,
                from: Data(
                    process.utf8
                )
            )
    }

    func getImagemParaTexto(
        textoParadescricao: String,
        imagemBase64urlComExtensao: String,
        modeloChat: Model
    ) async throws -> String {
        let query = ChatQuery(
            messages: [
                .user(
                    .init(
                        content:
                        .contentParts(
                            [
                                .text(
                                    .init(
                                        text: textoParadescricao // texto recebido
                                    )
                                ),
                                .image(
                                    .init(
                                        imageUrl: .init(
                                            url: imagemBase64urlComExtensao,
                                            // base64 url
                                            // "data:image/jpeg;base64,\(base64Image)"
                                            detail: .auto // imutavel no repository...
                                        )
                                    )
                                ),
                            ]
                        )
                    )
                ),
            ],
            model: modeloChat
        )
        let result = try await gpt.chats(
            query: query
        )

        guard let process = result.choices.first?.message.content else {
            throw NSError(
                domain: "Erro ao processar texto da imagem : String",
                code: 42072
            ) // qualquer erro aqui vamos padronizar depois
        }
        return process
    }
}
