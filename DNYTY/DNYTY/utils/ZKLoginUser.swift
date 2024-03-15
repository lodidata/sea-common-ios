//
//  ZKLoginUser.swift
//  GameCaacaya
//
//  Created by WL on 2021/12/20.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import ObjectMapper
let kLoginUserPath: String = {
    let path = kDocumentPath.appending("/user")
    if !FileManager.default.fileExists(atPath: path) {
        try? FileManager.default.createDirectory(at: URL(fileURLWithPath: path), withIntermediateDirectories: true, attributes: nil)
    }
    return path.appending("/user.db")
}()

let kModularKey = "kModularKey"

enum AppModular: Int { //app模块
case none
case game
}

struct ZKUserModel: Mappable, Codable{
    init?(map: Map) {
        
    }
    
    init(uuid: String, token: String) {
        self.uuid = uuid
        self.token = token
    }
    
    mutating func mapping(map: Map) {
        uuid <- map["uuid"]
        token <- map["token"]
    }

    var password: String = ""
    var uuid: String = ""
    var token: String = ""
}

class ZKLoginUser {
    //typealias Config = ZKUserInfoServer.Config
    
    static let shared: ZKLoginUser = {
        let shared = ZKLoginUser()
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: kLoginUserPath) as? Data {
            let model = try? PropertyListDecoder().decode(ZKUserModel.self, from: data)
            shared.model = model
        }
        
        if let modularValue = UserDefaults.standard.object(forKey: kModularKey) as? Int, let modular = AppModular(rawValue: modularValue) {
            
        }
        
        return shared
        
    }()
    
    private init() {}
    
    private(set) var model: ZKUserModel!
    
    
    var isLogin: Bool {
        return model != nil
    }
    
    //let config: BehaviorRelay<Config> = BehaviorRelay(value: Config())
    
    @discardableResult func save(model: ZKUserModel) -> Bool {
        self.model = model
        guard let data = try? PropertyListEncoder().encode(model) else {
            return false
        }
        let success = NSKeyedArchiver.archiveRootObject(data, toFile: kLoginUserPath)
        return success
    }
    
    func clean() {
        self.model = nil
        try? FileManager.default.removeItem(at: URL(fileURLWithPath: kLoginUserPath))
        
    }
    
}
