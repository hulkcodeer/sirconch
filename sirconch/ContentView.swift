//
//  ContentView.swift
//  sirconch
//
//  Created by 박현진 on 2021/10/09.
//

import SwiftUI

struct ContentView: View {
    @State var questionTf: String = ""
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                    Text("소라고둥님께 물어봐")
                        .padding(.bottom, 14)
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
                        .padding(20)
                
                Image("btnSend")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .padding(.top, 24)
                                                
                }
                .frame(width: UIScreen.main.bounds.width - 85, height: UIScreen.main.bounds.height, alignment: .center)
            }
            .background(
                Image("bgNight")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
