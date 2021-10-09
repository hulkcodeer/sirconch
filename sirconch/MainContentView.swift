//
//  ContentView.swift
//  sirconch
//
//  Created by 박현진 on 2021/10/09.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds

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
    
    private var bannerView: GADBannerView!
    @State var questionTf: String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                    Text("소라고둥님께 물어봐")                        
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(height: 29)
                        .padding(.bottom, 22)
                                                                                    
                    TextField("", text: $questionTf)
                        .padding(20)
                        .frame(height: 45)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(Color(red: 1, green: 1, blue: 1))
                        .background(Color(red: 1, green: 1, blue: 1).opacity(0.4))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white, lineWidth: 1))
                        .padding(.bottom, 24)
                
                    Button("질문하기", action: {
                        
                    })
                
                    Image("btnSend")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(.top, 0)
                    
                    ZStack {
                        Image("conchBg")
                            .resizable()
                            .frame(width: 285, height: 314, alignment: .center)
                        
                        Image("conchNormal")
                            .resizable()
                            .frame(width: 285, height: 314, alignment: .center)
                    }.offset(y: -5)
                
                
                    ZStack {
                        Image("bubble")
                            .resizable()
                            .frame(width: 237, height: 116, alignment: .center)
                        
                        Text("test")
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
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
