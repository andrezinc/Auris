//
//  ColorRoundedRectangle.swift
//  Absorve-Visual
//
//  Created by Alana Queiroz on 17/11/25.
//


import SwiftUI

struct ColorRoundedRectangle: View {
    var color: Color
    var cornerRadius = 16.0
    var textTitle: String?
    var text: String?
    
    // Altura mínima para o retangulo
    var minHeight: CGFloat = 60
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Título
            if let title = textTitle {
                HStack {
                    Text(title)
                        .font(.title2)
                        .foregroundColor(.verdeSecundario)
                    Spacer()
                }
            }
            
            // Descrição/Corpo
            if let description = text {
                HStack {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
        }
        .accessibilityElement(children: .combine)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(minHeight: minHeight) //Garante que o retângulo tenha uma altura mínima
        .background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.backgroundRetangulo)
                .shadow(color: color, radius: 0, x: -5, y: 0)
        }
    }
}

#Preview {
    // Exemplo ara ver o espaçamento:
    VStack(spacing: 8) {
        ColorRoundedRectangle(
            color: .verdeSecundario,
            textTitle: "Tipo de uso",
            text: "Diário."
        )
        
        ColorRoundedRectangle(
            color: .verdeSecundario,
            textTitle: "Características",
            text: "Sem abas; cobertura suave; não possui indicação de tamanho (único); fluxo baixo."
        )
    }
    .padding()
}
