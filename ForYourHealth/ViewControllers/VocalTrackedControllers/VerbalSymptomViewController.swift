//
//  VerbalSymptomViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/10/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit
import Speech
import AVKit

//needs to say sorry, I didnt hear that...and ask to repeat answer

class VerbalSymptomViewController: UIViewController, AVSpeechSynthesizerDelegate, SFSpeechRecognitionTaskDelegate  {
    
    //MARK: -Variables from model
    let user = UserController.shared.user
    let symptomIndex = UserController.shared.user.symptoms?.count
    var index = 0
    
    //MARK: -Variables for reading/speech
    let speechRecognizer = SFSpeechRecognizer()
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    var timer: Timer?
    var response: String?
    let synth = AVSpeechSynthesizer()
    var utterence = AVSpeechUtterance(string: "")
    var textToRead = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var symptomLabel: UILabel!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //MARK: -Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if symptomIndex == 0 {
            performSegue(withIdentifier: "toJournalEntry", sender: nil)
        } else {
        titleLabel.font = titleFont
        titleLabel.text = "On a scale from 1 to 10..."
        titleLabel.textColor = darkShade
        symptomLabel.textColor = mainBrandColor
        symptomLabel.font = symptomFont
        cancelButton.setTitle("Exit", for: .normal)
        cancelButton.titleLabel?.font = cancelFont
        cancelButton.setTitleColor(darkAccent, for: .normal)
        view.backgroundColor = lightShade
        requestSpeechAuth()
        updateView()
        cancelButton.isHidden = true
        }
        
    }
    
    deinit {
        timer?.invalidate()
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.recognitionRequest?.endAudio()
        self.audioEngine.stop()
        self.recognitionRequest = nil
        self.recognitionTask?.finish()
        self.recognitionTask = nil
        self.timer?.invalidate()
        audioEngine.inputNode.removeTap(onBus: 0)
        dismiss(animated: true, completion: nil)
//        performSegue(withIdentifier: "exitToTab", sender: nil)
    }
    
    //MARK: -Functions
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
                    self.symptomLabel.text = symptom.detail
                    self.utterence = AVSpeechUtterance(string: "\(self.symptomLabel.text!) from 0 to 10")
                    self.utterence.rate = 0.4
                    self.utterence.volume = 1.0
                    do {
                    try AVAudioSession().setCategory(.playAndRecord, mode: .default, policy: .default, options: [.allowBluetooth, .defaultToSpeaker])
                    }catch{
                        print("🚷🚷🚷🚷🚷🚷🚷\(error)🚷🚷🚷🚷🚷🚷🚷🚷")
                    }
                    self.synth.speak(self.utterence)
                    self.synth.delegate = self
                }
            }
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        do {
            try startRecording()
        } catch {
            print("Recording Not Available")
        }
        cancelButton.isHidden = false
    }
    
    func startRecording() throws {
        
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        let audioSession = AVAudioSession.sharedInstance()
        
        try audioSession.setCategory(.record, mode: .measurement, options: .interruptSpokenAudioAndMixWithOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, delegate: self)
        
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didHypothesizeTranscription transcription: SFTranscription) {
        response = transcription.formattedString
        print("Text \(transcription.formattedString)")
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { [weak self] timer in
            self?.response = transcription.formattedString
            self?.stopRecording()
        })
    }
    
    func stopRecording(){
        self.recognitionRequest?.endAudio()
        self.audioEngine.stop()
        self.recognitionRequest = nil
        self.recognitionTask?.finish()
        self.recognitionTask = nil
        
        audioEngine.inputNode.removeTap(onBus: 0)
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom,
        let response = response?.lowercased() else {return}
        
        //MARK: -Possibled responses
        if response.contains("one") || response.contains("wen"){
            oneButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "1", symptom: symptom)
        } else if response.contains("two") || response.contains("to") || response.contains("too") || response.contains("u") || response.contains("you"){
            twoButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "2", symptom: symptom)
        } else if response.contains("three") || response.contains("tree") || response.contains("free"){
            threeButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "3", symptom: symptom)
        } else if response.contains("four") || response.contains("for") || response.contains("fore") || response.contains("or"){
            fourButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "4", symptom: symptom)
        } else if response.contains("five") || response.contains("dive"){
            fiveButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "5", symptom: symptom)
        } else if response.contains("six"){
            sixButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "6", symptom: symptom)
        } else if response.contains("seven") || response.contains("evan") || response.contains("even") {
            sevenButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "7", symptom: symptom)
        } else if response.contains("eight") || response.contains("ate") {
            eightButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "8", symptom: symptom)
        } else if response.contains("nine"){
            nineButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "9", symptom: symptom)
        } else if response.contains("ten") || response.contains("10") || response.contains("den"){
            tenButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "10", symptom: symptom)
        } else if response.contains("zero") || response.contains("0"){
            zeroButton.backgroundColor = darkAccent
            RatingController.shared.createRating(number: "0", symptom: symptom)
        } else {
            return
        }
        cancelButton.isHidden = true
        self.index += 1
    }
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
            guard let symptomIndex = self?.symptomIndex else {return}
            guard  self!.index < (symptomIndex) else { self?.performSegue(withIdentifier: "toJournalEntry", sender: nil); return }
            guard let symptom = self!.user.symptoms?.object(at: self!.index) as? Symptom else {return}
            self?.symptomLabel.text = symptom.detail
            self?.requestSpeechAuth()
            self?.updateView()
        })
        
    }
    
    func updateView(){
        zeroButton.setTitleColor(darkAccent, for: .normal)
        oneButton.setTitleColor(darkAccent, for: .normal)
        twoButton.setTitleColor(darkAccent, for: .normal)
        threeButton.setTitleColor(darkAccent, for: .normal)
        fourButton.setTitleColor(darkAccent, for: .normal)
        fiveButton.setTitleColor(darkAccent, for: .normal)
        sixButton.setTitleColor(darkAccent, for: .normal)
        sevenButton.setTitleColor(darkAccent, for: .normal)
        eightButton.setTitleColor(darkAccent, for: .normal)
        nineButton.setTitleColor(darkAccent, for: .normal)
        tenButton.setTitleColor(darkAccent, for: .normal)
        zeroButton.backgroundColor = lightAccent
        oneButton.backgroundColor = lightAccent
        twoButton.backgroundColor = lightAccent
        threeButton.backgroundColor = lightAccent
        fourButton.backgroundColor = lightAccent
        fiveButton.backgroundColor = lightAccent
        sixButton.backgroundColor = lightAccent
        sevenButton.backgroundColor = lightAccent
        eightButton.backgroundColor = lightAccent
        nineButton.backgroundColor = lightAccent
        tenButton.backgroundColor = lightAccent
        zeroButton.layer.cornerRadius = zeroButton.frame.height/roundDivider
        oneButton.layer.cornerRadius = oneButton.frame.height/roundDivider
        twoButton.layer.cornerRadius = twoButton.frame.height/roundDivider
        threeButton.layer.cornerRadius = threeButton.frame.height/roundDivider
        fourButton.layer.cornerRadius = fourButton.frame.height/roundDivider
        fiveButton.layer.cornerRadius = fiveButton.frame.height/roundDivider
        sixButton.layer.cornerRadius = sixButton.frame.height/roundDivider
        sevenButton.layer.cornerRadius = sevenButton.frame.height/roundDivider
        eightButton.layer.cornerRadius = eightButton.frame.height/roundDivider
        nineButton.layer.cornerRadius = nineButton.frame.height/roundDivider
        tenButton.layer.cornerRadius = tenButton.frame.height/roundDivider
        zeroButton.titleLabel?.font = numberFont
        oneButton.titleLabel?.font = numberFont
        twoButton.titleLabel?.font = numberFont
        threeButton.titleLabel?.font = numberFont
        fourButton.titleLabel?.font = numberFont
        fiveButton.titleLabel?.font = numberFont
        sixButton.titleLabel?.font = numberFont
        sevenButton.titleLabel?.font = numberFont
        eightButton.titleLabel?.font = numberFont
        nineButton.titleLabel?.font = numberFont
        tenButton.titleLabel?.font = numberFont
    }

    func alertUser(withMessage message: String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
            }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

}
