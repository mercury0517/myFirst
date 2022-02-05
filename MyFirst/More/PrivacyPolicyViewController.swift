import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController, WKUIDelegate {
    var webView = WKWebView()
    let htmlString = HTMLGenarator.privacyPolicy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.webView)
    }
    
    private func configSubViews() {
        self.webView.uiDelegate = self
        
        
        let baseURL = URL(fileURLWithPath: NSTemporaryDirectory())
        self.webView.loadHTMLString(self.htmlString, baseURL: baseURL)
    }
    
    private func applyStyling() {
        self.webView.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.webView.autoPinEdgesToSuperviewEdges()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class TermOfUseViewController: UIViewController, WKUIDelegate {
    var webView = WKWebView()
    let htmlString = HTMLGenarator.termOfUse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.configSubViews()
        self.applyStyling()
        self.addConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.webView)
    }
    
    private func configSubViews() {
        self.webView.uiDelegate = self
        
        
        let baseURL = URL(fileURLWithPath: NSTemporaryDirectory())
        self.webView.loadHTMLString(self.htmlString, baseURL: baseURL)
    }
    
    private func applyStyling() {
        self.webView.backgroundColor = .white
    }
    
    private func addConstraints() {
        self.webView.autoPinEdgesToSuperviewEdges()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class HTMLGenarator {
    static func privacyPolicy() -> String {
        return "<!DOCTYPEhtml><html><head><metacharset='utf-8'><metaname='viewport'content='width=device-width'><title><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">プライバシーポリシー</font></font></title><style>body{font-family:'HelveticaNeue',Helvetica,Arial,sans-serif;padding:1em;}</style></head><body><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">プライバシーポリシー</font></font></strong><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[開発者/会社名]は、DIGITアプリを[オープンソース/フリー/フリーミアム/広告サポート/商用]アプリとして構築しました。</font><fontstyle=\"vertical-align:inherit;\">このサービスは、[開発者/会社名][無料]によって提供され、そのまま使用することを目的としています。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">このページは、誰かが[my/our]サービスを使用することを決定した場合に、個人情報の収集、使用、および開示に関する[my/our]ポリシーについて訪問者に通知するために使用されます。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[my/our]サービスを使用することを選択した場合は、このポリシーに関連する情報の収集と使用に同意するものとします。</font><fontstyle=\"vertical-align:inherit;\">[I/We]が収集する個人情報は、本サービスの提供および改善に使用されます。</font><fontstyle=\"vertical-align:inherit;\">[I/We]は、このプライバシーポリシーに記載されている場合を除き、お客様の情報を使用したり、他人と共有したりすることはありません。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">このプライバシーポリシーで使用される用語は、このプライバシーポリシーで特に定義されていない限り、DIGITでアクセスできる利用規約と同じ意味を持ちます。</font></font></p><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">情報の収集と使用</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">より良い体験のために、[I/We]は、当社のサービスを使用している間、特定の個人を特定できる情報を提供するように要求する場合があります[ここに収集した他の情報（ユーザー名、住所、場所、写真など）を追加してください][I/私たち]のリクエストは[あなたのデバイスに保持され、[私/私たち]によって収集されることはありません]/[私たちによって保持され、このプライバシーポリシーに記載されているように使用されます]。</font></font></p><!----><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">ログデータ</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[I/We]は、[my/our]サービスを使用するたびに、アプリでエラーが発生した場合に[I/We]がLogという電話でデータと情報を（サードパーティ製品を介して）収集することをお知らせしますデータ。</font><fontstyle=\"vertical-align:inherit;\">このログデータには、デバイスのインターネットプロトコル（「IP」）アドレス、デバイス名、オペレーティングシステムのバージョン、[my/our]サービスを利用する際のアプリの構成、サービスの使用日時などの情報が含まれる場合があります、およびその他の統計。</font></font></p><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">クッキー</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">Cookieは、匿名の一意の識別子として一般的に使用される少量のデータを含むファイルです。</font><fontstyle=\"vertical-align:inherit;\">これらは、アクセスしたWebサイトからブラウザに送信され、デバイスの内部メモリに保存されます。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">このサービスは、これらの「Cookie」を明示的に使用しません。</font><fontstyle=\"vertical-align:inherit;\">ただし、アプリは、情報を収集してサービスを改善するために「Cookie」を使用するサードパーティのコードとライブラリを使用する場合があります。</font><fontstyle=\"vertical-align:inherit;\">これらのCookieを受け入れるか拒否するかを選択し、Cookieがデバイスに送信されるタイミングを知ることができます。</font><fontstyle=\"vertical-align:inherit;\">当社のCookieを拒否することを選択した場合、このサービスの一部を使用できない場合があります。</font></font></p><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">サービスプロバイダー</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[I/We]は、以下の理由により、サードパーティの企業および個人を雇用する場合があります。</font></font></p><ul><li><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">私たちのサービスを促進するために;</font></font></li><li><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">当社に代わってサービスを提供するため。</font></font></li><li><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">サービス関連サービスを実行するため。</font><fontstyle=\"vertical-align:inherit;\">また</font></font></li><li><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">私たちのサービスがどのように使用されているかを分析するのを支援するため。</font></font></li></ul><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[私/私たち]は、これらの第三者が個人情報にアクセスできることをこのサービスのユーザーに通知したいと思います。</font><fontstyle=\"vertical-align:inherit;\">その理由は、私たちに代わって彼らに割り当てられたタスクを実行するためです。</font><fontstyle=\"vertical-align:inherit;\">ただし、他の目的で情報を開示または使用しない義務があります。</font></font></p><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">安全</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[私/私たち]は私たちにあなたの個人情報を提供することへのあなたの信頼を大切にします、それで私たちはそれを保護するために商業的に受け入れられる手段を使うよう努めています。</font><fontstyle=\"vertical-align:inherit;\">ただし、インターネットを介した送信方法や電子ストレージの方法は100％安全で信頼できるものではなく、[I/We]はその絶対的なセキュリティを保証できないことを忘れないでください。</font></font></p><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">他のサイトへのリンク</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">このサービスには、他のサイトへのリンクが含まれている場合があります。</font><fontstyle=\"vertical-align:inherit;\">サードパーティのリンクをクリックすると、そのサイトに移動します。</font><fontstyle=\"vertical-align:inherit;\">これらの外部サイトは[me/us]によって運営されていないことに注意してください。</font><fontstyle=\"vertical-align:inherit;\">したがって、[I/We]は、これらのWebサイトのプライバシーポリシーを確認することを強くお勧めします。</font><fontstyle=\"vertical-align:inherit;\">[私/私たち]は、第三者のサイトまたはサービスのコンテンツ、プライバシーポリシー、または慣行を管理することはできず、責任を負わないものとします。</font></font></p><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">子供のプライバシー</font></font></strong></p><!----><div><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">アプリは、あなたを識別するために使用される情報を収集する可能性のあるサードパーティのサービスを使用します。</font></font></p></div><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">このプライバシーポリシーの変更</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[I/We]は、プライバシーポリシーを随時更新する場合があります。</font><fontstyle=\"vertical-align:inherit;\">したがって、変更がないか定期的にこのページを確認することをお勧めします。</font><fontstyle=\"vertical-align:inherit;\">[I/We]は、このページに新しいプライバシーポリシーを掲載することにより、変更を通知します。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">このポリシーは2022-02-05から有効です。</font></font></p><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">お問い合わせ</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[my/our]プライバシーポリシーについて質問や提案がある場合は、遠慮なく[me/us]（digit6444@gmail.com）に連絡してください。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">このプライバシーポリシーページはprivacypolicytemplate.netで作成され、</font><ahref=\"https://app-privacy-policy-generator.nisrulz.com/\"target=\"_blank\"rel=\"noopenernoreferrer\"><fontstyle=\"vertical-align:inherit;\">AppPrivacy</font></a></font><ahref=\"https://privacypolicytemplate.net\"target=\"_blank\"rel=\"noopenernoreferrer\"><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">PolicyGenerator</font></font></a><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">によって変更/生成されました</font></font><ahref=\"https://app-privacy-policy-generator.nisrulz.com/\"target=\"_blank\"rel=\"noopenernoreferrer\"><fontstyle=\"vertical-align:inherit;\"></font></a></p></body></html>"
    }
    
    static func termOfUse() -> String {
        return "<!DOCTYPEhtml><html><head><metacharset='utf-8'><metaname='viewport'content='width=device-width'><title><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">利用規約</font></font></title><style>body{font-family:'HelveticaNeue',Helvetica,Arial,sans-serif;padding:1em;}</style></head><body><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">利用規約</font></font></strong><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">アプリをダウンロードまたは使用すると、これらの条件が自動的に適用されます。したがって、アプリを使用する前に、これらの条件を注意深くお読みください。</font><fontstyle=\"vertical-align:inherit;\">アプリ、アプリの一部、または当社の商標をいかなる方法でもコピーまたは変更することは許可されていません。</font><fontstyle=\"vertical-align:inherit;\">アプリのソースコードを抽出することは許可されていません。また、アプリを他の言語に翻訳したり、派生バージョンを作成したりしないでください。</font><fontstyle=\"vertical-align:inherit;\">アプリ自体、およびそれに関連するすべての商標、著作権、データベース権、およびその他の知的財産権は、引き続き[開発者/会社名]に帰属します。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[開発者/会社名]は、アプリが可能な限り有用で効率的であることを保証することをお約束します。</font><fontstyle=\"vertical-align:inherit;\">そのため、当社は、いつでも理由を問わず、アプリに変更を加えたり、そのサービスの料金を請求したりする権利を留保します。</font><fontstyle=\"vertical-align:inherit;\">何を支払っているのかを明確にしない限り、アプリやそのサービスの料金を請求することはありません。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">DIGITアプリは、[my/our]サービスを提供するために、お客様から提供された個人データを保存および処理します。</font><fontstyle=\"vertical-align:inherit;\">携帯電話とアプリへのアクセスを安全に保つのはあなたの責任です。</font><fontstyle=\"vertical-align:inherit;\">したがって、デバイスの公式オペレーティングシステムによって課せられたソフトウェアの制限や制限を取り除くプロセスである、電話をジェイルブレイクしたりルート化したりしないことをお勧めします。</font><fontstyle=\"vertical-align:inherit;\">携帯電話がマルウェア/ウイルス/悪意のあるプログラムに対して脆弱になり、携帯電話のセキュリティ機能が損なわれる可能性があり、DIGITアプリが正しく機能しないかまったく機能しない可能性があります。</font></font></p><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">この利用規約の変更</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[I/We]は、利用規約を随時更新する場合があります。</font><fontstyle=\"vertical-align:inherit;\">したがって、変更がないか定期的にこのページを確認することをお勧めします。</font><fontstyle=\"vertical-align:inherit;\">[I/We]は、このページに新しい利用規約を掲載して、変更を通知します。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">これらの利用規約は2022-02-05から有効です。</font></font></p><p><strong><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">お問い合わせ</font></font></strong></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">[my/our]の利用規約について質問や提案がある場合は、遠慮なく[me/us]（digit6444@gmail.com）に連絡してください。</font></font></p><p><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">この利用規約ページは、</font></font><ahref=\"https://app-privacy-policy-generator.nisrulz.com/\"target=\"_blank\"rel=\"noopenernoreferrer\"><fontstyle=\"vertical-align:inherit;\"><fontstyle=\"vertical-align:inherit;\">アプリのプライバシーポリシージェネレーターによって生成されました</font></font></a></p></body></html>"
    }
}
