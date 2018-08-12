import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        if let profileUrl = Bundle.main.url(forResource: "embedded", withExtension: "mobileprovision") {
            do {
                let profileData = try Data(contentsOf: profileUrl)
                if let profileText = String(data: profileData, encoding: .ascii) {

                    let creationDateRegex = try NSRegularExpression(pattern: "<key>CreationDate</key>\\s*<date>(.*)</date>")
                    if let creationDateMatch = creationDateRegex.firstMatch(in: profileText, range: NSRange(profileText.startIndex..., in: profileText)) {
                        let creationDate = String(profileText[Range(creationDateMatch.range(at: 1), in: profileText)!])
                        creationDateLabel.text = "Creation Date: " + creationDate
                    }
                    
                    let expirationDateRegex = try NSRegularExpression(pattern: "<key>ExpirationDate</key>\\s*<date>(.*)</date>")
                    if let expirationDateMatch = expirationDateRegex.firstMatch(in: profileText, range: NSRange(profileText.startIndex..., in: profileText)) {
                        let expirationDate = String(profileText[Range(expirationDateMatch.range(at: 1), in: profileText)!])
                        expirationDateLabel.text = "Expiration Date: " + expirationDate
                    }
                } else {
                    let alert = UIAlertController(title: "Date & Time", message: "Error parsing expiration", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } catch {
                let alert = UIAlertController(title: "Date & Time", message: "Error reading expiration", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func executeButtonClick(_ sender: UIButton) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let content = dateFormatter.string(from: date)
        if let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let stampedFileUrl = documentsDirectoryUrl.appendingPathComponent(content + ".txt")
            do {
                try content.write(to: stampedFileUrl, atomically: false, encoding: .utf8)
            } catch {
                let alert = UIAlertController(title: "Date & Time", message: "Error writing content", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let unstampedFileUrl = documentsDirectoryUrl.appendingPathComponent("data.txt")
            do {
                try content.write(to: unstampedFileUrl, atomically: false, encoding: .utf8)
            } catch {
                let alert = UIAlertController(title: "Date & Time", message: "Error writing content", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let alert = UIAlertController(title: "Date & Time", message: content, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
