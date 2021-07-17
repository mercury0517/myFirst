import UIKit

enum VideoType: CaseIterable {
    case nagareboshiNoShotai
    case nagareboshiNoShotaiSingWithGuitar
    case aurora
    
    func getImage() -> UIImage? {
        switch self {
        case .nagareboshiNoShotai:
            return UIImage(named: "nagareboshi_video")
        case .nagareboshiNoShotaiSingWithGuitar:
            return UIImage(named: "nagareboshi_guitar_video")
        case .aurora:
            return UIImage(named: "aurora_video")
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
        }
    }
}
