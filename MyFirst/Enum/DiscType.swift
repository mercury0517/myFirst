import UIKit

enum DiscType {
    case album
    case single
}

enum AlbumDisc: CaseIterable {
}

enum SingleDisc: CaseIterable {
    case nanairo
    case flare
    case acaciaGravity
    case acacia
    case gravity
    case aurora
    case hanashigashitaiyo
    case sirius
    case boennomarch
    case kinensatsuei
    case ribbon
    case answer
    case aria
    
    func getDisc() -> CompactDisc {
        switch self {
        case .nanairo:
            return CompactDisc(title: "なないろ", artwork: UIImage(named: "single_nanairo"))
        case .flare:
            return CompactDisc(title: "Flare", artwork: UIImage(named: "single_flare"))
        case .acaciaGravity:
            return CompactDisc(title: "アカシア/Gravity", artwork: UIImage(named: "single_acacia"))
        case .acacia:
            return CompactDisc(title: "アカシア", artwork: UIImage(named: "single_acacia"))
        case .gravity:
            return CompactDisc(title: "Gravity", artwork: UIImage(named: "single_gravity"))
        case .aurora:
            return CompactDisc(title: "Aurora", artwork: UIImage(named: "single_aurora"))
        case .hanashigashitaiyo:
            return CompactDisc(title: "話がしたいよ / シリウス / Spica", artwork: UIImage(named: "single_hanashigashitaiyo"))
        case .sirius:
            return CompactDisc(title: "シリウス", artwork: UIImage(named: "single_sirius"))
        case .boennomarch:
            return CompactDisc(title: "望遠のマーチ", artwork: UIImage(named: "single_boennomarch"))
        case .kinensatsuei:
            return CompactDisc(title: "記念撮影", artwork: UIImage(named: "single_kinensatsuei"))
        case .ribbon:
            return CompactDisc(title: "リボン", artwork: UIImage(named: "single_ribbon"))
        case .answer:
            return CompactDisc(title: "アンサー", artwork: UIImage(named: "single_answer"))
        case .aria:
            return CompactDisc(title: "アリア", artwork: UIImage(named: "single_aria"))
        }
    }
}
