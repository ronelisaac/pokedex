//
//  UIImage+Colors.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import UIKit
import SwiftUI

extension UIImage {
    var dominantColor: UIColor? {
        guard let cgImage = self.cgImage else { return nil }
        
        let width = 1, height = 1
        
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        var pixelData = [UInt8](repeating: 0, count: 4)
        
        let ctx = CGContext(
            data: &pixelData,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 4,
            space: colorSpace,
            bitmapInfo: bitmapInfo
        )

        ctx?.draw(cgImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))

        return UIColor(
            red: CGFloat(pixelData[0]) / 255,
            green: CGFloat(pixelData[1]) / 255,
            blue: CGFloat(pixelData[2]) / 255,
            alpha: 1
        )
    }
}

extension Image {
    func asUIImage() -> UIImage? {
        // Renderizamos la Image de SwiftUI a UIImage
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let size = CGSize(width: 200, height: 200)
        view?.bounds = CGRect(origin: .zero, size: size)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}
