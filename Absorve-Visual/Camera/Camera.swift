//
//  Camera.swift
//  Absorve-Visual
//
//  Created by Andre Castilhano on 18/11/25.
//


import AVFoundation
import SwiftUI

@Observable
class Camera: NSObject, AVCapturePhotoCaptureDelegate {
    var sessao = AVCaptureSession()
    var preview = AVCaptureVideoPreviewLayer()
    var fotoSaida = AVCapturePhotoOutput()
    
    private(set) var fotoDados: Data? = nil
    var temFoto: Bool = false
    private(set) var flash: Bool = false

    func cameraEstaAutorizada() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
            
        case .notDetermined:
            let status = await AVCaptureDevice.requestAccess(for: .video)
            return status
            
        case .restricted:
            return false
        case .denied:
            return false
            
        @unknown default:
            return false
        }
    }
    
    func setup() -> Bool{
        
        if !sessao.inputs.isEmpty {
                return true
            }
        fotoDados = nil
        temFoto = false
        sessao.beginConfiguration()
        guard let dispositivo = AVCaptureDevice.default( for: .video) else {
            return false
        }
        
        guard let dispositivoEntrada = try? AVCaptureDeviceInput(device: dispositivo) else {
            print("Unable to obtain video input.")
            return false
        }

        guard sessao.canAddInput(dispositivoEntrada) else {
            print("Unable to add device input to the capture session.")
            return false
        }
        
        guard sessao.canAddOutput(fotoSaida) else {
            print("Unable to add photo output to the capture session.")
            return false
        }
        sessao.addInput(dispositivoEntrada)
        sessao.addOutput(fotoSaida)
        sessao.sessionPreset = .photo
        
        sessao.commitConfiguration()
        Task(priority: .background) {
            sessao.startRunning()
        }
        return true
    }
    func capturarFoto(){
        let settings = AVCapturePhotoSettings(
                format: [AVVideoCodecKey: AVVideoCodecType.jpeg]
            )
        fotoSaida.capturePhoto(with: settings, delegate: self)
    }
    
    func ativarFlash()throws{
        guard let dispositivo = AVCaptureDevice.default(for: .video) else {
            return
        }
        guard dispositivo.isTorchAvailable else{
            return
        }
        
        try dispositivo.lockForConfiguration()
        flash = true
        dispositivo.torchMode = .on
        dispositivo.unlockForConfiguration()
        
    }
    
    func desativarFlash()throws{
        guard let dispositivo = AVCaptureDevice.default(for: .video) else {
            return
        }
        guard dispositivo.isTorchAvailable else{
            return
        }
        
        try dispositivo.lockForConfiguration()
        flash = false
        dispositivo.torchMode = .off
        dispositivo.unlockForConfiguration()
        
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        
        fotoDados = photo.fileDataRepresentation()
        temFoto = true

        sessao.stopRunning()
    }
    func tirarNovamente() {
        /// Reset both the `photoData` and `hasPhoto` variables to allow photo recapture.
        fotoDados = nil
        temFoto = false

        Task(priority: .background) {
            sessao.startRunning()
        }
    }
    func fotoDadosString() -> String{
        guard let dados = fotoDados else{
            return ""
        }
        return dados.base64EncodedString()
    }
}
