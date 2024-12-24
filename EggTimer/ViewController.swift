
import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var eggTime : [String : Int] = ["Soft" : 180,
                                    "Medium" : 300,
                                    "Hard" : 480]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressView.progress = 1.0
        let hardness = sender.currentTitle
        
        progressView.progress = 0.0
        secondsPassed = 0
        textLabel.text = hardness
        
        totalTime = eggTime[hardness!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter),
                                     userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            textLabel.text = "Done!"
            playSound()
        }
        
    }
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
