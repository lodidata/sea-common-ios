//
//  ZKHomeHotGameViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/9
//  
//
    

import UIKit

class ZKHomeHotGameViewController: ZKScrollViewController {
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, URL?>>  { _, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZKHomeGameCell
        cell.imageView.sd_setImage(with: item, placeholderImage: kGamePlaceholderImage)
        return cell
    }
    
    let firtTabView = ZKHomeHotFirstTabView()
    let secondTabView = ZKHomeHotSecondTabView()
    let searchField: ZKHomeSearchField = {
       let view = ZKHomeSearchField()
        //view.setContentHuggingPriority(.required, for: .vertical)
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        let nullDataView = ZKNullDataView()
        nullDataView.icon.image = RImage.no_game()
        nullDataView.textLab.text = "recharge45".wlLocalized
        nullDataView.isHidden = true
        collectionView.backgroundView = nullDataView
        
        
        return collectionView
    }()
    
    
    let nullDateView: ZKNullDataView = {
        let nullDataView = ZKNullDataView()
        nullDataView.icon.image = RImage.no_game()
        nullDataView.textLab.text = "recharge45".wlLocalized
        nullDataView.isHidden = true
        return nullDataView
    }()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        //设置默认级菜单显示
        guard let viewModel = viewModel as? ZKHotGameViewModel else {
            return
        }
        
        //一级菜单
        firtTabView.collectionView.selectItem(at: IndexPath(item: viewModel.firtSelectIndex.value, section: 0), animated: false, scrollPosition: .centeredVertically)
        
        //二级菜单
        guard let secondSelectIndex = viewModel.secondSelectIndex.value else { return  }
        secondTabView.collectionView.selectItem(at: IndexPath(item: secondSelectIndex, section: 0), animated: false, scrollPosition: .centeredVertically)
    }
    
    override func initSubView() {
        super.initSubView()
        title = "game3".wlLocalized
        view.backgroundColor = UIColor(hexString: "#0E0D20")
        contentView.addSubview(firtTabView)
        contentView.addSubview(secondTabView)
        contentView.addSubview(searchField)
        //contentView.addSubview(nullDateView)
        contentView.addSubview(collectionView)
        collectionView.register(ZKHomeGameCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
    }
    
    override func layoutSubView() {
        super.layoutSubView()
       
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(scrollView.snp.height).priority(.required)
        }
        
        firtTabView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(firtTabView.snp.width).multipliedBy(amount375(60))
        }
        
        secondTabView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(firtTabView.snp.bottom)
            make.height.equalTo(firtTabView.snp.width).multipliedBy(amount375(60))
        }
        
        searchField.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(secondTabView.snp.bottom).offset(20)
            make.height.equalTo(38).priority(.required)
        }
        
//        nullDateView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(searchField.snp.bottom)
//            make.bottom.equalToSuperview()
//        }
        
        collectionView.rx.observe(CGSize.self, "contentSize").bind {[weak collectionView = collectionView] contentSize in
            guard let contentSize = contentSize, let collectionView = collectionView  else { return }

            collectionView.snp.remakeConstraints { make in
                make.left.right.equalTo(self.searchField)
                make.top.equalTo(self.searchField.snp.bottom).offset(30)
                make.height.equalTo(contentSize.height).priority(.low)
                make.bottom.equalToSuperview()
            }
        }.disposed(by: rx.disposeBag)
        
    }
    
    
    
    
    override func bindViewModel() {
        guard let viewModel = viewModel as? ZKHotGameViewModel else {
            return
        }
        
        let input = ZKHotGameViewModel.Input(viewWillShow: rx.viewWillAppear.mapToVoid().asObservable(),
                                             headerRefresh: .never(),
                                             firtTabSelect: firtTabView.collectionView.rx.itemSelected.map{ $0.item },
                                             secondTabSelect: secondTabView.collectionView.rx.itemSelected.map{ $0.item },
                                             searchGameText: searchField.textField.rx.text.orEmpty.asObservable(),
                                             tapGameIndex: collectionView.rx.itemSelected.map{ $0.item }.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        viewModel.firtTabList.bind(to: firtTabView.collectionView.rx.items(cellIdentifier: "cell", cellType: ZKHomeFirstGameTabCell.self)){ index, game, cell in
            if index == 0 {
                cell.icon.image = game.image
            } else {
                cell.icon.sd_setImage(with: game.imgURL)
            }
            cell.titleLab.text = game.name
        }.disposed(by: rx.disposeBag)
        output.secondTabList.drive(secondTabView.items).disposed(by: rx.disposeBag)

        
        output.gameImageUrls.drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.gameImageUrls.map{ list -> Bool in
            if list.count == 0 {
                return false
            } else {
                return list[0].items.count != 0
            }
        }.drive(collectionView.backgroundView!.rx.isHidden).disposed(by: rx.disposeBag)
        output.clearSearch.drive(onNext: {  [weak self] in
            self?.searchField.textField.text = ""
        }).disposed(by: rx.disposeBag)
        
        viewModel.indicator.asObservable().bind(to: rx.loading).disposed(by: rx.disposeBag)
        output.enterGame.drive { [weak self] resp in
            guard let self = self else { return  }
            
            if !ZKLoginUser.shared.isLogin {
                self.navigator.show(segue: .login, sender: self)
                return
            }
            switch resp {
            case .respone(let url):
                self.navigator.show(segue: .webView(url: url), sender: self, transition: .modal)
            case .failed(let msg):
                DefaultWireFrame.showPrompt(text: msg)
            }
        }.disposed(by: rx.disposeBag)
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


extension ZKHomeHotGameViewController: UICollectionViewDelegateFlowLayout {
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
