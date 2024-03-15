//
//  WLLanguageManager.swift
//  NEW
//
//  Created by wulin on 2022/2/15.
//

import UIKit

public class WLLanguageManager {

    
    
    public static let shared = WLLanguageManager()
    private static let userDefaultsKey = "current_language"
    private static let defautLanguage = "en"

    init() {
        currentLanguage = WLLanguageManager.storedCurrentLanguage ?? WLLanguageManager.defautLanguage
    }

    static var languageImages: [String: UIImage?] {
    
        [
            //"th": RImage.taiyu(),
            "en": RImage.flag_yg(),
            "zh-Hans": RImage.flag_zg()
        ]
    }
    
    /// 可用的语言
    public static var availableLanguages: [String] {
       
//        Bundle.main.localizations.sorted()
        //"th"
        return ["en", "zh-Hans"]
    }

    /// 当前语言
    public var currentLanguage: String {
        didSet {
            storeCurrentLanguage()
        }
    }

    /// 当前语言展示的名字
    public var currentLanguageDisplayName: String? {
        displayName(language: currentLanguage)
    }
    
    public var currentLanguageDisplayImage: UIImage? {
        displayImage(language: currentLanguage)
    }

    /// 根据语言国际化展示的名字
    public func displayName(language: String) -> String? {
//        (currentLocale as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: language)?.capitalized
        switch language {
        case "en":
            return "English"
        case "zh-Hans":
            return "Chinese"
        default:
            return (currentLocale as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: language)?.capitalized
        }
    }
    
    public func displayImage(language: String) -> UIImage? {
        WLLanguageManager.languageImages[language] ?? nil
    }
    
    /// 原始语言显示名称
    public static func nativeDisplayName(language: String) -> String? {
        let locale = NSLocale(localeIdentifier: language)
        return locale.displayName(forKey: NSLocale.Key.identifier, value: language)?.capitalized
    }
}

extension WLLanguageManager {

    /// 存储当前语言
    private func storeCurrentLanguage() {
        UserDefaults.standard.set(currentLanguage, forKey: WLLanguageManager.userDefaultsKey)
    }

    /// 获取存设置的语言
    private static var storedCurrentLanguage: String? {
        UserDefaults.standard.value(forKey: userDefaultsKey) as? String
    }

    /// 推荐语言
    private static var preferredLanguage: String? {
        Bundle.main.preferredLocalizations.first { availableLanguages.contains($0) }
    }
}

extension WLLanguageManager {

    public var currentLocale: Locale {
        Locale(identifier: currentLanguage)
    }
}

extension WLLanguageManager {

    public func localize(string: String, bundle: Bundle?) -> String {
        if let languageBundleUrl = bundle?.url(forResource: currentLanguage, withExtension: "lproj"), let languageBundle = Bundle(url: languageBundleUrl) {
            return languageBundle.localizedString(forKey: string, value: nil, table: nil)
        }

        return string
    }

//    public func localize(string: String, bundle: Bundle?, arguments: [CVarArg]) -> String {
//        String(format: localize(string: string, bundle: bundle), locale: currentLocale, arguments: arguments)
//    }
}

public extension String {

    /// 国际化扩展
    var wlLocalized: String {
        WLLanguageManager.shared.localize(string: self, bundle: Bundle.main)
    }

}
