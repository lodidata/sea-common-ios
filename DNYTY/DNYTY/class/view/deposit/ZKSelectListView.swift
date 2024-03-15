//
//  ZKSelectListView.swift
//  DNYTY
//
//  Created by WL on 2022/6/17
//  
//
    

import UIKit
import RxRelay
import SnapKit

class ZKSelectListView: ZKView {
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.layer.cornerRadius = 5
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor(hexString: "#7F4FE8")?.cgColor
        tableView.backgroundColor = UIColor(hexString: "#EDEEF3")
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    let items: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(hexString: "#EDEEF3")
        cell.textLabel?.font = kMediumFont(14)
        cell.textLabel?.textColor = UIColor(hexString: "#30333A")
        cell.textLabel?.text = item
        
        return cell
    }
    
    
    class func show(list: [String] = [], selectIndex: Int? = nil, to view: UIView, position: UIView.ContentMode, width: CGFloat) -> ZKSelectListView {
       
        let selectView = ZKSelectListView { make in
            guard let window = UIApplication.appDeltegate.window else { return  }
            
            switch position {
            case .left:
                let point = view.superview!.convert(CGPoint(x: view.left, y: view.top), toViewOrWindow: window)
                make.right.equalTo(point.x)
                make.top.equalTo(point.y)
                make.width.equalTo(width)
            case .right:
                let point = view.superview!.convert(CGPoint(x: view.right, y: view.top), toViewOrWindow: window)
                make.left.equalTo(point.x)
                make.top.equalTo(point.y)
                make.width.equalTo(width)
            case .top:
                let point = view.superview!.convert(CGPoint(x: view.left, y: view.top), toViewOrWindow: window)
                make.left.equalTo(point.x)
                make.bottom.equalTo(-(kScreenHeight - point.y))
                make.width.equalTo(width)
            case .bottom:
                let point = view.superview!.convert(CGPoint(x: view.left, y: view.bottom), toViewOrWindow: window)
                make.left.equalTo(point.x)
                make.top.equalTo(point.y)
                make.width.equalTo(width)
            default:
                break
            }
        }
        UIApplication.appDeltegate.window?.addSubview(selectView)
        selectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        selectView.items.accept(list)
        if let selectIndex = selectIndex {
            selectView.items.bind {[weak selectView] _ in
                guard let selectView = selectView else { return  }
                selectView.tableView.selectRow(at: IndexPath(item: selectIndex, section: 0), animated: false, scrollPosition: .none)
            }.disposed(by: selectView.rx.disposeBag)
        }
        
        return selectView
    }
    
    
    class func show(list: [String] = [], selectIndex: Int? = nil, makeConstraints: @escaping MakeConstraint) -> ZKSelectListView {
        let selectView = ZKSelectListView(makeConstraints: makeConstraints)
        UIApplication.appDeltegate.window?.addSubview(selectView)
        selectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        selectView.items.accept(list)
        if let selectIndex = selectIndex {
            selectView.items.bind {[weak selectView] _ in
                guard let selectView = selectView else { return  }
                selectView.tableView.selectRow(at: IndexPath(item: selectIndex, section: 0), animated: false, scrollPosition: .none)
            }.disposed(by: selectView.rx.disposeBag)
        }
        
        return selectView
    }
    
    typealias MakeConstraint = (ConstraintMaker) -> Void
    let makeConstraints: MakeConstraint
    
    init(makeConstraints: @escaping MakeConstraint) {
        self.makeConstraints = makeConstraints
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        addSubview(tableView)
        
        tableView.rx.observe(CGSize.self, "contentSize").bind{ [weak self] contentSize in
            guard let contentSize = contentSize, let self = self else { return  }
            
            self.tableView.snp.remakeConstraints { make in
                make.height.equalTo(contentSize.height).priority(.low)
                make.left.greaterThanOrEqualTo(self.safeAreaLayoutGuide.snp.left)
                make.top.greaterThanOrEqualTo(self.safeAreaLayoutGuide.snp.top)
                make.right.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.right)
                make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom)
                self.makeConstraints(make)
            }
            
        }.disposed(by: rx.disposeBag)
        
        
        tableView.rx.itemSelected.bind{[weak self] _ in
            self?.removeFromSuperview()
        }.disposed(by: rx.disposeBag)
        
        rx.tapGesture(configuration: { gesTure, delegate in
            gesTure.cancelsTouchesInView = false
        }).when(.recognized).bind { [weak self] tapGs in
            guard let self = self else { return  }
            let point = tapGs.location(in: self)
            if !self.tableView.frame.contains(point) {
                self.removeFromSuperview()
            }
        }.disposed(by: rx.disposeBag)
        
        
        items.map{ [SectionModel(model: "", items: $0)] }.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
