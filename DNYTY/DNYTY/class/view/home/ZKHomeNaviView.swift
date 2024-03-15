//
//  ZKHomeNaviView.swift
//  DNYTY
//
//  Created by WL on 2022/6/6
//  
//
    

import UIKit

class ZKHomeNaviView: ZKView {
    
    let logo: UIImageView = UIImageView(image: RImage.home_logo())
    
    let loginButtonView = ZKHomeNaviLogingButton()
    let logoutButtonView = ZKHomeNaviLogoutButton()
    
    
    
    

    override func makeUI() {
        backgroundColor = UIColor(hexString: "#111845")
        addSubview(logo)
        addSubview(logoutButtonView)
        addSubview(loginButtonView)
        
        
        
        logo.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(6)
            make.bottom.equalTo(-6)
        }
        
        
        logoutButtonView.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(logo.snp.centerY)
        }
        
        loginButtonView.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(logo.snp.centerY)
        }
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class ZKHomeNaviLogingButton: ZKView {
    let logoutBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.set(image: RImage.exit_icon(), title: "home2".wlLocalized, titlePosition: .right, additionalSpacing: 10, state: .normal)
        btn.titleLabel?.font = kMediumFont(12)
        return btn
    }()
    
    let moneyIcon: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kMediumFont(14)
        lab.layer.cornerRadius = 8
        //lab.layer.masksToBounds = true
        lab.layer.borderWidth = 1
        lab.textAlignment = .center
        lab.layer.borderColor = UIColor.white.cgColor
        lab.text = "$"
        return lab
    }()
    
    let moneyLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kMediumFont(14)
        lab.text = "0.00"
        return lab
    }()
    
    override func makeUI() {
        addSubview(logoutBtn)
 
        addSubview(moneyIcon)
        addSubview(moneyLab)
        
        let line = UIView()
        line.backgroundColor = UIColor(white: 1, alpha: 0.5)
        addSubview(line)
        
        moneyIcon.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.centerY.equalToSuperview()
        }
        
        moneyLab.snp.makeConstraints { make in
            make.left.equalTo(moneyIcon.snp.right).offset(4)
            make.centerY.equalToSuperview()
        }
        
        line.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1)
            make.left.equalTo(moneyLab.snp.right).offset(10)
        }
        
        logoutBtn.snp.makeConstraints { make in
            make.left.equalTo(line.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
        
        
    }
}

class ZKHomeNaviLogoutButton: ZKView {
    let loginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("home0".wlLocalized, for: .normal)
        btn.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        btn.titleLabel?.font = kMediumFont(12)
        return btn
    }()
    
    let registerBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(RImage.zhuche_anniu(), for: .normal)
        btn.setTitle("home1".wlLocalized, for: .normal)
        btn.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        btn.titleLabel?.font = kMediumFont(12)
        return btn
    }()
    
    override func makeUI() {
        addSubview(loginBtn)
        addSubview(registerBtn)
        
        registerBtn.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
        
        loginBtn.snp.makeConstraints { make in
            make.right.equalTo(registerBtn.snp.left).offset(-10)
            make.centerY.equalTo(registerBtn.snp.centerY)
            make.left.equalToSuperview()
        }
    }
}


extension Reactive where Base: ZKHomeNaviView {
    var isLogin: Binder<Bool> {
        Binder(self.base) { view, isLogin in
            view.loginButtonView.isHidden = !isLogin
            view.logoutButtonView.isHidden = isLogin
            
        }
    }
}
