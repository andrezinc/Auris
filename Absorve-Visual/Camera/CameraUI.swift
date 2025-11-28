//
//  CameraUI.swift
//  Absorve-Visual
//
//  Created by Andre Castilhano on 19/11/25.
//

import SwiftUI

struct CameraUI: View {
    @State private var camera = Camera()
    @State private var didSetup = false
    @State var proximaPagina : Bool = false
    @ScaledMetric(relativeTo: .body) private var size: CGFloat = 1
    @State var conversaoData: String = ""
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                CameraPreview(camera: $camera)
                    .ignoresSafeArea()
                
                cameraControls
            }
            .navigationDestination(isPresented: $camera.temFoto) {
                DescricaoView(
                    base64String:(camera.fotoDadosString())
                )
            }
            .onAppear(){
                Task{
                    if await camera.cameraEstaAutorizada() {
                        didSetup = camera.setup()
                    } else {
                        print("Erro: sem acesso à câmera.")
                    }
                    
                    if !didSetup {
                        print("Falha ao configurar a câmera.")
                    }
                }
                camera.tirarNovamente()
            }
        }
    }
    
    @ViewBuilder
    var cameraControls: some View {
        HStack(spacing: 70){
            
            Spacer()
                .frame(width: 48)
                
            Button {
                camera.capturarFoto()
            } label: {
                ZStack{
                    Circle()
                        .fill(.clear)
                        .stroke(.white, lineWidth: 5.5)
                        .frame(width: 72)
                    Circle()
                        .fill(.white)
                        .frame(width: 55)//55
                }
            }
            .accessibilityLabel("Tirar foto")
            .buttonStyle(CaptureButtonStyle())
            
            Button {
                if(camera.flash){
                    do{
                        try camera.desativarFlash()
                    }
                    catch{
                        print("impossivel desativar flash")
                    }
                }else{
                    do{
                        try camera.ativarFlash()
                    }
                    catch{
                        print("impossivel ativar flash")
                    }
                }
            } label: {
                Circle()
                    .foregroundStyle(.grayWireframe)
                    .overlay{
                        Image(systemName: !camera.flash ? "bolt.slash.fill" :  "bolt.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 48, height: 48)
            }
            .accessibilityLabel("Flash")
            .accessibilityValue(!camera.flash ? "desativado" : "ativado")
            .buttonStyle(CaptureButtonStyle())
            
        }
        .background{
            Rectangle()
                .frame(minWidth: 800,minHeight: 140)
                .foregroundStyle(.black)
            .ignoresSafeArea()
        }

    }
}

struct CaptureButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
#Preview {
    CameraUI()
}
