import UIKit

enum VideoType: CaseIterable {
    case nagareboshiNoShotai
    case nagareboshiNoShotaiSingWithGuitar
    case aurora
    case spica
    case hanashigashitaiyo
    case sirius
    case boennomarch
    case rayPathfinder
    case liveBDDVDPathfinder
    case pathfinderStudioCoast
    case kinensatsuei
    case kinensatsueiLyric
    // あと38個...
    
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
        case .boennomarch:
            return UIImage(named: "video_boennomarch")
        case .rayPathfinder:
            return UIImage(named: "video_ray_pathfinder")
        case .liveBDDVDPathfinder:
            return UIImage(named: "video_live_bddvd_pathfinder")
        case .pathfinderStudioCoast:
            return UIImage(named: "video_pathfinder_studio_coast")
        case .kinensatsuei:
            return UIImage(named: "video_kinensatsuei")
        case .kinensatsueiLyric:
            return UIImage(named: "video_kinensatsuei_lyric")
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
        case .boennomarch:
            return "望遠のマーチ"
        case .rayPathfinder:
            return "ray LIVE MV from \"TOUR 2017-2018 PATHFINDER SAITAMA SUPER ARENA\""
        case .liveBDDVDPathfinder:
            return "LIVE BD/DVD「BUMP OF CHICKEN PATHFINDER SAITAMA SUPER ARENA」スポット"
        case .pathfinderStudioCoast:
            return "LIVE BD/DVD「BUMP OF CHICKEN PATHFINDER LIVE AT STUDIO COAST」スポット"
        case .kinensatsuei:
            return "記念撮影"
        case .kinensatsueiLyric:
            return "記念撮影 リリックビデオ"
        }
    }
}
