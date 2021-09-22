//
//  ContentView.swift
//  SwiftUI_List_Section
//
//  Created by Desire L on 2021/09/22.
//
//

import SwiftUI

// List Section

// Section
// row
// row
// row

// 1. 기본구조
// 2. data 가공 (원하는 형태로 표현)

// Model
struct Animal: Identifiable, CustomStringConvertible {
    let id: UUID = UUID()
    let name: String
    let index: Int

    init(_ name: String, _ index: Int) {
        self.name = name
        self.index = index
    }

    var description: String {
        "name: \(name), index: \(index)"
    }
}


struct ContentView: View {

    var animalList = [
        Animal("dog", 3),
        Animal("cat", 5),
        Animal("dog", 1),
        Animal("dog", 2),
        Animal("bird", 8),
        Animal("bird", 7),
        Animal("cat", 6),
        Animal("cat", 4),
    ]
    // dog : [dog, dog, dog]


    var groupedAnimal: [String: [Animal]] {


        var groupData = Dictionary(grouping: animalList, by: { animal in animal.name })

        for (key, value) in groupData {
            groupData[key] = value.sorted {$0.index > $1.index}
        }

        return groupData
    }


    var groupKey: [String] {
        groupedAnimal.map {
            $0.key
        }
    }

    var body: some View {
        List {
            ForEach(groupKey, id: \.self) { key in
                Section(header: Text(key)) {
                    ForEach(groupedAnimal[key]!) { (animal: Animal) in
                        HStack {
                            Image(systemName: "faceid")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30)
                                    .foregroundColor(.gray)
                            Spacer()
                            VStack {
                                Text("\(animal.name)")
                                        .font(.caption)
                                Text("\(animal.index)")
                                        .font(.caption2)
                            }
                        }
                    }
                }
            }
        }

                .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }


    #if DEBUG
    @objc class func injected() {
        UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: ContentView())
    }
    #endif
}
