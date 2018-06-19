//  ViewController.swift
//
//  Created by patrick piemonte on 11/26/14.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-present patrick piemonte (http://patrickpiemonte.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

let videoUrl = URL(string: "https://aweme.snssdk.com/aweme/v1/playwm/?video_id=38017f524e63410993edcb2709da08a2&line=0")!

//"/Users/admin/Library/Developer/CoreSimulator/Devices/6868386D-B860-4AAB-8F7D-4DE5F81F8ECA/data/Containers/Data/Application/7FABFB3D-9D9F-4034-B3F3-6F55D237DDA3/tmp/video_id=38017f524e63410993edcb2709da08a2&line=0.mp4"

class ViewController: UIViewController {

    fileprivate var player = Player()
    
    // MARK: object lifecycle
    deinit {
        self.player.willMove(toParentViewController: self)
        self.player.view.removeFromSuperview()
        self.player.removeFromParentViewController()
    }

    // MARK: view lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.player.playerDelegate = self
        self.player.playbackDelegate = self
        self.player.view.frame = self.view.bounds
        
        self.addChildViewController(self.player)
        self.view.addSubview(self.player.view)
        self.player.didMove(toParentViewController: self)
        
        let url = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
            .appendingPathComponent("video_id=38017f524e63410993edcb2709da08a2&line=0")
            .appendingPathExtension("mp4")
        print(url)
        self.player.url = videoUrl
        
        self.player.playbackLoops = true
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.player.playFromBeginning()
    }
}

// MARK: - UIGestureRecognizer

extension ViewController {
    
    @objc func handleTapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
            case PlaybackState.stopped.rawValue:
                self.player.playFromBeginning()
                break
            case PlaybackState.paused.rawValue:
                self.player.playFromCurrentTime()
                break
            case PlaybackState.playing.rawValue:
                self.player.pause()
                break
            case PlaybackState.failed.rawValue:
                self.player.pause()
                break
            default:
                self.player.pause()
                break
        }
    }
    
}

// MARK: - PlayerDelegate

extension ViewController:PlayerDelegate {
    
    func playerReady(_ player: Player) {
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
    }
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
}

// MARK: - PlayerPlaybackDelegate

extension ViewController:PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
    }
    
}

