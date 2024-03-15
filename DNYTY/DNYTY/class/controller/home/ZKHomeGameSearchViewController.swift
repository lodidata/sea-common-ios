//
//  ZKHomeGameSearchViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/7
//  
//
    

import UIKit

class ZKHomeGameSearchViewController: ZKViewController {
    
    let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()

    let searchField = ZKHomeSearchField()
    
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, ZKHomeServer.Game>> (animationConfiguration: AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .top, deleteAnimation: .automatic), configureCell: { _, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZKHomeGameCell
        cell.imageView.sd_setImage(with: item.imgURL, placeholderImage: kGamePlaceholderImage)


        return cell
    })
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        //collectionView.setContentHuggingPriority(.defaultLow, for: .vertical)
        //collectionView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        let nullDataView = ZKNullDataView()
        nullDataView.icon.image = RImage.no_game()
        nullDataView.textLab.text = "recharge45".wlLocalized
        nullDataView.isHidden = true
        collectionView.backgroundView = nullDataView
        return collectionView
    }()
    
    //二级列表
    let twoGameList = ZKHomeTwoTopGameList()
    
    //热门游戏
    let hotBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kSystemFont(12)
        btn.set(image: RImage.home_hot_btn(), title: "game2".wlLocalized, titlePosition: .left, additionalSpacing: 5, state: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func initSubView() {
        view.backgroundColor = UIColor(hexString: "#0E0D20")
        view.addSubview(searchField)
        view.addSubview(twoGameList)
        view.addSubview(contentView)
        contentView.addArrangedSubview(collectionView)
        contentView.addArrangedSubview(hotBtn)
        //view.addSubview(collectionView)
        
        //view.addSubview(hotBtn)
        collectionView.register(ZKHomeGameCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        
        
    }
    
    override func layoutSubView() {
        
        twoGameList.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(55)
            make.bottom.equalTo(-20)
        }
        
        searchField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(twoGameList.snp.right).offset(22)
            make.right.equalTo(-10)
            make.height.equalTo(38)
        }
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalTo(searchField)
            make.top.equalTo(searchField.snp.bottom).offset(30)
            make.bottom.equalTo(-20)
        }
//        collectionView.snp.makeConstraints { make in
//            make.left.right.equalTo(searchField)
//            make.top.equalTo(searchField.snp.bottom).offset(30)
//            make.height.equalTo(390)
//            make.bottom.equalToSuperview()
//
//        }
        
        collectionView.rx.observe(CGSize.self, "contentSize").bind {[weak self] contentSize in
            guard let contentSize = contentSize, let self = self  else { return }
            //let itemWidth = (self.collectionView.width-23)/3
            self.collectionView.snp.remakeConstraints { make in
                make.height.equalTo(contentSize.height > self.collectionView.width ? contentSize.height : self.collectionView.width)
            }
            
        }.disposed(by: rx.disposeBag)
        
        hotBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    override func bindViewModel() {
//        Observable.just([SectionModel<String, UIImage?>(model: "", items: [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil])]).bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        guard let viewModel = viewModel as? ZKHomeGameSearchViewModel else {
            return
        }
        
        let input = ZKHomeGameSearchViewModel.Input(
            secondTabSelectIndex: twoGameList.tableView.rx.itemSelected.map{ $0.row }.asObservable(),
            searchGameText: searchField.textField.rx.text.orEmpty.asObservable(),
            tapGameIndex: collectionView.rx.itemSelected.map{ $0.item }.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.twoTopGameImageUrls.drive(twoGameList.items).disposed(by: rx.disposeBag)
        output.gameList.drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.gameList.map{ list -> Bool in
            if list.count == 0 {
                return false
            } else {
                return list[0].items.count != 0
            }
        }.drive(collectionView.backgroundView!.rx.isHidden).disposed(by: rx.disposeBag)
        
        output.clearSearch.drive(onNext: {  [weak self] in
            self?.searchField.textField.text = ""
        }).disposed(by: rx.disposeBag)
        
        output.enterGame.drive { [weak self] resp in
            guard let self = self else { return  }
            if !ZKLoginUser.shared.isLogin {
                self.navigator.show(segue: .login, sender: self)
                return
            }
            switch resp {
            case .respone(let url):
                self.navigator.show(segue: .webView(url: url), sender: self.parent, transition: .modal)
            case .failed(let msg):
                DefaultWireFrame.showPrompt(text: msg)
            }
        }.disposed(by: rx.disposeBag)
        
        
        //更多热门游戏按钮
        output.moreBtnHidden.drive(hotBtn.rx.isHidden).disposed(by: rx.disposeBag)
        
        
        
        
        viewModel.indicator.asDriver().drive(rx.loading).disposed(by: rx.disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ZKHomeGameSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.width-23)/3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}


class ZKHomeSearchField: ZKView {
    let searchBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        btn.setImage(RImage.home_search(), for: .normal)
        
        return btn
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "game0".wlLocalized, attributes: [.font: kMediumFont(16), .foregroundColor: UIColor(hexString: "#72788B") ?? .gray])
        textField.font = kMediumFont(16)
        textField.textColor = .white
        return textField
    }()
    
    override func makeUI() {
        backgroundColor = UIColor(hexString: "#272551")
        layer.cornerRadius = 19
        
        addSubview(textField)
        addSubview(searchBtn)
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(22)
            make.centerY.equalToSuperview()
        }
        
        searchBtn.snp.makeConstraints { make in
            make.right.equalTo(-36)
            make.centerY.equalToSuperview()
            make.left.equalTo(textField.snp.right).offset(10)
        }
    }
}


class ZKHomeGameCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        imgV.backgroundColor = .black
        return imgV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
