import UIKit

enum VideoType: CaseIterable {
    case nagareboshiNoShotai
    case nagareboshiNoShotaiSingWithGuitar
    case aurora
    case spica
    case hanashigashitaiyo
    case sirius
    
    func getImage() -> UIImage? {
        switch self {
        case .nagareboshiNoShotai:
            return UIImage(named: "nagareboshi_video")
        case .nagareboshiNoShotaiSingWithGuitar:
            return UIImage(named: "nagareboshi_guitar_video")
        case .aurora:
            return UIImage(named: "aurora_video")
        case .spica:
            return UIImage(named: "video_spica")
        case .hanashigashitaiyo:
            return UIImage(named: "video_hanashigashitaiyo")
        case .sirius:
            return UIImage(named: "video_sirius")
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .nagareboshiNoShotai:
            return "流れ星の正体"
        case .nagareboshiNoShotaiSingWithGuitar:
            return "流れ星の正体 弾き語り"
        case .aurora:
            return "Aurora"
        case .spica:
            return "Spica リリックビデオ"
        case .hanashigashitaiyo:
            return "話がしたいよ"
        case .sirius:
            return "シリウス"
        }
    }
}
