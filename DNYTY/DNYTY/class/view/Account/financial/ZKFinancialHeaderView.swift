//
//  ZKFinancialHeaderView.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit

class ZKFinancialHeaderView: ZKView {
    let startBtn: ZKDateSelectButton = {
       let btn = ZKDateSelectButton()
        let date = NSDate()
        btn.titleLab.text = "recharge7".wlLocalized
        btn.textLab.text = date.string(withFormat: "yyyy/MM/dd")
        return btn
    }()
    
    let endBtn: ZKDateSelectButton = {
       let btn = ZKDateSelectButton()
        btn.titleLab.text = "recharge8".wlLocalized
        let date = NSDate()
        btn.textLab.text = date.string(withFormat: "yyyy/MM/dd")
        return btn
    }()

    let hitIcon: UIImageView = {
        let imgV = UIImageView(image:RImage.deposit_hit2())
        return imgV
    }()
    
    let hitLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "finance11".wlLocalized
        return lab
    }()
    
    let searchBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bg = kSubmitButtonLayer1(size: CGSize(width: 343, height: 44))
        bg.cornerRadius = 5
        btn.setBackgroundImage(bg.snapshotImage(), for: .normal)
        btn.setTitle("finance6".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kMediumFont(14)
        return btn
    }()
    
    let searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let totalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let depositTotalView: ZKFinancialTotalItemView = {
       let view = ZKFinancialTotalItemView()
        view.titleLab.text = "finance2".wlLocalized
        view.icon.image = RImage.fin_deposit_total()
        return view
    }()
    
    let withdeawTotalView: ZKFinancialTotalItemView = {
       let view = ZKFinancialTotalItemView()
        view.titleLab.text = "finance3".wlLocalized
        view.icon.image = RImage.fin_withdraw_total()
        return view
    }()
    
    override func makeUI() {
        backgroundColor = UIColor(hexString: "#EDEEF3")
        
        addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        searchView.addSubview(startBtn)
        searchView.addSubview(endBtn)
        searchView.addSubview(hitIcon)
        searchView.addSubview(hitLab)
        searchView.addSubview(searchBtn)
        
        startBtn.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(10)
            make.height.equalTo(54)
        }
        
        endBtn.snp.makeConstraints { make in
            make.left.equalTo(startBtn.snp.right).offset(10)
            make.top.equalTo(startBtn)
            make.right.equalTo(-16)
            make.size.equalTo(startBtn)
        }
        
        hitIcon.snp.makeConstraints { make in
            make.left.equalTo(startBtn.snp.left)
            make.top.equalTo(startBtn.snp.bottom).offset(10)
        }
        hitLab.snp.makeConstraints { make in
            make.left.equalTo(hitIcon.snp.right).offset(5)
            make.centerY.equalTo(hitIcon)
        }
        
        searchBtn.snp.makeConstraints { make in
            make.left.equalTo(startBtn)
            make.right.equalTo(endBtn)
            make.top.equalTo(hitLab.snp.bottom).offset(20)
            make.bottom.equalTo(-20)
        }
        
        addSubview(totalView)
        
        totalView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.height.equalTo(110)
            
        }
        
        let line = UIView()
        line.backgroundColor = UIColor(hexString: "#E8E9F0")
        totalView.addSubview(depositTotalView)
        totalView.addSubview(line)
        totalView.addSubview(withdeawTotalView)
        
        depositTotalView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo(1)
            make.left.equalTo(depositTotalView.snp.right)
        }
        
        withdeawTotalView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(line.snp.right)
            make.width.equalTo(depositTotalView)
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

class ZKFinancialTotalItemView: ZKView {
    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.fin_deposit_total())
        return imgV
    }()
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(14)
        lab.text = "finance2".wlLocalized
        return lab
    }()
    
    let totalLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(20)
        lab.text = "0.00"
        return lab
    }()
    override func makeUI() {
        addSubview(icon)
        addSubview(titleLab)
        addSubview(totalLab)
        titleLab.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleLab.snp.top).offset(-4)
        }
        totalLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(4)
        }
    }
}
