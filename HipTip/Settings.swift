//
//  Settings.swift
//  HipTip
//
//  Created by Tajwar Rahman on 7/3/21.
//

import SwiftUI

struct Settings: View {
    @AppStorage("darkMode") private var darkMode = false
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Dark Mode", isOn: $darkMode)
                }
            }.navigationBarTitle("Settings", displayMode: .inline)
            Spacer()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
