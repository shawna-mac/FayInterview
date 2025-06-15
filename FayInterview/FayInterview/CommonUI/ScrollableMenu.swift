//
//  ScrollableMenu.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/14/25.
//

import SwiftUI

// reusable menu
struct ScrollableMenu<Item: Hashable & Identifiable, Content: View>: View {

    @Binding var selection: Item
    let options: [Item]
    let label: ((Item) -> Content)

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(options) { item in
                        Button(action: {
                            withAnimation {
                                selection = item
                            }
                        }, label: {
                            VStack(spacing: 0) {
                                label(item)
                                    .padding(12)
                                Rectangle()
                                    .fill(Color.secondaryAccent)
                                    .frame(width: selection == item ? 75 : 0, height: 3)
                                    .opacity(selection == item ? 1 : 0)
                            }
                        })
                        .buttonStyle(.plain)
                    }
                }
                .padding(.leading, 12)
            }

            Divider()
        }
        .frame(maxWidth: .infinity)
    }
}
