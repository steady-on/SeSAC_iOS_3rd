//
//  LanguageTarget.swift
//  LanguageTranslator
//
//  Created by Roen White on 2023/08/13.
//

import Foundation

enum SourceLanguageType: String, CaseIterable {
    case detectLangs
    case ko
    case en
    case ja
    case zhCN = "zh-CN"
    case zhTW = "zh-TW"
    case vi
    case id
    case th
    case de
    case ru
    case es
    case it
    case fr
    
    var expression: String {
        switch self {
        case .detectLangs: return "자동감지"
        case .ko: return "한국어"
        case .en: return "영어"
        case .ja: return "일본어"
        case .zhCN: return "중국어 간체"
        case .zhTW: return "중국어 번체"
        case .vi: return "베트남어"
        case .id: return "인도네시아어"
        case .th: return "태국어"
        case .de: return "독일어"
        case .ru: return "러시아어"
        case .es: return "스페인어"
        case .it: return "이탈리아어"
        case .fr: return "프랑스어"
        }
    }
}

enum TargetLanguageType: String, CaseIterable {
    case ko
    case en
    case ja
    case zhCN = "zh-CN"
    case zhTW = "zh-TW"
    case vi
    case id
    case th
    case de
    case ru
    case es
    case it
    case fr
    
    var expression: String {
        switch self {
        case .ko: return "한국어"
        case .en: return "영어"
        case .ja: return "일본어"
        case .zhCN: return "중국어 간체"
        case .zhTW: return "중국어 번체"
        case .vi: return "베트남어"
        case .id: return "인도네시아어"
        case .th: return "태국어"
        case .de: return "독일어"
        case .ru: return "러시아어"
        case .es: return "스페인어"
        case .it: return "이탈리아어"
        case .fr: return "프랑스어"
        }
    }
}

