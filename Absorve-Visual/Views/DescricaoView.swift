//
//  SwiftUIView.swift
//  Absorve-Visual
//
//  Created by Beatriz Perotto Muniz on 07/11/25.
//

import SwiftUI

struct DescricaoView: View {
    @StateObject var dadosViewModel = DadosViewModel()
    @State private var opacidade: Double = 1.0
    var base64String: String
    @AccessibilityFocusState private var focused: Bool
    let componentColor: Color = Color.verdeSecundario
    
    
    // Função para mapear os dados do ViewModel para uma lista de ComponentData
 
    
    var estaCarregandoLocal: Bool {
        return dadosViewModel.estaCaregando
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
            if estaCarregandoLocal{
                CarregandoView()
                
            }else{
                ZStack(alignment: .bottom) {
                    ScrollView {
                        
                        VStack(alignment: .leading,spacing: 24) {
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text(dadosViewModel.absorventeDescricao.nome)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.top, 16)
                                    .accessibilityFocused($focused)
                                
                                VStack(spacing: 20) {
                                    Rectangle()
                                        .fill(Color(.systemGray4))
                                        .frame(height: 1)
                                }
                                .frame(maxWidth: .infinity, minHeight: 40)
                                
                                ForEach(dadosViewModel.dadosAbsorvente, id: \.title) { data in
                                    ColorRoundedRectangle(
                                        color: componentColor,
                                        textTitle: data.title,
                                        text: data.text
                                    )
                                }
                                
                                VStack (alignment: .leading,spacing: 24) {
                                    Text("Descrição geral:")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    let texto = (dadosViewModel.absorventeDescricao.nome != "não encontrado") ? dadosViewModel.absorventeDescricao.descricaoGeral :"Não há descrição disponível."
                                    Text("\(texto)")
                                        .font(.body)
                                        .fontWeight(.regular)
                                }
                                .padding(.top, 8)
                                // .cornerRadius(24)
                                
                                Spacer()
                                    .frame(height: 120)
                                
                                
                            }
                            .padding(.horizontal, 24)
                            .frame(maxWidth: .infinity)
                        }
                    }.background(BackgroundGradient())
                    
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                               Image(systemName: "camera")
                               Text("Voltar para câmera")
                                  .fontWeight(.semibold)
                            }
                            .foregroundColor(.backgroundPrimary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.verdeSecundario)
                            .cornerRadius(24)
                          }
                         .padding(.horizontal, 24)
                         .padding(.bottom, 24)
                }.onAppear(){
                    focused = true
                }
                }
            }
                .onAppear {
                    dadosViewModel.inicializar(base64String: base64String)
                }
                .navigationBarBackButtonHidden(dadosViewModel.estaCaregando)
            
            
            
                .ignoresSafeArea()
            
        }
}

#Preview {
    NavigationView {
        ZStack {
            BackgroundGradient()
            DescricaoView(base64String: "base64_teste")
        }
    }
}

