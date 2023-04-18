
import UIKit

class AddCourseViewController: UIViewController {
  
  @IBOutlet weak var courseNameTF: UITextField!
  @IBOutlet weak var grade1TF: UITextField!
  @IBOutlet weak var grade2TF: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Add gesture to view for dismissing keyboard when you tap by anywhere in the screen
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
  }
  // Dissmiss keyboard method
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  // Add a course to database
  @IBAction func addButton(_ sender: Any) {
    let courseName = courseNameTF.text
    let grade1 = grade1TF.text
    let grade2 = grade2TF.text
    guard let courseName , let grade1 = grade1, let grade2 = grade2 else{
      return
    }
    
    if let grade1 = Int(grade1), let grade2 = Int(grade2) {
      CourseDao().addCourse(courseName: courseName, grade1: grade1, grade2: grade2)
      // if adding operation is successful, turn to rood view
      navigationController?.popToRootViewController(animated: true)
    } else {
      let alertController = createAlertController(title: "Attention", message: "Fill in the blanks")
      let alertAction = createAlertAction(actionTitle: "OK")
      alertController.addAction(alertAction)
      self.present(alertController, animated: true)
    }
  }
  // Creating alert controller
  func createAlertController(title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    return alert
  }
  // Creating alert action
  func createAlertAction(actionTitle: String) -> UIAlertAction {
    let alertAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default)
    return alertAction
  }
}
