//
//  PaymentRingView.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 4/4/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class PaymentRingView: UIView {
    
   // lazy var container = UIView()
    
    lazy var midViewX = self.frame.midX
    lazy var midViewY = self.frame.midY
    
    var mainPath = UIBezierPath()
    let mainLayer = CAShapeLayer()
    
    var ballPath = UIBezierPath()
    var ballLayer = CAShapeLayer()
    
    var trackLayer = CAShapeLayer()
    var trackPath = UIBezierPath()
    
    var trackOutlineLayer = CAShapeLayer()
    var trackOutlinePath = UIBezierPath()
    
    var topBallLayer = CAShapeLayer()
    var topBallPath = UIBezierPath()
    
    let trackLineWidth : CGFloat = 30
    let dotPositions : [CGFloat] = [40, 155, 250, 360]
    let dotColors = [ #colorLiteral(red: 0.8067814708, green: 0.3228612542, blue: 0.3160231709, alpha: 1), #colorLiteral(red: 0.9953522086, green: 0.8220682144, blue: 0.2999364734, alpha: 1), #colorLiteral(red: 0.5126650929, green: 0.8883596063, blue: 0.4466395974, alpha: 1)]
    
    var tRadius : CGFloat!
    var bRadius : CGFloat!
    
    let label = UILabel()
    
    fileprivate func rad2deg(_ number: CGFloat) -> CGFloat {
        return number * 180 / .pi
    }
    
    fileprivate func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    fileprivate func setupLayer(layer: CAShapeLayer, path: UIBezierPath, fillColor: UIColor, strokeColor: UIColor, lineWidth : CGFloat){
        layer.path = path.cgPath
        layer.fillColor = fillColor.cgColor
        layer.strokeColor =  strokeColor.cgColor
        layer.lineWidth = lineWidth
        layer.lineCap = .round
        self.layer.addSublayer(layer)
    }
    
    fileprivate func addGrayDots(ballXOffset: CGFloat, ballYOffset:CGFloat) {
        for i in 0..<dotPositions.count{
            let ballStartPosition = dotPositions[i] //degrees
            let ballPositionAfterCalculate = deg2rad(ballStartPosition) - deg2rad(90)
            let ballX = midViewX + cos(ballPositionAfterCalculate) * tRadius
            let ballY = midViewY + sin(ballPositionAfterCalculate) * tRadius
            let dotWidth: CGFloat = 15
            
            let dot = UIView()
            dot.backgroundColor = .gray
            dot.layer.cornerRadius = dotWidth / 2
            dot.layer.masksToBounds = true
            dot.frame = CGRect(x: ballX - ballXOffset, y: ballY - ballYOffset, width: dotWidth, height: dotWidth)
            dot.tag = Int(dotPositions[i])
            self.addSubview(dot)
            if i == 0{
                dot.isHidden = true
            }
        }
    }
    
    fileprivate func setupLayers() {
        setupLayer(layer: trackOutlineLayer, path: trackPath, fillColor: .clear, strokeColor: .white, lineWidth: trackLineWidth + 3)
        setupLayer(layer: trackLayer, path: trackPath, fillColor: .clear, strokeColor: #colorLiteral(red: 0.8067814708, green: 0.3228612542, blue: 0.3160231709, alpha: 1), lineWidth: trackLineWidth)
        setupLayer(layer: mainLayer, path: mainPath, fillColor: .clear, strokeColor: UIColor.lightGray, lineWidth: trackLineWidth)
        setupLayer(layer: ballLayer, path: ballPath, fillColor: #colorLiteral(red: 0.8067814708, green: 0.3228612542, blue: 0.3160231709, alpha: 1), strokeColor: .white, lineWidth: 3)
    }
    
    fileprivate func setupPaths() {
        let ballStartPosition: CGFloat = dotPositions[0] //degrees
        let ballPositionAfterCalculate: CGFloat = deg2rad(ballStartPosition) - deg2rad(90)
        let ballX = midViewX + cos(ballPositionAfterCalculate) * tRadius
        let ballY = midViewY + sin(ballPositionAfterCalculate) * tRadius
        let trackStartAngleInDegrees: CGFloat = 360
        let trackEndAngleInDegrees: CGFloat = 0
        let mainStartAngleInDegrees: CGFloat = 0
        let mainEndAngleInDegrees: CGFloat = dotPositions[0]
        
        trackPath = UIBezierPath(arcCenter: CGPoint(x: midViewX,y: midViewY), radius: tRadius, startAngle: deg2rad(trackStartAngleInDegrees) - deg2rad(90), endAngle: deg2rad(trackEndAngleInDegrees) - deg2rad(90), clockwise: false)
        
        
        mainPath = UIBezierPath(arcCenter: CGPoint(x: midViewX,y: midViewY), radius: tRadius, startAngle: deg2rad(mainStartAngleInDegrees) - deg2rad(90), endAngle: deg2rad(mainEndAngleInDegrees) - deg2rad(90), clockwise: false)
       
        
        ballPath = UIBezierPath(arcCenter: CGPoint(x: ballX,y: ballY), radius: bRadius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
    }
    
    init(frame: CGRect, trackRadius: CGFloat, ballRadius: CGFloat, ballXOffset: CGFloat, ballYOffset : CGFloat) {
        super.init(frame: frame)
        let dragBall = UIPanGestureRecognizer(target: self, action:#selector(dragBall(recognizer:)))
        tRadius = trackRadius
        bRadius = ballRadius
        setupPaths()
        setupLayers()
        addGrayDots(ballXOffset: ballXOffset, ballYOffset: ballYOffset)
        self.addGestureRecognizer(dragBall)
        
        //        let percent = ((dotPositions[0]/360) * 100)
        //        label.sizeToFit()
        //        label.frame = view.frame
        //        label.textAlignment = .center
        //        label.textColor = .white
        //        label.text = "\(Int(percent))%"
        //        label.font = UIFont.systemFont(ofSize: 30)
        //        view.addSubview(label)
        
        
        let test = CircularLabel()
        test.frame = self.frame
        test.text = "Im hoping that this works for me"
        test.clockwise = false
        test.angle = -1.5
        test.radius = 77
        self.addSubview(test)
        
        //addSubview(container)
        //container.anchorCenterSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updatePathsNearDot(_ degrees: inout CGFloat, dotPosition : CGFloat) {
        let ballStartPosition: CGFloat = dotPosition //degrees
        let ballPositionAfterCalculate: CGFloat = deg2rad(ballStartPosition) - deg2rad(90)
        let ballX = midViewX + cos(ballPositionAfterCalculate) * tRadius
        let ballY = midViewY + sin(ballPositionAfterCalculate) * tRadius
        degrees = dotPosition
        
        ballPath = UIBezierPath(arcCenter: CGPoint(x: ballX,y: ballY), radius: bRadius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        ballLayer.path = ballPath.cgPath
        mainPath = UIBezierPath(arcCenter: CGPoint(x: midViewX,y: midViewY), radius: tRadius, startAngle: CGFloat(Double.pi * 1.5), endAngle:CGFloat(deg2rad(degrees) - deg2rad(90)), clockwise: false)
        mainLayer.path = mainPath.cgPath
    }
    
    fileprivate func updatePathsAwayFromDots(_ ballX2: CGFloat, _ ballY2: CGFloat, _ angle: CGFloat) {
        ballPath = UIBezierPath(arcCenter: CGPoint(x: ballX2,y: ballY2), radius: bRadius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        ballLayer.path = ballPath.cgPath
        mainPath = UIBezierPath(arcCenter: CGPoint(x: midViewX,y: midViewY), radius: tRadius, startAngle: CGFloat(Double.pi * 1.5), endAngle:CGFloat(angle + .pi * 2 ), clockwise: false)
        mainLayer.path = mainPath.cgPath
    }
    
    fileprivate func updateColors(color: UIColor) {
        trackLayer.strokeColor = color.cgColor
        ballLayer.fillColor = color.cgColor
    }
    
    fileprivate func inRangeOfDot(_ degrees: inout CGFloat, dotPositionNum : Int, color: UIColor) {
        updateColors(color: color)
        updatePathsNearDot(&degrees, dotPosition: dotPositions[dotPositionNum])
        self.subviews.forEach({if($0.tag == Int(dotPositions[dotPositionNum])){$0.isHidden = true}})
    }
    
    @objc func dragBall(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.location(in: self)
        let ballX = CGFloat(point.x)
        let ballY = CGFloat(point.y)
        let midViewXDouble = CGFloat(midViewX)
        let midViewYDouble = CGFloat(midViewY)
        let angleX = (ballX - midViewXDouble)
        let angleY = (ballY - midViewYDouble)
        let angle = atan2(angleY, angleX)
        var degrees = rad2deg(angle)
        let ballX2 = midViewXDouble + cos(angle) * tRadius
        let ballY2 = midViewYDouble + sin(angle) * tRadius
        let range: CGFloat = 15
        
        degrees = degrees + 90
        if degrees < 0 {
            degrees = degrees + 360
        }
        let percent = ((degrees/360) * 100)
        //label.text = "\(Int(percent))%"
        
        if case (dotPositions[0] - range)...(dotPositions[0] + range) = degrees{
            inRangeOfDot(&degrees, dotPositionNum: 0, color: dotColors[0])
        } else if case (dotPositions[1] - range)...(dotPositions[1] + range) = degrees{
            inRangeOfDot(&degrees, dotPositionNum: 1, color: dotColors[1])
        } else if case (dotPositions[2] - range)...(dotPositions[2] + range) = degrees{
            inRangeOfDot(&degrees, dotPositionNum: 2, color: dotColors[2])
        }  else {
            updatePathsAwayFromDots(ballX2, ballY2, angle)
            self.subviews.forEach({$0.isHidden = false})
            if case 0...dotPositions[1] = degrees{
                updateColors(color: dotColors[0])
            } else if case dotPositions[1]...dotPositions[2] = degrees{
                updateColors(color: dotColors[1])
            } else if case dotPositions[2]...360 = degrees{
                updateColors(color: dotColors[2])
            }
            if degrees < range || degrees > 360 - range{
                self.subviews.forEach({if($0.tag == 360){$0.isHidden = true}})
            }
            
        }
        
    }
        
        
}

