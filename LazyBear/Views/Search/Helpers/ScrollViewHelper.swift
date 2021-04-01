//
//  ScrollViewHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 1/4/21.
//

import SwiftUI

struct ScrollViewHelper: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                let tags = companyTags.shuffled().prefix(10)
                ForEach(tags, id: \.self) { tag in
                    ContainerHelper(tag: tag.name)
                        .frame(height: 350)
                }
            }
        }
    }
}

struct ScrollViewHelper_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewHelper()
    }
}
