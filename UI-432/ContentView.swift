//
//  ContentView.swift
//  UI-432
//
//  Created by nyannyan0328 on 2022/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var model = HomeViewModel()
    var body: some View {
        Button {
            
            exportPDF {
                self
            } competition: { status, url in
                
                
                if let url = url,status{
                    
                    model.pdfURL = url
                    model.showShareSheet.toggle()
                    
                    
                }
                
                else{
                    
                    print("Failed")
                }
                
                
            }

            
        } label: {
            
            
            Image(systemName: "square.and.arrow.up.fill")
                .font(.title)
                .foregroundColor(.black)
            
        }
        .sheet(isPresented: $model.showShareSheet) {
            model.pdfURL = nil
        } content: {
            
            
            if let pdfIRL = model.pdfURL{
                
                shareSheet(url: [pdfIRL])
            }
        }

        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct shareSheet : UIViewControllerRepresentable{
    
    let url : [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let view = UIActivityViewController(activityItems: url, applicationActivities: nil)
        
        return view
        
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
        
    }
}
