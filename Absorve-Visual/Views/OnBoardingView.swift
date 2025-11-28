//
//  OnBoardingView.swift
//  Absorve-Visual
//
//  Created by Beatriz Perotto Muniz on 12/11/25.
//

import SwiftUI

struct OnBoardingView: View {
    @Environment(\.dismiss) private var dismiss

    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack {
                                        
                    Image(.onboarding)
                        .accessibilityLabel("Ilustração de uma cesta de mercado, com um balão sobreposto contendo ondas sonoras dentro. Ao redor, é apresentado três ícones: absorvente normal, noturno e interno ao redor.")
                    
                    VStack {
                        Text("Conheça o Auris")
                            .bold()
                            .font(.largeTitle)
                            .foregroundStyle(.verdeSecundario)
                            .padding(.bottom,18)
                            .padding(.horizontal,6)
                        
                        VStack(alignment: .leading, spacing : 24) {
                            HStack(alignment:.top){
                                Image(systemName: "camera")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.trailing,5)
                                    .accessibilityHidden(true)
                                VStack(alignment:.leading){
                                    Text("Tire uma foto")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text("Use a câmera para tirar uma foto e o app lerá a descrição do produto em voz alta.")
                                }
                                .accessibilityElement(children: .combine)
                            }
                            HStack(alignment:.top){
                                Image(systemName: "waveform")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.trailing,9)
                                    .accessibilityHidden(true)
                                VStack(alignment:.leading){
                                    Text("Receba sua descrição")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text("Veja primeiro os dados principais, depois, uma descrição completa.")
                                }
                                .accessibilityElement(children: .combine)//vai ler de uma vez
                            }
                        }
                        
                    }
                    .padding(.bottom,41)
                    .padding(.horizontal,52)
                    
                    Button{
                        hasSeenOnboardingView = true
                    } label:{
                        HStack{
                            Text("Continuar")
                                .font(.headline)
                                .foregroundStyle(Color(UIColor.systemBackground))
                        }
                        .padding(.vertical,16)
                        //.padding(.horizontal, 80)
                        .frame(minWidth:300)
                        .background(.verdeSecundario)
                        .cornerRadius(24)
                        
                    }
                    
                }
                .padding(.bottom, 77)
                .padding(.top,24)
                
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(.verdePrimario)
        .onDisappear {
            hasSeenOnboardingView = true
        }
    }
        
}


#Preview {
    OnBoardingView()
}
