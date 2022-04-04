//
//  MainScreenView.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 11/18/21.
//

import SwiftUI

struct MainScreenView: View {
    @AppStorage("settingActivated") var settingActivated = true
    @AppStorage("userName") var userName = ""
    @StateObject var viewModel = mainViewModel()
    @State var profileUp: Bool = false
    
    var body: some View {
        ZStack {
            ZStack {
                if settingActivated == true {
                LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), location: -0.5),
                                .init(color: Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)), location: 0.40),
                                .init(color: Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), location: 1.6)
                            ]),
                            startPoint: .leading,
                            endPoint: .bottomTrailing
                        )
                                .ignoresSafeArea()
                }
                else {
                    Color(red: 0.92, green: 0.69, blue: 0.5).edgesIgnoringSafeArea(.all)
                    LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), location: -0.5),
                                    .init(color: Color(#colorLiteral(red: 0.948129952, green: 0.7973102331, blue: 0.7513424754, alpha: 1)), location: 0.20),
                                    .init(color: Color(#colorLiteral(red: 0.948129952, green: 0.7973102331, blue: 0.7513424754, alpha: 1)), location: 0.40),
                                    .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), location: 1.6)
                                ]),
                                startPoint: .leading,
                                endPoint: .bottomTrailing
                            )
                    Rectangle()
                        .strokeBorder(lineWidth: 3)
                        .foregroundColor(Color(#colorLiteral(red: 0.911426127, green: 0.6610416174, blue: 0, alpha: 1)))
                }
                VStack {
                    /*
                    HStack{
                        Toggle(isOn: $settingActivated) {
                            
                        }
                        .padding(.all)
                    }
                     */
                    
                    if settingActivated == true {
                        
                        HStack {
                            Text(getGreeting())
                                .font(.custom("Futura", size: 25))
                                .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1)))
                                .padding()
                            Spacer()
                        }
                        
                        Spacer()
                        VStack {
                            
                        
                        NavigationLink(destination: { MissionView(type: "Daily Tasks", textTitle: "Today's Tasks").environmentObject(viewModel) }, label: { taskButton(buttonText: "Daily Tasks", color: Color.orange) })
                            .simultaneousGesture(TapGesture().onEnded{
                                
                                viewModel.addBunch(type: "Daily Tasks")  })
                        HStack {
                            NavigationLink(destination: { MissionView(type: "Weekly Tasks", textTitle: "This Week's Tasks").environmentObject(viewModel) }, label: { taskButton(buttonText: "Weekly Tasks", color: Color.orange) })
                                .simultaneousGesture(TapGesture().onEnded{  viewModel.addBunch(type: "Weekly Tasks")  })
                            NavigationLink(destination: { MissionView(type: "Monthly Tasks", textTitle: "This Month's Tasks").environmentObject(viewModel) }, label: { taskButton(buttonText: "Monthly Tasks", color: Color.yellow) })
                                .simultaneousGesture(TapGesture().onEnded{  viewModel.addBunch(type: "Monthly Tasks")  })
                        }
                        NavigationLink(destination: { MissionView(type: "Yearly Tasks", textTitle: "This Year's Tasks").environmentObject(viewModel) }, label: { taskButton(buttonText: "Yearly Tasks", color: Color.yellow) })
                            .simultaneousGesture(TapGesture().onEnded{  viewModel.addBunch(type: "Yearly Tasks")  })
                        }.blur(radius: profileUp ? 3 : 0)
                        
                        
                        
                        
                        Spacer()
                        ZStack {
                            HStack {
                                
                                Button(action: { profileUp = !profileUp
                                }, label: { Image(systemName: "person.fill")
                                        .font(.title)
                                        .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1)))
                                        .padding() } )
                                
                                
                        
                                Spacer()
                            }
                            NavigationLink(destination: { ArchiveView().environmentObject(viewModel) }, label: { Text("Archive")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1)))
                                    .padding()
                                
                            })
                        }
                        /*
                        NavigationLink(destination: { Debugger().environmentObject(viewModel)  }, label: { Text("Debugger")
                            .foregroundColor(Color.white) })
                        */
                        
                    }
                    else {
                        HStack {
                            Text(getGreeting())
                                .font(.custom("Bradley Hand", size: 40))
                                .fontWeight(.heavy)
                                .shadow(color: .gray, radius: 1, x: 0, y: 2)
                                .foregroundColor(.black)
                                .padding(.leading)
                            Spacer()
                        }
                        
                        
                        NavigationLink(destination: { MissionView(type: "Daily Quests", textTitle: "Today's Quests") }, label: {  questTab(tabText: "Daily Quests", color: .black) })
                        
                        NavigationLink(destination: { MissionView(type: "Weekly Quests", textTitle: "Today's Quests") }, label: {  questTab(tabText: "Weekly Quests", color: .black) })
                        
                        NavigationLink(destination: { MissionView(type: "Monthly Quests", textTitle: "Today's Quests") }, label: {  questTab(tabText: "Monthly Quests", color: .black) })
                        
                        HStack {
                            NavigationLink(destination: { MissionView(type: "Yearly Quests", textTitle: "Today's Quests") }, label: {  questTab(tabText: "Yearly Quests", color: .black) })
                        }
                        
                        
                        
                        Spacer()
                        
                        NavigationLink(destination: { ArchiveView() }, label: { oldQuestTab()
                            
                        })
                        
                    }
                    
                }
                
                //up to here is if
                
            }
            
            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .padding()
                        .opacity(0.7)
                    .foregroundColor(.white)
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: { profileUp = false }, label: { Image(systemName: "xmark.circle")
                                    .font(.title)
                                    .foregroundColor(.red) })
                                .padding(25)
                            
                            
                        }
                        Spacer()
                    }
                    ZStack {
                        VStack {
                            ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .padding(26)
                                .aspectRatio(2.8, contentMode: .fit)
                            .foregroundColor(.red)
                                VStack {
                                    HStack {
                                        Text("Total Exp: ")
                                            .font(.custom("Futura", size: 25))
                                            .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.9, blue: 0.8, alpha: 1)))
                                            
                                        
                                        Text("\(viewModel.getTotalExp())")
                                            .font(.custom("Futura", size: 25))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Text("\(viewModel.getRank())")
                                        .font(.custom("Futura", size: 25))
                                        .foregroundColor(.white)
                                        .shadow(color: viewModel.getRankColor(), radius: 8)
                                }
                                
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .padding(26)
                                    .aspectRatio(2, contentMode: .fit)
                                .foregroundColor(.white)
                                
                                VStack {
                                    Image(systemName: "gearshape")
                                        .font(.title)
                                        .padding()
                                    
                                    Button(action: {  UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                        if success {
                                            print("All set!")
                                        } else if let error = error {
                                            print(error.localizedDescription)
                                        }
                                    }  }, label: {  Text("Enable Push Notifications")
                                            .font(.custom("Futura", size: 20))
                                    })
                                        .foregroundColor(.blue)
                                }
                                
                            }

                        }
                            
                        
                    }
                }.aspectRatio(1, contentMode: .fit)
                
                Spacer()
            }.opacity(profileUp ? 1 : 0)
            
            
        }.onAppear(perform: { viewModel.getAbsoluteAllQuests() })
    }
    
    private func getGreeting() -> String {
            let hour = Calendar.current.component(.hour, from: Date())

            switch hour {
            case 0..<4:
                return "Greetings"
            case 4..<12:
                return "Good morning"
            case 12..<18:
                return "Good afternoon"
            case 18..<24:
                return "Good evening"
            default:
                break
            }
            return "Hello"
        }
}




struct questTab: View {
    var tabText: String
    var color: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), location: -0.5),
                        .init(color: Color(#colorLiteral(red: 0.948129952, green: 0.7973102331, blue: 0.7513424754, alpha: 1)), location: 0.20),
                        .init(color: Color(#colorLiteral(red: 0.948129952, green: 0.7973102331, blue: 0.7513424754, alpha: 1)), location: 0.40),
                        .init(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), location: 1.6)
                    ]),
                    startPoint: .leading,
                    endPoint: .bottomTrailing
                ))
                .shadow(color: .black, radius: 3, x: 0, y: 2)
                .aspectRatio(7, contentMode: .fit)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), location: -0.5),
                        .init(color: Color(#colorLiteral(red: 0.8719302416, green: 0.7394381166, blue: 0.6952608824, alpha: 1)), location: 0.20),
                        .init(color: Color(#colorLiteral(red: 0.948129952, green: 0.7973102331, blue: 0.7513424754, alpha: 1)), location: 0.40),
                        .init(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), location: 1.6)
                    ]),
                    startPoint: .leading,
                    endPoint: .bottomTrailing
                ))
                .aspectRatio(8, contentMode: .fit)
                .padding(.leading)
            
            HStack {
                Text(tabText)
                    .font(.custom("Bradley Hand", size: 30))
                    .fontWeight(.heavy)
                    .padding(.leading)
                    .foregroundColor(color)
                    
                Spacer()
            }
        }.padding([.top, .leading, .bottom])
    
    }
}


struct oldQuestTab: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor( Color(red: 0.97, green: 0.85, blue: 0.7))
                .shadow(color: .black, radius: 3, x: 0, y: 2)
                .aspectRatio(6, contentMode: .fit)
            
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor( Color(red: 0.97, green: 0.82, blue: 0.7))
                .aspectRatio(8, contentMode: .fit)
                .padding(.trailing)
            
            HStack {
                Text("Old Quests")
                        .font(.custom("Bradley Hand", size: 40))
                        .fontWeight(.medium)
                        .shadow(color: .red, radius: 1, x: 0, y: 2)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.2, blue: 0.2, alpha: 1)))
                        .padding()
                    
                
            }
        }.padding([.top, .trailing, .bottom])
    
    }
}






struct taskButton: View {
    var buttonText: String
    var color: Color

    var body: some View {
       
            Text(buttonText)
                .fontWeight(.heavy)
                .foregroundColor(color)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(lineWidth: 3)
                        .foregroundColor(color)
                        .shadow(color: color, radius: 5)
                ).padding()
           
    }
}







struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
