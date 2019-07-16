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
    
    //MARK: -Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        requestSpeechAuth()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    //MARK: -Functions
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
                    self.symptomLabel.text = symptom.detail
                    self.utterence = AVSpeechUtterance(string: self.symptomLabel.text!)
                    self.utterence.rate = 0.4
                    self.utterence.volume = 100.0
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
    }
    
    func startRecording() throws {
        
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .interruptSpokenAudioAndMixWithOthers)
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
        self.timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: { [weak self] timer in
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
            RatingController.shared.createRating(number: "1", symptom: symptom)
        } else if response.contains("two") || response.contains("to") || response.contains("too"){
            RatingController.shared.createRating(number: "2", symptom: symptom)
        } else if response.contains("three") || response.contains("tree") || response.contains("free"){
            RatingController.shared.createRating(number: "3", symptom: symptom)
        } else if response.contains("four") || response.contains("for") || response.contains("fore") || response.contains("or"){        RatingController.shared.createRating(number: "4", symptom: symptom)
        } else if response.contains("five") || response.contains("dive"){
            RatingController.shared.createRating(number: "5", symptom: symptom)
        } else if response.contains("six"){
            RatingController.shared.createRating(number: "6", symptom: symptom)
        } else if response.contains("seven"){
            RatingController.shared.createRating(number: "7", symptom: symptom)
        } else if response.contains("eight") || response.contains("ate") {
            RatingController.shared.createRating(number: "8", symptom: symptom)
        } else if response.contains("nine"){
            RatingController.shared.createRating(number: "9", symptom: symptom)
        } else if response.contains("ten"){
            RatingController.shared.createRating(number: "10", symptom: symptom)
        } else if response.contains("zero"){
            RatingController.shared.createRating(number: "0", symptom: symptom)
        } else {
            return
        }
        
        self.index += 1
    }
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        self.timer?.invalidate()
        guard let symptomIndex = symptomIndex else {return}
        guard  index < (symptomIndex) else { performSegue(withIdentifier: "toFoodEntry", sender: nil); return }
        guard let symptom = self.user.symptoms?.object(at: self.index) as? Symptom else {return}
        symptomLabel.text = symptom.detail
        self.requestSpeechAuth()
    }

}
