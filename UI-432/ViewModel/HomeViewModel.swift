//
//  HomeViewModel.swift
//  UI-432
//
//  Created by nyannyan0328 on 2022/01/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var showShareSheet : Bool = false
    @Published var pdfURL : URL?
    
}


