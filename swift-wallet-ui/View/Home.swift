//
//  Home.swift
//  swift-wallet-ui
//
//  Created by Danh Tu on 08/09/2021.
//

import SwiftUI

struct Home: View {
    @State private var currentTab = "Incomings"
    // For Segment Tab Slide...
    @Namespace var animation
    
    var body: some View {
        ZStack {
            Color("bg")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 28, height: 28)
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "square.grid.2x2")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 28, height: 28)
                            .foregroundColor(.white)
                    })
                }
                .padding()
                
                Text("Statistics")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                // Custom Segment Picker...
                HStack {
                    Text("Incomings")
                        .bold()
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(
                            ZStack {
                                if currentTab == "Incomings" {
                                    Color.white
                                        .cornerRadius(10)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        )
                        .foregroundColor(currentTab == "Incomings" ? .black : .white)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                                currentTab = "Incomings"
                            }
                        }
                    
                    Text("Outgoings")
                        .bold()
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(
                            ZStack {
                                if currentTab == "Outgoings" {
                                    Color.white
                                        .cornerRadius(10)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        )
                        .foregroundColor(currentTab == "Outgoings" ? .black : .white)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                                currentTab = "Outgoings"
                            }
                        }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.black.opacity(0.35))
                .cornerRadius(10)
                .padding(.top, 20)
                
                // Money View...
                HStack(spacing: 40) {
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 20)
                        
                        Circle()
                            .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: 0.6)
                            .stroke(Color.yellow, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: -90))
                        
                        Image(systemName: "dollarsign.circle")
                            .font(.system(size: 55))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: 180)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Spent")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white.opacity(0.6))
                        
                        Text("$190")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Maximum")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white.opacity(0.6))
                            .padding(.top, 12)
                        
                        Text("$500")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                
                VStack {
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 100, height: 2)
                    
                    HStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 10, content: {
                            Text("Your Balance")
                        })
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
                .background(
                    Color.white
                        .clipShape(CustomShape(corners: [.topLeft, .topRight], radius: 35))
                        .ignoresSafeArea(.all, edges: .bottom)
                )
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
