
import Foundation

class CourseDao {
  // MARK: Variable
  let db : FMDatabase?
  
 init() {
    let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let databaseURL = URL(fileURLWithPath: targetPath).appendingPathComponent(Database.dbFullName.rawValue)
    db = FMDatabase(path: databaseURL.path)
  }
  // Copy databese to phone
  static func copyDatabase(){
    let bundlePath = Bundle.main.path(forResource: Database.dbName.rawValue, ofType: Database.dbExtension.rawValue)
    let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let fileManager = FileManager.default
    let toCopyPath = URL(fileURLWithPath: targetPath).appendingPathComponent(Database.dbFullName.rawValue)
    
    if fileManager.fileExists(atPath: toCopyPath.path){
      print(Database.dbWarning.rawValue)
    }else{
      do{
        try fileManager.copyItem(atPath: bundlePath!, toPath: toCopyPath.path)
      }catch{
        print(error)
      }
    }
  }
  // Get all course from database
  func getAllCourse() -> [Course] {
    var courses = [Course]()
    db?.open()
    do {
      let rs = try db!.executeQuery("SELECT * FROM courses", values: nil)
      while rs.next() {
        let course = Course(courseId: Int(rs.string(forColumn: "courseId"))!, courseName: rs.string(forColumn: "courseName")!, grade1: Int(rs.string(forColumn: "grade1"))!, grade2: Int(rs.string(forColumn: "grade2"))!)
        courses.append(course)
      }
    }catch{
      print(error.localizedDescription)
    }
    db?.close()
    return courses
  }
  // Add course to database
  func addCourse(courseName: String, grade1: Int, grade2: Int) {
    db?.open()
    do{
      try db?.executeUpdate("INSERT INTO courses (courseName, grade1, grade2) VALUES (?, ?, ?)", values: [courseName, grade1, grade2])
    } catch {
      print(error.localizedDescription)
    }
    db?.close()
  }
  // Update course in database
  func updateCourse(courseId: Int, courseName: String, grade1: Int, grade2: Int) {
    db?.open()
    do{
      try db?.executeUpdate("UPDATE courses SET courseName = ?, grade1 = ?, grade2 = ? WHERE courseId = ?", values: [courseName, grade1, grade2, courseId])
    } catch {
      print(error.localizedDescription)
    }
    db?.close()
  }
  // Delete course from database
  func deleteCourse(courseId: Int) {
    db?.open()
    do{
      try db?.executeUpdate("DELETE FROM courses WHERE courseId = ?", values: [courseId])
    } catch {
      print(error.localizedDescription)
    }
    db?.close()
  }
  // Search function for search bar
  func searchCourse(courseName: String) -> [Course] {
    db?.open()
    var courses = [Course]()
    do {
     let rs = try db!.executeQuery("SELECT * FROM courses WHERE courseName like '%\(courseName)%'", values: [courseName])
      while rs.next() {
        let course = Course(courseId: Int(rs.string(forColumn: "courseId"))!, courseName: rs.string(forColumn: "courseName")!, grade1: Int(rs.string(forColumn: "grade1"))!, grade2: Int(rs.string(forColumn: "grade2"))!)
        courses.append(course)
      }
    } catch {
      print(error.localizedDescription)
    }
    db?.close()
    return courses
  }
}
