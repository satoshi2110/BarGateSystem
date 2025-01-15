

//- 対象課題: 駐車場のゲートバー

//  - STEP1: 仕様を考えてリスト化
//    - 入り口
//     - ICカードがタッチされる
//     - ICカードが承認済みの場合にバーを上げる
//     - 車がゲートを通り過ぎる
//     - バーを下げる
//    - 出口
//     - 車がゲートに近づく
//     - バーを上げる
//     - 車がゲートを通り過ぎる
//     - バーを下げる
//  - STEP2: Swiftで実装
//  - STEP3: 例外ケースを考えてリスト化
//    - 認証されていないICカードがタッチされる
//    - バーを車が通り過ぎない間は、バーを下げない
//  - STEP4: 例外ケースを考慮したコードに書き換える




import UIKit

protocol GatePassLicenseDelegate {
    func openGate()
    
}

class CarUser {
    
    var delegate: GatePassLicenseDelegate?
    
    func touchCard() {
        guard let delegate = delegate else {
            // 支払いをしていない場合
            print("認証されていないカードです")
            return
        }
        if type(of: delegate) == Paid.self {
            delegate.openGate()
        }
    }
}

class Paid: GatePassLicenseDelegate {
    func openGate() {
        print("バーが開きます")
    }
    
}
class GateBarSystem {
    private var passThroughTheGate = false
    
    // 車が通過後にバーを閉じる
    func closeBar() {
        if passThroughTheGate {
            print("バーが閉じます。")
            passThroughTheGate = false
        } else {
            print("車を前進させてください。")
        }
    }
    
    // 車が通過する動作をシミュレーション
    func carPasses() {
        print("車がゲートを通過しました。")
        passThroughTheGate = true
    }
}
class ExitGateBarSystem {
    private var getCloseTheGate = false
    private var passThroughTheGate = false
    
    func openBar() {
        if getCloseTheGate {
            print("バーが開きます")
            getCloseTheGate = false
        } else {
            print("もっと前進して下さい")
        }
    }
    
    // 車が通過後にバーを閉じる
    func closeBar() {
        if passThroughTheGate {
            print("バーが閉じます。")
            passThroughTheGate = false
        } else {
            print("車を前進させてください。")
        }
    }
    
    // 車が通過する動作をシミュレーション
    func carPasses() {
        print("車がゲートを通過しました。")
        passThroughTheGate = true
    }
}

//駐車料金を支払い済みの太郎

let taro = CarUser()
taro.delegate = Paid()
taro.touchCard()

//入り口
let gateBarSystem = GateBarSystem()
gateBarSystem.carPasses()
gateBarSystem.closeBar()

//出口
let exitGateBarSystem = ExitGateBarSystem()
exitGateBarSystem.openBar()
gateBarSystem.carPasses()
gateBarSystem.closeBar()

//駐車料金を未払いの花子
var hanako = CarUser()
hanako.touchCard()

