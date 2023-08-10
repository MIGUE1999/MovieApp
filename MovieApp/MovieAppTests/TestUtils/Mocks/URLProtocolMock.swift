//
//  URLProtocolMock.swift
//  MovieAppTests
//
//  Created by Tejada Ortigosa Miguel Angel on 10/8/23.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    // Verifica si el protocolo puede llevar a cabo la request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    // Convierte la request a una request canónica. Ejemplo: https//:server/hero/ID -> https//:server/hero/id
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    // Se llama cuando la request finaliza o se completa
    override func stopLoading() {}
    
    // Se llama al inicio de la request
    override func startLoading() {
        
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Hay que inicializar el handler para inyector el url protocol mock")
        }
        
        do {
            // Llamar al handler y pasamos la request hacia arriba para comprobar que es válida
            let (response, data) = try handler(request)
            
            // Asignarle al respuesta al cliente
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            // Asignarle al cliente la data en caso de que llegue
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            // Se informa al cliente de que la request ha finalizado
            client?.urlProtocolDidFinishLoading(self)
            
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}
