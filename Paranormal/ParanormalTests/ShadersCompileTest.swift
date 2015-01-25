import Foundation
import Paranormal
import GPUImage
import Quick
import Nimble
import Cocoa

class ShadersCompileTest : QuickSpec {
    override func spec() {
        describe("The shader") {
            func test_single_input(name : String) {
                let filter = GPUImageFilter(fragmentShaderFromFile: name)
                let path = NSBundle(forClass:
                    ShadersCompileTest.self).pathForResource("blankImage", ofType: "png")
                let image = NSImage(contentsOfFile: path!)
                let res_img = filter.imageByFilteringImage(image)
                expect(res_img).toNot(beNil())
            }

            func test_two_input(name : String) {
                let filter = GPUImageTwoInputFilter(fragmentShaderFromFile: name)
                let path = NSBundle(forClass:
                    ShadersCompileTest.self).pathForResource("blankImage", ofType: "png")
                let image1 = NSImage(contentsOfFile: path!)
                let image2 = NSImage(contentsOfFile: path!)
                let picture1 = GPUImagePicture(image: image1)
                let picture2 = GPUImagePicture(image: image2)

                picture1.addTarget(filter)
                picture2.addTarget(filter)
                filter.useNextFrameForImageCapture()
                picture1.processImage()
                picture2.processImage()

                let res_img = filter.imageFromCurrentFramebuffer()
                expect(res_img).toNot(beNil())
            }

            it("ZUpInitilaize compiles") {
                test_single_input("ZUpInitialize")
            }

            it("MaskAlpha compiles") {
                test_single_input("MaskAlpha")
            }

            it("DepthToNormal compiles") {
                test_single_input("MaskAlpha")
            }

            it("BlendReorientedNormals compiles") {
                test_single_input("BlendReorientedNormals")
            }

            it("MultiplyMaxAlpha compiles") {
                test_two_input("MultiplyMaxAlpha")
            }
        }
    }
}
