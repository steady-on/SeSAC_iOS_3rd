//
//  ViewController.swift
//  PracticeDiffableDataSource
//
//  Created by Roen White on 2023/09/15.
//

import UIKit

struct FocusMode: Hashable {
    let id = UUID().uuidString
    let title: String
    let subTitle: String?
    let icon: String
    let iconColor: UIColor?
}

class ViewController: UIViewController {
    
    enum SectionType: Int, CaseIterable {
        case modeSettings
        case shareToAllDevices
        case statusOfFocus
        
        var footer: String {
            switch self {
            case .modeSettings:
                return "집중 모드를 사용하여 기기를 사용자화하고 통화 및 알림 소리가 울리지 않도록 할 수 있습니다. 제어 센터에서 집중 모드를 켜고 끌 수 있습니다."
            case .shareToAllDevices:
                return "집중 모드는 모든 기기에 걸쳐 공유되며, 이 기기에서 집중모드를 켜면 다른 모든 기기에서도 그 집중 모드가 켜집니다."
            case .statusOfFocus:
                return "앱에 권한을 허용하면 해당 앱이 집중 모드 중에는 알림 소리가 울리지 않는다는 것을 공유할 수 있습니다."
            }
        }
    }
    
    private let focusModes = [
        FocusMode(title: "방해금지 모드", subTitle: nil, icon: "moon.fill", iconColor: .systemIndigo),
        FocusMode(title: "개인 시간", subTitle: nil, icon: "person.fill", iconColor: .systemPurple),
        FocusMode(title: "수면", subTitle: nil, icon: "bed.double.fill", iconColor: .systemMint),
        FocusMode(title: "업무", subTitle: "설정", icon: "lanyardcard.fill", iconColor: .systemTeal)
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

