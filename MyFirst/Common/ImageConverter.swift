import UIKit

class ImageConverter {
    // UIImage To String
    static func ImageToString(image: UIImage) -> String? {
        // Dataへの変換が成功していたら
        if let pngData = image.pngData() {
              // BASE64のStringに変換する
              return pngData.base64EncodedString()
        } else {
            return nil
        }
    }
    
    // String To UIImage
    static func StringToImage(imageString: String) -> UIImage? {
        // 空白を+に変換する
        let base64String = imageString.replacingOccurrences(of: "", with: "+")
 
        // BASE64の文字列をデコードしてDataを生成
        if let data = Data(base64Encoded: base64String) {
            // DataからUIImageを生成
            let image = UIImage(data: data)
            
            return image
        } else {
            return nil
        }
    }
    
    // UIImage To Compressed Data
    static func imageToData(image: UIImage) -> NSData? {
        if let pngData = image.pngData() {
            if let compressedData = try? (pngData as NSData).compressed(using: .zlib) {
                return compressedData
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func dataToImage(nsData: NSData) -> UIImage? {
        if let data: Data = try? nsData.decompressed(using: .zlib) as Data {
            return UIImage(data: data)
        }
        
        return nil
    }
}

extension UIImage {
    //データサイズを変更する
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
