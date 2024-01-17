//
//  ContentView.swift
//  DamageCalcApp
//
//  Created by Peter Szots on 22/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var textFieldIsFocused: Bool
    @State private var weaponsArray = ["Bare hands", "Sword", "Axe", "Knife", "Staff"]
    @State private var weaponSelector = "Bare hands"
    @State private var addWeapon = ""
    @State private var addWeaponDamage = 0
    @State private var addDamageModifier = 0
    @State private var d6 = 0

 
// this shows the selected weapon's damage
    var weaponDamageValue: Int {
        
        switch (weaponSelector) {
        case "Sword" :
            return 10
        case "Axe" :
            return 8
        case "Knife" :
            return 3
        case "Staff" :
            return 1
        
        default:
            return 0
        }
    }

// this calculates the selected weapon's damage
    var totalDamage: Int {
        
        switch (weaponSelector) {
        case "Sword" :
            return d6 + 10
        case "Axe" :
            return d6 + 8
        case "Knife" :
            return d6 + 3
        case "Staff" :
            return d6 + 1
        
        default:
            return d6
        }
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    Picker("Chose your weapon", selection: $weaponSelector) {
                        ForEach(weaponsArray, id: \.self) {
                            Text($0)
                        }
                    }
                }header: {
                    Text("Weapon selector")
                        .font(.caption)
                }footer: {
                    Text("The \(weaponSelector) damage value is:  \(weaponDamageValue)")
                        .font(.caption)
                }
                
                Section {
                    TextField ("Add your weapon", text: $addWeapon) {
                        weaponsArray.append(addWeapon)
                        addWeapon = ""
                    }
                    Picker("Add weapon damage", selection: $addWeaponDamage){
                        ForEach(0..<21) {
                            Text($0, format: .number)
                        }
                    }
                    Picker("Add damage modifier", selection: $addDamageModifier){
                        ForEach(0..<11) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.automatic)
                    
                }header: {
                    Text("Add a weapon to the list")
                        .font(.caption)
                }
                
                Section {
                    HStack {
                        Button("Roll the dice") {
                            d6 = Int.random(in: 1...6)
                        }
                        .font(.callout .bold() .italic())
                        Spacer()
                        Text("\(d6)")
                    }
                }
                
                Section {
                    Text(totalDamage + addDamageModifier, format: .number)
                } header: {
                    Text("Total damage (Weapon + Modif + Roll)")
                        .font(.caption)
                }
                
            }
            .navigationBarTitle("Damage Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        weaponsArray.append(addWeapon)
                        addWeapon = ""
                        textFieldIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
