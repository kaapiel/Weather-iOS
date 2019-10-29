//
//  MenuContentView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 20/09/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct MenuContentView: View {
    
    @State private var showingAlert = false
    @State private var showingSheet = false
    @State var sayHello = false
    
    var name: String
    
    var body: some View {
        VStack {
            Image("ic_happy")
                .resizable()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .shadow(radius: 10)
                .padding(.top, 100)
            
            HStack {
                Text("Olá,")
                    .font(.headline)
                
                Text(name)
                    .font(.title)
                    .padding()
            }
            
            Divider()
            
            List {
                Button(action: { self.alert() }) { Text("Sugestões") }
                    .padding()
                
                Button(action: {
                    self.showingAlert = true
                }) {
                    Text("Sair")
                }
                .padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Sair"), message: Text("Vai sair mesmo do app? :("),
                          primaryButton: .destructive(Text("Tá doido?")) {
                            //do nothing
                        },
                          secondaryButton: .default(Text("Partiu!")) {
                            NavigationLink(destination: LoginView()) {
                                Text("Push")
                            }
                        })
                }
            }
        }
    }
    
    private func alert() {
        let alert = UIAlertController(title: "O seu feedback nos ajuda muito!", message: "Diga-nos o que podemos fazer para melhorar", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "Digite aqui"
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive) { _ in})
        alert.addAction(UIAlertAction(title: "Enviar", style: .default) { _ in
            self.callRatingDialog()
        })
        showAlert(alert: alert)
    }
    
    private func callRatingDialog() {
        
        let controller = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: "RatingViewController")
        
        let viewController = controller as! RatingViewControler
        self.showRating(view: viewController)
    }
    
    func showRating(view: UIViewController) {
        if let controller = topMostViewController() {
            controller.present(view, animated: true)
        }
    }
    
    func showAlert(alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
        }
    }
    
    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .compactMap {$0 as? UIWindowScene}
            .first?.windows.filter {$0.isKeyWindow}.first
    }
    
    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }
    
    private func topMostViewController(for controller: UIViewController) -> UIViewController? {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
    
}
