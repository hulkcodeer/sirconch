//
//  MainViewController.swift
//  Sir.conch
//
//  Created by In Ok Park on 2021/09/14.
//

import UIKit
import AppTrackingTransparency
import GoogleMobileAds

internal class MainViewController: UIViewController {
    enum SendState {
        case disable
        case question
        case reQuesstion
        case questionComplete
        
        func getString () -> String {
            switch self {
            case .disable:
                return "질문하기"
                
            case .question:
                return "질문하기"
                
            case .reQuesstion:
                return "질문하기"
                
            case .questionComplete:
                return "다시하기"
            }
        }
    }
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lbAnswer: UILabel!
    @IBOutlet weak var txtQuestion: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var imgConch: UIImageView!
    @IBOutlet weak var Answer: UIView!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnSendImgView: UIImageView!
    @IBOutlet weak var googleAdView: UIView!
    
    private var bannerView: GADBannerView!
    
    
    private let animationDurationStartAlpha: CGFloat = 0.0
    private let animationDurationEndAlpha: CGFloat = 1.0
    private var sendState: SendState = .disable
    private let positiveAnswer = ["당장 시작해.", "좋아.", "그래.", "나중에 해.", "다시 한번 물어봐.",
                          "안돼.", "놉.", "하지마.", "최.악.", "가만히 있어.",
                          "그것도 안돼.", "진행시켜.", "고고.", "오 좋은데?"]
    private let negativeAnswer = ["먹지마.", "먹어.", "굶어.", "응, 먹지마.", "다시 한번 물어봐.",
       "그래.", "조금만 먹어"]
    
    private let foodPositiveAnswer = ["그래.", "다 먹어.", "조금만 먹어."]
    private let foodNegativeAnswer = ["먹지마.", "둘다 먹지마.", "굶어."]
            
    lazy var accessoryToolbarWithDoneButtonaccessoryToolbarWithDoneButton: UIToolbar = {
        
        let toolbar = UIToolbar(frame: CGRect.zero)
        toolbar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(keyboardDoneButtonTapped(_:)))
        toolbar.items = [leftSpace, doneButton]
        
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            doneButton.tintColor = .black
        case .dark:
            doneButton.tintColor = .white
        @unknown default:
            fatalError()
        }
        
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtQuestion.layer.cornerRadius = 7
        txtQuestion.layer.borderColor = UIColor.white.cgColor
        txtQuestion.layer.borderWidth = 1.0
        txtQuestion.addLeftPadding()
        
        Answer.alpha = 0.0
        
        txtQuestion.inputAccessoryView = accessoryToolbarWithDoneButtonaccessoryToolbarWithDoneButton
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized, .denied, .notDetermined, .restricted:
                    self.setupBannerView()
                default: break
                }
            }
        } else {
            self.setupBannerView()
        }
    }
    
    @objc func keyboardDoneButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    internal func setupBannerView() {
        
        DispatchQueue.main.async {
            let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
            self.bannerView = GADBannerView(adSize: adSize)
            self.bannerView.backgroundColor = .clear
            self.addBannerViewToView(self.bannerView)
            //        bannerView.adUnitID = "ca-app-pub-3926120372825354/9657965886"¸
            self.bannerView.adUnitID = "ca-app-pub-8965771939775493/8407428627"
            self.bannerView.rootViewController = self
            self.bannerView.load(GADRequest())
            self.bannerView.delegate = self
        }
    }
    
    @IBAction func btnInfo(_ sender: UIButton) {
        let viewControllerName = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController")
        viewControllerName?.modalTransitionStyle = .flipHorizontal
        if let view = viewControllerName {
            view.modalPresentationStyle = .fullScreen
            self.present(view, animated: true, completion: nil)
        }
        
    }
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        let txtStr: String = self.txtQuestion.text ?? ""
        
        guard !txtStr.isEmpty else {
            self.sendState = .disable
            self.changeSendState(state: self.sendState)
            return
        }
        
        guard self.sendState != .question else {
            return
        }
        
        self.sendState = .question
        self.changeSendState(state: self.sendState)
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        let txtStr = txtQuestion.text ?? ""
        
        guard !txtStr.isEmpty else {
            self.sendState = .disable
            self.changeSendState(state: self.sendState)
            return
        }
        
        guard self.sendState != .questionComplete else {
            self.sendState = .disable
            self.changeSendState(state: self.sendState)
            return
        }
        
        self.sendState = .question
        self.changeSendState(state: self.sendState)
                
        if txtStr.contains("먹어") || txtStr.contains("먹을") {
            lbAnswer.text = foodNegativeAnswer.randomElement()
        } else {
            lbAnswer.text = foodPositiveAnswer.randomElement()
        }
        
        self.imgConch.alpha = self.animationDurationStartAlpha
        self.Answer.alpha = self.animationDurationStartAlpha
        UIView.animate(withDuration: 1.0, animations: {
            self.imgConch.alpha = self.animationDurationEndAlpha
            self.Answer.alpha = self.animationDurationEndAlpha
        })
        
        self.sendState = .questionComplete
        self.changeSendState(state: self.sendState)
        
        self.txtQuestion.endEditing(true)
    }
    
    func changeSendState(state: SendState) {
        switch state {
        case .disable:
            self.btnSend.setTitle(state.getString(), for: .normal)
            self.btnSendImgView.image = UIImage(named: "btnDisable")
            self.txtQuestion.text = ""
            self.Answer.isHidden = true
            
        case .question:
            self.btnSend.setTitle(state.getString(), for: .normal)
            self.btnSendImgView.image = UIImage(named: "btnSend")
            self.Answer.isHidden = true
            
        case .reQuesstion:
            self.btnSend.setTitle(state.getString(), for: .normal)
            self.btnSendImgView.image = UIImage(named: "btnDisable")
            self.txtQuestion.text = ""
            self.Answer.isHidden = true
            
        case .questionComplete:
            self.btnSend.setTitle(state.getString(), for: .normal)
            self.btnSendImgView.image = UIImage(named: "btnRe")
            self.Answer.isHidden = false
        }
    }
    
    @IBAction func actShare(_ sender: Any) {
        var imgContext: UIImage?
        guard let currentLayer = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.layer else { return }
        
        let currentScale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(currentLayer.frame.size, false, currentScale)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        
        currentLayer.render(in: currentContext)
        imgContext = UIGraphicsGetImageFromCurrentImageContext()
        
        guard let _imgContext = imgContext else { return }
        
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(_imgContext, nil, nil, nil)
        
        let shareActivity = UIActivityViewController(activityItems: [_imgContext], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(shareActivity, animated: true, completion: nil)
    }
    
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.btnSend(UIButton())
        return true
    }
}

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.type = .radial
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

extension UIColor {
    convenience init(argb: UInt) {
        self.init(
            red: CGFloat((argb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((argb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(argb & 0x0000FF) / 255.0,
            alpha: CGFloat((argb & 0xFF000000) >> 24) / 255.0
        )
    }
}

extension MainViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) { print("adViewDidReceiveAd") }
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) { print("adViewWillLeaveApplication") }
}
