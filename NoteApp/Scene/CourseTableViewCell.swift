
import UIKit

class CourseTableViewCell: UITableViewCell {
  // MARK: IBOutlet
  @IBOutlet weak var point2Label: UILabel!
  @IBOutlet weak var courseNameLabel: UILabel!
  @IBOutlet weak var point1Label: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
