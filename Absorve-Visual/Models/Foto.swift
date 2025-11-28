//
//  Camera.swift
//  Absorve-Visual
//
//  Created by Beatriz Perotto Muniz on 07/11/25.
//

import Foundation

struct Foto {
    var id : UUID
    var caminho : String

   init(caminho: String = "") {
       self.id = UUID()
        self.caminho = caminho
    }
    
}
