//
//  ViewController.swift
//  Accelerometer_example1
//
//  Created by SoichiFurukawa on 2017/03/08.
//  Copyright © 2017年 soufuru. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet var labelX: UILabel!
    @IBOutlet var labelY: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    let motionManager = CMMotionManager()
    
    var timer: Timer!
    var gameTime: Float = 10.0
    var accelerationX: Double!
    var accelerationY: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        
        if motionManager.isAccelerometerAvailable {
            // 加速度センサーの値取得間隔
            motionManager.accelerometerUpdateInterval = 0.1

            // motionの取得を開始
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (data, error) in
                
                self.accelerationX = (data?.acceleration.x)!
                self.accelerationY = (data?.acceleration.y)!
                
                self.labelX.text = String( format:"%.3f", self.accelerationX)
                self.labelY.text = String( format:"%.3f", self.accelerationY)
            })
        }
    }
    
    // 0.1秒ごとに呼び出す処理(タイマーの処理と加速度の取得頻度)を別々に行ってるのがイケてない...
    func up() {
        gameTime -= 0.1
        timeLabel.text = String(format: "%.1f",gameTime)
        
        if gameTime <= 7 {
            labelX.alpha -= 0.05
            labelY.alpha -= 0.05
         }
        
        if gameTime <= 0 {
            //タイマーストップ
            timer.invalidate()
            
            //画面遷移 タイムアップ時の傾きの情報をresultVCに送る
            let resultViewController: ResultViewController = self.storyboard?.instantiateViewController(withIdentifier: "resultVC") as! ResultViewController
            resultViewController.accelerationX = accelerationX
            resultViewController.accelerationY = accelerationY
            self.present(resultViewController, animated: true, completion: nil)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
