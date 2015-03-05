import Foundation
import CoreGraphics
import GPUImage
import Appkit

class ChamferTool {
    func perform(document: Document) {
        ThreadUtils.runGPUImageDestructive { () -> Void in
                if let imageData = document.currentLayer?.imageData {
                let image = NSImage(data: imageData)
                // Apply the filter
                let chamfer = ChamferFilter()

                let source = GPUImagePicture(image: image)
                source.addTarget(chamfer)

                chamfer.useNextFrameForImageCapture()
                source.processImage()

                let resultImage = chamfer.imageFromCurrentFramebuffer()

                //let resultImage = chamfer.imageByFilteringImage(image)
                document.currentLayer?.imageData = resultImage.TIFFRepresentation
            }
        }
    }
}
