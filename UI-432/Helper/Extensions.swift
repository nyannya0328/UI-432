//
//  Extensions.swift
//  UI-432
//
//  Created by nyannyan0328 on 2022/01/23.
//

import SwiftUI


extension View{
    
    
    func convertScrollView<Content : View>(@ViewBuilder content : @escaping()->Content) -> UIScrollView{
        
        
        let scrollView = UIScrollView()
        
        let hostingController = UIHostingController(rootView: content()).view!
        
        hostingController.translatesAutoresizingMaskIntoConstraints = false
        
        
        let contains = [
            
            
            hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            
            hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            
        
            
            hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            
            hostingController.widthAnchor.constraint(equalToConstant: getRect().width)
            
            
            
            
        
        
        
        ]
        
        scrollView.addSubview(hostingController)
        scrollView.addConstraints(contains)
        
        scrollView.layoutIfNeeded()
        
        
        return scrollView
    
        
        
        
    }
    
    
    func exportPDF<Content : View>(@ViewBuilder content : @escaping()->Content,competition : @escaping(Bool,URL?) -> ()){
        
        
        let documentDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        let outPutFile = documentDirectory.appendingPathComponent("YOUREFORNAME\(UUID().uuidString).pdf")
        
        
        let pdfView = convertScrollView {
            
            
            content()
            
        }
        
        pdfView.tag = 1009
        
        let size = pdfView.contentSize
        
        pdfView.frame = CGRect(x: 0, y: getSafeArea().top, width: size.width, height: size.height)
        
        
        getRootController().view.insertSubview(pdfView, at: 0)
        
        
        let render = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        
        do{
            
            
            try render.writePDF(to: outPutFile, withActions: { context in
                
                
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            
            
            competition(true, outPutFile)
            
            
        }
        catch{
            
            
            competition(false, nil)
            
            print(error.localizedDescription)
            
        }
        
        
        
        
        
        
        
        getRootController().view.subviews.forEach { UIView in
            
            
            if UIView.tag == 1009{
                
                
                UIView.removeFromSuperview()
            }
        }
        
        
        
    }
    
    
    
    
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
        
    }
    
    func getSafeArea()->UIEdgeInsets{
        
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            
            return .zero
        }
        
        return safeArea
    }
    
    func getRootController()->UIViewController{
        
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            return .init()
        }
        
        guard let rootView = screen.windows.first?.rootViewController else{
            
            return .init()
        }
        
        return rootView
    }
}
