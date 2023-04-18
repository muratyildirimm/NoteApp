
import Foundation

class Course {
  var courseId: Int?
  var courseName: String?
  var grade1: Int?
  var grade2: Int?
  
  init() {
    
  }
  
  init(courseId: Int?, courseName: String?, grade1: Int?, grade2: Int?) {
    self.courseId = courseId
    self.courseName = courseName
    self.grade1 = grade1
    self.grade2 = grade2
  }
}
