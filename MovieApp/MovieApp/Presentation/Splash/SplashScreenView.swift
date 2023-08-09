//
//  SplashScreenView.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 7/8/23.
//

import UIKit

class SplashScreenView: UIView {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        animateLogo()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        animateLogo()
    }

    private func setupViews() {
        backgroundColor = UIColor.white // Puedes ajustar el color de fondo a tu gusto

        addSubview(logoImageView)

        // Constraints para centrar el logo en la vista
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100), // Ajusta el ancho del logo
            logoImageView.heightAnchor.constraint(equalToConstant: 100) // Ajusta el alto del logo
        ])
    }

    private func animateLogo() {
        // Puedes agregar aquí cualquier animación que desees para el logo
        UIView.animate(withDuration: 2.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 2.0, animations: {
                self.logoImageView.transform = .identity
            }) { _ in
                // Cuando termine la animación, puedes notificar a tu AppDelegate o cambiar de vista para continuar con el flujo de la app.
            }
        }
    }
}
