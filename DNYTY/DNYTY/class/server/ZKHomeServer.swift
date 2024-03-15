//
//  ZKHomeServer.swift
//  DNYTY
//
//  Created by WL on 2022/6/7
//  
//
    

import UIKit
import Alamofire
import ObjectMapper
import RxAlamofire

class ZKHomeServer: NSObject {

    // MARK: 轮播
    struct BannerInfo: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            link <- map["link"]
            pic <- map["pic"]
            linkType <- map["link_type"]
        }
        
        var link: String = ""
        var linkType: Int = 0
        var pic: String = ""
    }
    
    func getBanner() -> Observable<[BannerInfo]> {
        ZKProvider.rx.request(.homeBanner()).mapServerArray(BannerInfo.self).asObservable()
    }
    
    // MARK: 游戏菜单
    
    struct Game: Mappable, IdentifiableType, Equatable {
        typealias Identity = Int
        var identity: Int {
            id
        }
        
        
        
        init?(map: Map) {
            
        }
        init() {
            
        }
        
        init(name: String, icon: UIImage?, childrens: [Game]) {
            self.name = name
            self.image = icon
            //把游戏标记为热门游戏
            self.childrens = childrens.map { game in
                var game = game
                game.isHot = true
                return game
            }
            self.id = -1
            self.isHot = true
        }
        
        
        mutating func mapping(map: Map) {
            id <- map["id"]
            url <- map["url"]
            quitUrl <- map["quit_url"]
            favorite <- map["favorite"]
            name <- map["name"]
            type <- map["type"]
            
            if map.JSON["img"] != nil {
                img <- map["img"]
            } else {
                img <- map["game_img"]
            }
            
            if map.JSON["childrens"] != nil {
                childrens <- map["childrens"]
            } else if map.JSON[""] != nil {
                childrens <- map["children"]
            } else {
                childrens <- map["child"]
            }
        }
        
        
        
        var id: Int = 0
        var img: String = ""
        var name: String = ""
        var type: String = ""
        var url: String = "" //游戏链接
        var quitUrl: String = ""
        var favorite: Bool = false //1：已收藏，0：未收藏
        
        
        var childrens: [Game] = []
        
        var imgURL: URL? {
            URL(string: img)
        }
        
        
        //自定义属性
        var image: UIImage? = nil
        var isHot: Bool = false //是否热门游戏
        var isShowAll: Bool = false
    }
    
    //mark: 游戏菜单
    // 二级游戏id 不传获取一二级分类 传ID获取第三级游戏列表
    func getMenu(id: Int? = nil) -> Observable<[Game]> {
        return ZKProvider.rx.request(.homeMenu(id: id)).mapServerArray(Game.self).asObservable()
    }
    
    //搜索游戏
    func searchGame(id: Int? = nil, name: String? = nil) -> Observable<[Game]> {
        ZKProvider.rx.request(.searchGame(id: id, name: name)).mapServerJSON().flatMap{ state, json, msg in
            if state != 0 {
                kShowPrompt(text: msg)
                return .never()
            }
            return .just(json["list"].mapObjectArray(type: Game.self))
            
        }.asObservable()
    }
    
    // MARK: 社区论坛列表
    struct Community: Mappable {
        
        var name: String = ""
        var icon: String = ""
        var jump: String = ""
        
        init?(map: Map) {
            name <- map["name"]
            icon <- map["icon"]
            jump <- map["jump_url"]
        }
        
        mutating func mapping(map: Map) {
            
        }
        
        var iconURL: URL? {
            URL(string: icon)
        }
        
        var jumpURL: URL? {
            URL(string: jump)
        }
    }
    
    func communityList() -> Observable<[Community]> {
        ZKProvider.rx.request(.communityList).mapServerArray(Community.self).asObservable()
    }
    
    enum LoginResult {
        var isOK: Bool {
            switch self {
            case .ok:
                return true
            default:
                return false
            }
        }
        
        var isCaptcha: Bool {
            switch self {
            case .captcha:
                return true
            default:
                return false
            }
        }
        
        var errMsg: String {
            switch self {
            case .failed(let msg):
                return msg
            case .captcha(let msg):
                return msg
            default:
                return ""
            }
            
        }
        
        
        case ok(user: ZKUserModel)
        case captcha(msg: String) //验证码错误
        case failed(msg: String)
    }
    
    enum ValidationResult {
        case ok
        case none(msg: String = "")
        case failed(_ msg: String)
        
        var isOK: Bool {
            switch self {
            case .ok:
                return true
            default:
                return false
            }
        }
        
        var textColor: UIColor? {
            switch self {
            case .none:
                return UIColor(hexString: "#72788B")
            case .ok:
                return UIColor(hexString: "#72788B")
            case .failed:
                return UIColor(hexString: "#E94951")
            }
        }
    }
    
    func login(username: String, password: String, code: String? = nil, token: String? = nil) -> Observable<LoginResult> {
        return ZKProvider.rx.request(.login(username: username, password: password, code: code ?? "", token: token ?? "")).mapServerJSON { state, json, message in
            if state == 1 {
                guard let auth = json["auth"].dictionaryObject, var model = ZKUserModel(JSON: auth) else {
                    return .failed(msg: "error")
                }
                
                  model.password = password
                  
                return .ok(user: model)
            } else if state == 105 {
                return .captcha(msg: message)
            } else {
                return .failed(msg: message)
            }
        }.asObservable()
    }
    
    struct ZKCaptchaImage : Mappable {
        init?(map: Map) {
            
        }
        
        
        mutating func mapping(map: Map) {
            token <- map["token"]
            images <- map["images"]
        }
        
        var token: String = ""
        var images: String = ""
        
        var image: UIImage? {
            guard let beginRange = images.range(of: "base64,") else {
                return nil
            }
            //print("image:", images)
        
            let range = beginRange.upperBound...
            let base64 = String(images[range])
            //print("base64:", base64)
            guard let data = Data(base64Encoded: base64) else {
                return nil
            }
            return UIImage(data: data)
        }
    }
    
    enum ZKCaptchaResult {
        case ok(captcha: ZKCaptchaImage)
        case failed(msg: String)
    }
    
    //获取验证码
    func getCaptchaImage() -> Observable<ZKCaptchaImage?> {
        return ZKProvider.rx.request(.captchaImage).mapServerObject(ZKCaptchaImage.self).asObservable()
    }
    
    //退出登录
    func logout() -> Observable<Void> {
        return ZKProvider.rx.request(.logout).mapServerRespone().flatMap{ resp in
            if resp.state != 2 {
                DefaultWireFrame.showPrompt(text: resp.message)
            }
            return.just(())
        }.asObservable().share()
    }
    
    // MARK: 注册
    
    enum ZKRegisterResult {
        case ok(_ info: Info)
        case failed(_ msg: String)
        
        var isOK: Bool {
            switch self {
            case .ok:
                return true
            case .failed:
                return false
            }
        }
        
        struct Info: Mappable {
            init?(map: Map) {
                
            }
            
            mutating func mapping(map: Map) {
                
            }
            
            var expiration: Int = 0
            var socketLoginId: String = ""
            var socketToken: String = ""
            var token: String = ""
            var uuid: String = ""
            
            
        }
    }
    //注册
    func requestRegister(userName: String, mobile: String, password: String, verifyCode: String, invitCode: String? = "") -> Observable<ZKRegisterResult> {
        ZKProvider.rx.request(.register(user_name: userName, mobile: mobile, password: password, re_password: password, verify_code: verifyCode, invit_code: invitCode)).mapServerJSON{ state, json, message in
            guard state == 1, let info = json.mapObject(type: ZKRegisterResult.Info.self) else {
                return .failed(message)
            }
            return .ok(info)
        }.asObservable()
    }
    //发送注册验证码
    func getOTP(phone: String) -> Observable<ZKServerResult<String>> {
        ZKProvider.rx.request(.registerMoblieCode(telphone: phone)).mapServerRespone { state, data, msg -> ZKServerResult<String> in
            if state == 102 {
                return .respone((data as? String) ?? "")
            } else {
                return .failed(message: msg)
            }
        }.asObservable()
    }
    //发送忘记密码验证码
    func getForgetCode(phone: String) -> Observable<ZKServerResult<String>> {
        ZKProvider.rx.request(.forgetMoblieCode(telphone: phone)).mapServerRespone { state, data, msg -> ZKServerResult<String> in
            if state == 102 {
                return .respone((data as? String) ?? "")
            } else {
                return .failed(message: msg)
            }
        }.asObservable()
    }
    
    //设置密码
    func settingPassword(new: String, name: String, code: String) -> Observable<ZKServerResult<Void>> {
        ZKProvider.rx.request(.forgetSettingPsd(name: name, password: new, code: code)).mapServerRespone { state, _, msg -> ZKServerResult<Void> in
            if state == 126 {
                return .respone(())
            }
            return .failed(message: msg)
        }.asObservable()
    }
    
    //登录游戏
    func getGameUrl(url: String) -> Observable<ZKServerResult<URL>> {
        requestData(.get, baseURLString + url, headers: HTTPHeaders(serverHeaders)).flatMap { resp, data -> Observable<ZKServerResult<URL>> in
            let json = try JSON(data: data)
           
            
            guard let url = json["data"]["url"].url else {
                return .just(.failed(message: json["message"].string ?? "url failed"))
            }
            
            
            return .just(.respone(url))
        }.catch { error in
            return .just(.failed(message: error.localizedDescription))
        }
    }
    
    func getGameUrl(id: Int) -> Observable<ZKServerResult<URL>> {
        ZKProvider.rx.request(.gameApp(id: id)).mapServerJSON({ _, json, message -> ZKServerResult<URL> in
            guard let url = json["url"].url else {
                return .failed(message: json["message"].string ?? "url failed")
            }
            return .respone(url)
        }, failsOnEmpty: false).catch{ error in
                .just(.failed(message: error.localizedDescription))
        }.asObservable()
    }
    
    //游戏按钮菜单
    func getPageHotList() -> Observable<[Game]> {
        ZKProvider.rx.request(.pageHot).mapServerArray(Game.self).asObservable()
    }
    //全部游戏
    func getAllGame() -> Observable<[Game]> {
        ZKProvider.rx.request(.allGame).mapServerArray(Game.self).asObservable()
    }
    
    //获取活动
    func getActiveList(id: Int? = nil) -> Observable<[[WLUserActiveListDataModel]]> {
        ZKProvider.rx.request(.userActiveList(active_type_id: id)).mapServerJSON{ _, json, _ in
            json.arrayValue.map { json in
                json["data"].mapObjectArray(type: WLUserActiveListDataModel.self)
            }
        }.asObservable()
    }
    
    
    // MARK: - validated
    func validatedUsername(userName: String) -> ValidationResult {
        if userName.isEmpty {
            return .failed("login4".wlLocalized)
        }
        return .ok
    }
    
    func validatedPassword(password: String ) -> ValidationResult {
        if password.isEmpty {
            return .failed("login5".wlLocalized)
        }
        return .ok
    }

    func validatedRepeated(password: String, repeatedPassword: String ) -> ValidationResult {
        if !validatedPassword(password: password).isOK {
            return .failed("")
        }
        
        if password != repeatedPassword {
            return .failed("login33".wlLocalized)
        }
        return .ok
    }
    
    func validatedPhone(phone: String) -> ValidationResult {
        if phone.isEmpty {
            return .failed("login32".wlLocalized)
        }
        return .ok
    }
    
    func validatedCode(code: String) -> ValidationResult {
        if code.isEmpty {
            return .failed("login21".wlLocalized)
        }
        return .ok
    }
}
