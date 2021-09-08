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
    
    @State private var weeks: [Week] = []
    
    // Current week day
    @State private var currentDay: Week = Week(day: "", date: "", amountSpent: 0)
    
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
                        
                        // Some max amount for week
                        let progress: CGFloat = currentDay.amountSpent / 500
                        
                        Circle()
                            .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: progress)
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
                        
                        let amount = String(format: "%.2f", currentDay.amountSpent)
                        Text("$\(amount)")
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
                
                ZStack {
                    if UIScreen.main.bounds.height < 750 {
                        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                            BottomSheet(weeks: $weeks, currentDay: $currentDay)
                        })
                    } else {
                        BottomSheet(weeks: $weeks, currentDay: $currentDay)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
                .background(
                    Color.white
                        .clipShape(CustomShape(corners: [.topLeft, .topRight], radius: 35))
                        .ignoresSafeArea(.all, edges: .bottom)
                )
                .onAppear {
                    getWeekDays()
                }
            }
        }
    }
    
    // Getting current week 7 days
    func getWeekDays() {
        let calender = Calendar.current
        
        let week = calender.dateInterval(of: .weekOfMonth, for: Date())
        
        guard let startDate = week?.start else {
            return
        }
        
        // Whole week days
        for index in 0..<7 {
            guard let date = calender.date(byAdding: .day, value: index, to: startDate) else {
                return
            }
            
            let formatter = DateFormatter()
            // EEE will be used to get day like Mon, Tue,...
            formatter.dateFormat = "EEE"
            var day = formatter.string(from: date)
            // Since we need like Mo Tu...
            day.removeLast()
            
            formatter.dateFormat = "dd"
            let dateString = formatter.string(from: date)
            
            weeks.append(Week(day: day, date: dateString, amountSpent: index == 0 ? 60 : CGFloat(index) * 60))
        }
        
        self.currentDay = weeks.first!
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct BottomSheet: View {
    @Binding var weeks: [Week]
    @Binding var currentDay: Week
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray)
                .frame(width: 100, height: 2)
            
            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Your Balance")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Wed 8 Sep 2021")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                })
                
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2)
                        .foregroundColor(.black)
                })
                .offset(x: -10.0)
            }
            .padding(.top)
            
            HStack {
                Text("$22,306.07")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "arrow.up")
                    .foregroundColor(.gray)
                
                Text("14%")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding(.top, 8)
            
            HStack {
                ForEach(weeks) { week in
                    VStack(spacing: 12) {
                        Text(week.day)
                            .fontWeight(.bold)
                            .foregroundColor(currentDay.id == week.id ? Color.white.opacity(0.8) : .black)
                        
                        Text(week.date)
                            .fontWeight(.bold)
                            .foregroundColor(currentDay.id == week.id ? Color.white : .black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.yellow.opacity(currentDay.id == week.id ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            currentDay = week
                        }
                    }
                }
            }
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "arrow.right")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 25)
                    .padding(.vertical)
                    .padding(.horizontal, 40)
                    .background(Color("bg"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
            })
            .padding(.top)
            
        }
    }
}
