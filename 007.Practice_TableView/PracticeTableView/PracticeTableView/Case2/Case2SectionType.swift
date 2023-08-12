//
//  Case2SectionType.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/27.
//

import Foundation

enum Case2SectionType: Int, CaseIterable {
    case totalSetUp
    case personalSetUp
    case etc
    
    var title: String {
        switch self {
        case .totalSetUp:
            return "전체 설정"
        case .personalSetUp:
            return "개인 설정"
        case .etc:
            return "기타"
        }
    }
    
    static private let menuOfTotalSetUp = ["공지사항", "실험실", "버전 정보"]
    static private let menuOfPersonalSetUp = ["개인/보안", "알림", "채팅", "멀티프로필"]
    static private let menuOfEtc = ["고객센터", "도움말"]
    
    var menu: [String] {
        switch self {
        case .totalSetUp:
            return Case2SectionType.menuOfTotalSetUp
        case .personalSetUp:
            return Case2SectionType.menuOfPersonalSetUp
        case .etc:
            return Case2SectionType.menuOfEtc
        }
    }
}
