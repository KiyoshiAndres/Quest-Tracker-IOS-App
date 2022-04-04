//
//  QuestViewModel.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 11/18/21.
//

import Foundation
import SwiftUI


struct quest {
    let questName: String
    let questCreated: Date
    var quickQuest: Bool
    var completed: Bool
}



class questViewModel {
    
    
}

struct AlertControl: UIViewControllerRepresentable {

    @Binding var textString: String
    @Binding var show: Bool

    var title: String
    var message: String
    var getTasks: () -> ()
    var addTask: (_ : String, _ : String) -> ()
    var addingTaskOrDetails: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertControl>) -> UIViewController {
        return UIViewController() // holder controller - required to present alert
    }

    func updateUIViewController(_ viewController: UIViewController, context: UIViewControllerRepresentableContext<AlertControl>) {
        guard context.coordinator.alert == nil else { return }
        if self.show {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert

            alert.addTextField { textField in
                textField.placeholder = "Enter some text"
                textField.text = self.textString            // << initial value if any
                textField.delegate = context.coordinator    // << use coordinator as delegate
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive) { _ in
                textString = ""
            })
            
            
            alert.addAction(UIAlertAction(title: "Submit", style: .default) { _ in
                addTask("type", textString)
                textString = ""
                getTasks()
            })
           
            
          

            DispatchQueue.main.async { // must be async !!
                viewController.present(alert, animated: true, completion: {
                    self.show = false  // hide holder after alert dismiss
                    context.coordinator.alert = nil
                })
            }
        }
    }
    
    
    
    private func addDetail(interval: String, detailTitle: String, quest: Quest) {
        let detail = Detail(context: CoreDataStack.viewContext)
        detail.title = detailTitle
        detail.completed = false
        detail.quest = quest
        CoreDataStack.save()
    }

    func makeCoordinator() -> AlertControl.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var alert: UIAlertController?
        var control: AlertControl
        init(_ control: AlertControl) {
            self.control = control
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text as NSString? {
                self.control.textString = text.replacingCharacters(in: range, with: string)
            } else {
                self.control.textString = ""
            }
            return true
        }
    }
}








// quickQuest will control if user wants to have access to the template quest or not
