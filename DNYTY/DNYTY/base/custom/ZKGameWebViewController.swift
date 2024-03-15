//
//  ZKGameWebViewController.swift
//  GameCaacaya
//
//  Created by zkil on 2021/12/24.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

class ZKGameWebViewController: ZKViewController, WKScriptMessageHandler {
    let gameURL: URL
    
    
    
    //@IBOutlet weak var loadingView: ZKGameLoadingView!
//    var loading: Binder<Bool> {
//        Binder(self.loadingView) { view, isShow in
//            if isShow {
//                view.increment()
//            } else {
//                view.decrement()
//            }
//        }
//    }
    
    var webView: WKWebView!
    
    let backItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: RImage.navi_back(), style: .plain, target: nil, action: nil)
        return item
    }()
    let closeItem: UIBarButtonItem = {
       let item = UIBarButtonItem(image: RImage.close_white(), style: .plain, target: nil, action: nil)
        return item
    }()
    
    init(gameURL: URL) {
        
        
        self.gameURL = gameURL
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userContentController = WKUserContentController()
        userContentController.add(self, name: "popToNative")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //webView.scrollView.contentInsetAdjustmentBehavior = .never
        navigationItem.leftBarButtonItems = [backItem, closeItem]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    override func bindViewModel() {
       
        
        backItem.rx.tap.bind { [weak self] in
            guard let self = self else { return  }
            if self.webView.canGoBack {
                self.webView.goBack()
            }
        }.disposed(by: rx.disposeBag)
        
        closeItem.rx.tap.bind { [weak self] in
            guard let self = self else { return  }
            self.navigator.dismiss(sender: self)
            
        }.disposed(by: rx.disposeBag)
//
        webView.rx.observe(String.self, "title").unwrap().bind(to: rx.title).disposed(by: rx.disposeBag)
        
        webView.rx.loading.bind(to: rx.loading).disposed(by: rx.disposeBag)
        webView.rx.promptFail.drive{ [weak self] index in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: rx.disposeBag)
        
        
        
        self.reload()
    }
    
    func reload() {
        webView.load(URLRequest(url: gameURL))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
   
}
import RxCocoa

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }

    return returnValue
}

extension Reactive where Base: WKWebView {
    var didFailProvisional: Observable<(WKNavigation, Error)> {
        navigationDelegate
            .methodInvoked(#selector(WKNavigationDelegate.webView(_:didFailProvisionalNavigation:withError:)))
            .map { a in
                (
                    try castOrThrow(WKNavigation.self, a[1]),
                    try castOrThrow(Error.self, a[2])
                )
            }
    }
    
    var loading: Observable<Bool> {
        let startLoad = self.didStartLoad.map{ _ in true }
        let finishLoad = self.didFinishLoad.map{ _ in false }
        let failLoad = self.didFailLoad.map{ _, _ in false }
        let didFailLoad = self.didFailProvisional.map{ _ in false }
        return Observable.merge(startLoad, finishLoad, failLoad, didFailLoad)
    }
    
    var promptFail: Driver<Int> {
        return self.didFailLoad.merge(with: didFailProvisional).flatMapLatest{ _, err -> Observable<Int> in
            let topVC = DefaultWireFrame.topViewController
            return topVC.promptFor(title: "error", message: err.localizedDescription, cancelAction: "text4".wlLocalized, actions: [], animated: true, completion: nil)
        }.asDriver(onErrorDriveWith: Driver.empty())
    }
}
