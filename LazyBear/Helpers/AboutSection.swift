//
//  AboutSection.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI

struct AboutSection: View {
    var companyInfo: CompanyInfoModel
    
    var body: some View {
        Text("About")
            .font(.title2)
            .fontWeight(.semibold)
        
        Text(companyInfo.description ?? "")
    }
}

struct AboutSection_Previews: PreviewProvider {
    static var previews: some View {
        AboutSection(companyInfo: CompanyInfoModel(symbol: "AAPL", companyName: "Apple Inc", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", address: "One Apple Park Way", state: "CA", country: "US"))
    }
}
