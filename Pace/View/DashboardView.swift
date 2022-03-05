//
//  DashboardView.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-26.
//

import SwiftUI
import URLImage

struct DashboardView: View {
    @EnvironmentObject var auth: SessionStore
    
    var body: some View {
        NavigationView {
        ScrollView() {
            Text("In progress...")
                .bold()
                .padding(.top, 400)
    
            
        }
        .navigationBarTitleDisplayMode(.large)

        .navigationTitle(Text("Dashboard"))
        .navigationBarLargeTitleItems(trailing: URLImage(url: (URL(string: auth.user?.profileImage ?? "") ?? URL(string: "https://picsum.photos/200"))!) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .cornerRadius(30)
                .padding(.trailing)
        })
      
        }
        .navigationViewStyle(StackNavigationViewStyle())
           
          
        
       
        
       
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

public extension View {
    func navigationBarLargeTitleItems<L>(trailing: L) -> some View where L : View {
        overlay(NavigationBarLargeTitleItems(trailing: trailing).frame(width: 0, height: 0))
    }
}

fileprivate struct NavigationBarLargeTitleItems<L : View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = Wrapper
    
    private let trailingItems: L
    
    init(trailing: L) {
        self.trailingItems = trailing
    }
    
    func makeUIViewController(context: Context) -> Wrapper {
        Wrapper(representable: self)
    }
    
    func updateUIViewController(_ uiViewController: Wrapper, context: Context) {
    }
    
    class Wrapper: UIViewController {
        private let representable: NavigationBarLargeTitleItems?
        
        init(representable: NavigationBarLargeTitleItems) {
            self.representable = representable
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            self.representable = nil
            super.init(coder: coder)
        }
                
        override func viewWillAppear(_ animated: Bool) {
            guard let representable = self.representable else { return }
            guard let navigationBar = self.navigationController?.navigationBar else { return }
            guard let UINavigationBarLargeTitleView = NSClassFromString("_UINavigationBarLargeTitleView") else { return }
           
            navigationBar.subviews.forEach { subview in
                if subview.isKind(of: UINavigationBarLargeTitleView.self) {
                    let controller = UIHostingController(rootView: representable.trailingItems)
                    controller.view.translatesAutoresizingMaskIntoConstraints = false
                    subview.addSubview(controller.view)
                    
                    NSLayoutConstraint.activate([
                        controller.view.bottomAnchor.constraint(
                            equalTo: subview.bottomAnchor,
                            constant: -15
                        ),
                        controller.view.trailingAnchor.constraint(
                            equalTo: subview.trailingAnchor,
                            constant: -view.directionalLayoutMargins.trailing
                        )
                    ])
                }
            }
        }
    }
}

