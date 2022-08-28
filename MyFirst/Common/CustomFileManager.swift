import Foundation
import UIKit

class CustomFileManager {
    func getFileURL(fileName: String) -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    func saveImage(_ image: UIImage) {
        // 画像をjpegDataに変換する
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }

        // ファイル名について考える
        do {
            try imageData.write(to: self.getFileURL(fileName: "IMG12345.jpg"))
        } catch {
            print("fail to save image")
        }
    }
}
