//
//  CarregandoView.swift
//  Absorve-Visual
//
//  Created by Andre Castilhano on 17/11/25.
//

import SwiftUI
struct CarregandoView: View {
    @State private var anima: Int = 0
    private let timer = Timer.publish(every: 0.7, on: .main, in: .common).autoconnect()
    private let textoCarregando: String = "Carregando"

    var body: some View {
        
        VStack(spacing: 40){
            ZStack{
                
                EllipticalGradient(
                    stops: [
                        Gradient.Stop(color: .degrade, location: 0.00),
                        Gradient.Stop(color: .verdePrimario, location: 1.00),
                    ],
                    center: UnitPoint(x: 0.5, y: 0.5)
                ).ignoresSafeArea()
                VStack{
                    Image("anima\(anima)")
                        .resizable()
                        .frame(width: 238,height: 238)
                        .onReceive(timer) { _ in
                            anima = (anima + 1) % 4
                        }
                        .accessibilityRemoveTraits(.isImage)
                        .accessibilityLabel("Há uma animação de quadrado verde-claro contendo o logo do Auris, que é um ícone de um carrinho de compras com um balão contendo diferentes ícones")
                        .accessibilityHint("Animação")
                    
                    Text(textoCarregando)
                        .font(.largeTitle)
                        .bold()
                }
            }
        }

    }
}
