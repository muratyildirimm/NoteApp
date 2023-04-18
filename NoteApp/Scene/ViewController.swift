
import UIKit

class ViewController: UIViewController {
  // MARK: IBOutlet
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  // MARK: Variables
  var courseList = [Course]()
  var courseDao = CourseDao()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    CourseDao.copyDatabase()
    // Sometimes drag and drop bar button item on the storyboard causes an error, so i handle it with code
    navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addButton))
  }

  override func viewWillAppear(_ animated: Bool) {
    courseList = courseDao.getAllCourse()
    var total = 0
    for i in courseList {
      total += (i.grade1! + i.grade2!)/2
    }
    if courseList.count != 0 {
      total = total / courseList.count
      navigationItem.prompt = String(total)
    } else {
      navigationItem.prompt = "No Course Yet"
    }
    tableView.reloadData()
  }
  // Go to ddd view controller
  @objc func addButton() {
    performSegue(withIdentifier: "toAddNoteVC", sender: nil)
  }
  // Send course info to detail view controller
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    guard let sender = sender else {
      return
    }
    let index = sender as? Int
    guard let index = index else {
      return
    }
    if segue.identifier == "toDetailVC" {
      let destination = segue.destination as! CourseDetailViewController
      destination.course = courseList[index]
    }
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let course = courseList[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseTableViewCell
    cell.courseNameLabel.text = course.courseName!
    cell.point1Label.text = String(course.grade1!)
    cell.point2Label.text = String(course.grade2!)
    return cell
    }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return courseList.count
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    courseList = courseDao.searchCourse(courseName: searchText)
    tableView.reloadData()
  }
}
