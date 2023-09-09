//
//  NavBar.swift
//  PennApps2023
//
//  Created by Owen Guo on 2023-09-08.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case scroll
    case map
    case trophy
    case gearshape
    case homepage
}

struct NavBar: View {
    @Binding var selectedTab: Tab
    @Binding var showhome: Bool
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    private var tabColor: Color {
        switch selectedTab {
        case .scroll:
            return .yellow
        case .map:
            return .green
        case .trophy:
            return .yellow
        case .gearshape:
            return .gray
        case .homepage:
            return .blue
        }
    }
    var body: some View {
        VStack {
            if(!showhome){
                HStack {
                    ForEach(Tab.allCases.dropLast(), id: \.rawValue) { tab in
                        Spacer()
                        Image(systemName: selectedTab == tab ? fillImage: tab.rawValue)
                            .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                            .foregroundColor(selectedTab == tab ? tabColor : .gray)
                            .font(.system(size:22))
                            .onTapGesture {
                                withAnimation(.easeIn(duration:0.1)) {
                                    selectedTab = tab
                                }
                            }
                        Spacer()
                    }
                }
                .frame(width: nil, height: 60)
                .background(.thinMaterial)
                .cornerRadius(15)
                .opacity(0.8)
            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(selectedTab: .constant(.scroll), showhome: .constant(true))
    }
}
 
