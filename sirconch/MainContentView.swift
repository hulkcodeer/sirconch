//
//  ContentView.swift
//  sirconch
//
//  Created by 박현진 on 2021/10/09.
//

import SwiftUI
import AppTrackingTransparency

struct MainContentView: View {
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
        
    @State private var sendState: SendState = .disable
    @State private var questionTf: String = ""
    @State private var answer: String = ""
    @State private var conchImgName: String = "conchNormal"
    @State private var answerImgName: String = ""
    @State private var requestBtnImgName: String = "btnDisable"
    
    private let array1 = ["당장 시작해.", "좋아.", "그래.", "나중에 해.", "다시 한번 물어봐.",
    "안돼.", "놉.", "하지마.", "최.악.", "가만히 있어.", "그것도 안돼."]
    private let array2 = ["먹지마.", "먹어.", "굶어.", "응, 먹지마.", "다시 한번 물어봐.",
    "그래.", "조금만 먹어"]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                Text("소라고둥님께 물어봐")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(height: 29)
                    .padding(.bottom, 22)
                                                                                
                TextField("", text: $questionTf)
                    .onChange(of: questionTf) { newValue in
                        if questionTf.isEmpty {
                            self.sendState = .disable
                            self.requestBtnImgName = "btnDisable"
                        } else {
                            self.sendState = .question
                            self.requestBtnImgName = "btnSend"
                        }
                    }
                    .padding(20)
                    .frame(height: 45)
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundColor(Color(red: 1, green: 1, blue: 1))
                    .background(Color(red: 1, green: 1, blue: 1).opacity(0.4))
                    .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.white, lineWidth: 1))
                    .padding(.bottom, 24)
                    
                ZStack {
                    Image(self.requestBtnImgName)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(.top, 0)
                    
                    Button(self.sendState.getString(), action: {
                        let txtStr = self.questionTf
                        
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
                        
                        // Random array
                        if txtStr.contains("먹어") {
                            self.answer = array2.randomElement() ?? ""
                        }
                        else if txtStr.contains("먹을") {
                            self.answer = array2.randomElement() ?? ""
                        } else {
                            self.answer = array1.randomElement() ?? ""
                        }

                        self.conchImgName = "conchBg"
                        self.answerImgName = ""
                        UIView.animate(withDuration: 1.0, animations: {
                            self.conchImgName = "conchNormal"
                            self.answerImgName = "bubble"
                        })
                        
                        self.sendState = .questionComplete
                        self.changeSendState(state: self.sendState)
                    })
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                }
                                           
                Image(self.conchImgName)
                    .resizable()
                    .frame(width: 285, height: 314, alignment: .center)
                    .offset(y: -5)
                            
                ZStack {
                    Image(self.answerImgName)
                        .resizable()
                        .frame(width: 237, height: 116, alignment: .center)
                    
                    Text("\(answer)")
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 10/255, green: 7/255, blue: 31/255))
                        .frame(height: 29, alignment: .center)
                        .offset(y: 9)
                }.offset(y: -83)
            }
            .frame(width: UIScreen.main.bounds.width - 85, height: UIScreen.main.bounds.height, alignment: .center)
        }.background(
            Image("bgNight")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        print("PARK TEST authorized")
                    case .denied:
                        print("PARK TEST denied")
                    case .notDetermined:
                        print("PARK TEST notDetermined")
                    case .restricted:
                        print("PARK TEST restricted")
                    default: break
                    }
                }
            }
        })
    }
    
    func changeSendState(state: SendState) {
        switch state {
        case .disable:
            self.requestBtnImgName = "btnDisable"
            self.questionTf = ""

        case .question:
            self.requestBtnImgName = "btnSend"

        case .reQuesstion:
            self.requestBtnImgName = "btnDisable"
            self.questionTf = ""

        case .questionComplete:
            self.requestBtnImgName = "btnRe"
        }
    }
    
//    func addBannerViewToView(_ bannerView: GADBannerView) {
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//        view.addConstraints(
//          [NSLayoutConstraint(item: bannerView,
//                              attribute: .bottom,
//                              relatedBy: .equal,
//                              toItem: bottomLayoutGuide,
//                              attribute: .top,
//                              multiplier: 1,
//                              constant: 0),
//           NSLayoutConstraint(item: bannerView,
//                              attribute: .centerX,
//                              relatedBy: .equal,
//                              toItem: view,
//                              attribute: .centerX,
//                              multiplier: 1,
//                              constant: 0)
//          ])
//   }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
