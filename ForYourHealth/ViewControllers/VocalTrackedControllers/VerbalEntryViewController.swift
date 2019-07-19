//
//  VerbalEntryViewController.swift
//  ForYourHealth
//
//  Created by Bobba Kadush on 7/17/19.
//  Copyright © 2019 SRUSSELLH. All rights reserved.
//

import UIKit
import Speech
import AVKit

class VerbalEntryViewController: UIViewController, AVSpeechSynthesizerDelegate, SFSpeechRecognitionTaskDelegate   {

    let user = UserController.shared.user
    
    let speechRecognizer = SFSpeechRecognizer()
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    var timer: Timer?
    var response: String?
    let synth = AVSpeechSynthesizer()
    var utterence = AVSpeechUtterance(string: "")
    var textToRead = ""
    
    @IBOutlet weak var entryTextField: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = lightAccent
        titleLabel.font = titleFont
        titleLabel.text = "Journal Entry"
        titleLabel.textColor = darkShade
        entryTextField.text = ""
        entryTextField.font = titleFont
        entryTextField.textColor = darkShade
        entryTextField.backgroundColor = lightShade
        entryTextField.layer.cornerRadius = textFieldRounder
        cancelButton.setTitle("Exit", for: .normal)
        cancelButton.titleLabel?.font = cancelFont
        cancelButton.setTitleColor(darkAccent, for: .normal)
        requestSpeechAuth()
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.recognitionRequest?.endAudio()
        self.audioEngine.stop()
        self.recognitionRequest = nil
        self.recognitionTask?.finish()
        self.recognitionTask = nil
        audioEngine.inputNode.removeTap(onBus: 0)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        //        performSegue(withIdentifier: "exitToTab", sender: nil)
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.utterence = AVSpeechUtterance(string: "Please discribe your day to me")
                    self.utterence.rate = 0.4
                    self.utterence.volume = 1.0
                    do {
                        try AVAudioSession().setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)
                    }catch{
                        print(error)
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
        self.entryTextField.text = transcription.formattedString
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
    }
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        guard let response = response else {return}
        EntryController.shared.createEntry(body: response, user: user)
        performSegue(withIdentifier: "toFoodEntry", sender: nil)
    }
}
