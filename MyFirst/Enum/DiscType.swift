import UIKit

enum DiscType {
    case new
    case album
    case single
}

enum NewDisc: CaseIterable {
    case streamingStart
    case newAlbumAndTour2019SpSite
    case auroraArk
    case auroraArkTour
    case aurora
    
    func getDisc() -> CompactDisc {
        switch self {
        case .streamingStart:
            return CompactDisc(title: "音源ストリーミング配信スタート", artwork: UIImage(named: "newDisc1"))
        case .newAlbumAndTour2019SpSite:
            return CompactDisc(title: "New Album &amp; Live Tour 2019 Special Site", artwork: UIImage(named: "newDisc2"))
        case .auroraArk:
            return CompactDisc(title: "aurora ark", artwork: UIImage(named: "newDisc3"))
        case .auroraArkTour:
            return CompactDisc(title: "BUMP OF CHICKEN TOUR 2019 aurora ark", artwork: UIImage(named: "newDisc4"))
        case .aurora:
            return CompactDisc(title: "Aurora", artwork: UIImage(named: "newDisc5"))
        }
    }
}

enum AlbumDisc: CaseIterable {
    case auroraArc
    case butterflies
    case ray
    case best1
    case best2
    
    func getDisc() -> CompactDisc {
        switch self {
        case .auroraArc:
            return CompactDisc(title: "aurora arc", artwork: UIImage(named: "newDisc3"))
        case .butterflies:
            return CompactDisc(title: "Butterflies", artwork: UIImage(named: "album_butterflies"))
        case .ray:
            return CompactDisc(title: "RAY", artwork: UIImage(named: "album_ray"))
        case .best1:
            return CompactDisc(title: "BUMP OF CHICKEN I", artwork: UIImage(named: "alubum_best1"))
        case .best2:
            return CompactDisc(title: "BUMP OF CHICKEN Ⅱ", artwork: UIImage(named: "alubum_best2"))
        }
    }
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
    case helloWorld
    case parade
    case fighter
    case youWereHere
    case nijiWoMatsuHito
    
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
        case .helloWorld:
            return CompactDisc(title: "Hello,world!/コロニー", artwork: UIImage(named: "single_hello_world"))
        case .parade:
            return CompactDisc(title: "パレード", artwork: UIImage(named: "single_parade"))
        case .fighter:
            return CompactDisc(title: "ファイター", artwork: UIImage(named: "single_fighter"))
        case .youWereHere:
            return CompactDisc(title: "You were here", artwork: UIImage(named: "single_you_were_here"))
        case .nijiWoMatsuHito:
            return CompactDisc(title: "虹を待つ人", artwork: UIImage(named: "single_nijiwomatsuhito"))
        }
    }
}
