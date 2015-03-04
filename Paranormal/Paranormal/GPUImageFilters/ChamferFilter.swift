import Foundation
import GPUImage

class ChamferFilter : GPUImageFilter {

    var depth : Float = 0.2
    var radius : Float = 10.0

    override init() {
        super.init(fragmentShaderFromFile: "Chamfer")
    }

    override init!(fragmentShaderFromString fragmentShaderString: String!) {
        super.init(fragmentShaderFromString: fragmentShaderString)
    }

    override init!(vertexShaderFromString vertexShaderString: String!,
            fragmentShaderFromString fragmentShaderString: String!) {
        super.init(vertexShaderFromString: vertexShaderString,
            fragmentShaderFromString: fragmentShaderString)
    }

    override func setupFilterForSize(filterFrameSize: CGSize) {
        super.setupFilterForSize(filterFrameSize)
        ThreadUtils.runGPUImage { () -> Void in
            self.setFloat(GLfloat(1.0/filterFrameSize.height), forUniformName: "texelHeight")
            self.setFloat(GLfloat(1.0/filterFrameSize.width), forUniformName: "texelWidth")
            self.setFloat(GLfloat(self.depth), forUniformName: "depth")
            self.setFloat(GLfloat(self.radius), forUniformName: "radius")
        }
    }
}
