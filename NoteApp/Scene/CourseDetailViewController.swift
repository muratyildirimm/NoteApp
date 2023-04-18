
import UIKit

class CourseDetailViewController: UIViewController {
  // MARK: IBOutlet
  @IBOutlet weak var courseNameTF: UITextField!
  @IBOutlet weak var grade1TF: UITextField!
  @IBOutlet weak var grade2TF: UITextField!
  // MARK: Variable
  var course : Course?
    override func viewDidLoad() {
        super.viewDidLoad()
      guard let course = course else {
        return
      }
      courseNameTF.text = course.courseName!
      grade1TF.text = String(course.grade1!)
      grade2TF.text = String(course.grade2!)
    }
    
  @IBAction func updateButton(_ sender: Any) {
    let newCourseName = courseNameTF.text
    let newGrade1 = grade1TF.text
    let newGrade2 = grade2TF.text
    guard let newCourseName = newCourseName, let newGrade1 = newGrade1, let newGrade2 = newGrade2 else {
      return
    }
    if let newGrade1 = Int(newGrade1) {
      if let newGrade2 = Int(newGrade2) {
        CourseDao().updateCourse(courseId: (course?.courseId)!, courseName: newCourseName, grade1: newGrade1, grade2: newGrade2)
      }
    }
    navigationController?.popToRootViewController(animated: true)
  }
  
  @IBAction func deleteButton(_ sender: Any) {
    courseNameTF.text = ""
    grade1TF.text = ""
    grade2TF.text = ""
    guard let course = course else {
      return
    }
    CourseDao().deleteCourse(courseId: course.courseId!)
    navigationController?.popViewController(animated: true)
      }
}
