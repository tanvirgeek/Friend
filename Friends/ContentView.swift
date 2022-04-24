//
//  ContentView.swift
//  Friends
//
//  Created by Tanvir Alam on 24/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            SideBarView()
            //PrimaryView()
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
