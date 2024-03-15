//
//  WLAfterLoginAlertCell.swift
//  DNYTY
//
//  Created by WL on 2022/6/21
//  
//
    

import UIKit

class WLAfterLoginAlertCell: UICollectionViewCell {
    
//    private lazy var lab: UILabel = {
//        let lab = UILabel.init()
//        lab.textColor = UIColor.init(hex: "232323")
//        lab.font = RFont.promptMedium(size: 14)
//        lab.numberOfLines = 0
//        lab.text = "alsdkjfkajjdfsalsdkjfkajjdfsalsdkjfkajjdfsalsdkjfkajjdfsalsdkjfkajjdfsalsdkjfkajjdfsalsdkjfkajjdfsalsdkjfkajjdfsalsdkjfkajjdfsalsdkjfkajjdfs"
//        return lab
//    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(20)
        lab.text = "account6".wlLocalized
        return lab
    }()
    let imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFill
        return imgV
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.font = kMediumFont(14)
        textView.isEditable = false
        return textView
    }()
    lazy var timeLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor(hexString: "#999999")
        lab.font = kMediumFont(12)
        lab.text = "2022-04-06 10:32:18"
        return lab
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //contentView.addSubview(titleLab)
        
        contentView.addSubview(timeLab)
        contentView.addSubview(textView)
        contentView.addSubview(imageView)
        
        
//        titleLab.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.left.greaterThanOrEqualTo(10)
//            make.right.lessThanOrEqualTo(-10)
//        }
        
        
       
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0)
        }
        
        
        textView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(timeLab.snp.top)
        }
        
        timeLab.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var dataModel: WLNoticeAppDataModel? {
        didSet {
            textView.text = dataModel?.content
            timeLab.text = dataModel?.created
            guard let imgUrl = dataModel?.imgUrl else {
                imageView.isHidden = true
                textView.isHidden = false
                return
            }
            imageView.sd_setImage(with: imgUrl) { [weak self] image, _, _, _ in
                guard let self = self, let size = image?.size else { return  }
                 
                self.imageView.snp.remakeConstraints { make in
                    make.top.left.right.equalToSuperview()
                    make.height.equalTo(self.imageView.snp.width).multipliedBy(size.height/size.width)
                }
            }
            imageView.isHidden = false
            textView.isHidden = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
