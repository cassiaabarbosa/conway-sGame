//
//  BronzeGVC.swift
//  conway`sGame
//
//  Created by Cassia Aparecida Barbosa on 31/10/19.
//  Copyright © 2019 teamconwaysGame. All rights reserved.
//

import Foundation
import SceneKit
import UIKit
import QuartzCore

class BronzeGVC: UIViewController {
    
    var scnView: SCNView!
    var dead: [(Int, Int)] = []
    var alive: [(Int, Int)] = []
    var timer = Timer()
    
    public var auxMatrix: [[Bool]] = Array(repeating: Array(repeating: false, count: 11 ), count: 11)
    public var nodesMatrix: [[SCNNode]] = []
    public var touchedNodes: [SCNNode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        scnView = SCNView(frame: self.view.frame)
        self.view = scnView
        scnView.scene = scene
        scnView.backgroundColor = .white
        
        
        var cameraNode: SCNNode!
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 6, y:-2, z: 25)
        scene.rootNode.addChildNode(cameraNode)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        let startButton = UIButton()
        startButton.frame = CGRect(x: self.view.frame.size.width * 0.2, y: 100, width: 50, height: 50)
        startButton.backgroundColor = .black
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        startButton.layer.cornerRadius = 10
        self.view.addSubview(startButton)
        
        let stopButton = UIButton()
        stopButton.frame = CGRect(x: self.view.frame.size.width * 0.7, y: 100, width: 50, height: 50)
        stopButton.backgroundColor = .black
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(.white, for: .normal)
        stopButton.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        stopButton.layer.cornerRadius = 10
        self.view.addSubview(stopButton)
        
        
        setUpMatrix(scene: scene)
        
    }
    
    
    func setUpSquare(scene: SCNScene, width: CGFloat, heigth: CGFloat, color: UIColor, positionX: Double, positionY: Double) -> SCNNode{
        var geometry:SCNGeometry
        geometry = SCNBox(width: width , height: heigth, length: 0.0, chamferRadius: 1.0)
        let square = SCNNode(geometry: geometry)
        geometry.firstMaterial?.diffuse.contents = color
        scene.rootNode.addChildNode(square)
        square.position.x = Float(positionX)
        square.position.y = Float(positionY)
        return square
    }
    
    func setUpMatrix(scene: SCNScene) {
        //j é número de linhas
        for j in 0...10 {
            var row:[SCNNode] = []
            for i in 0...10 {
                //i é o número de colunas
                let node = setUpSquare(scene: scene, width: (self.view.frame.size.width / 420), heigth:(self.view.frame.size.width / 420), color: .black, positionX: Double(i) * 1.2, positionY: Double(-j) * 1.2)
                row.append(node)
            }
            nodesMatrix.append(row)
        }
        
    }
    
    func countNeighbours(row: Int, col: Int) -> Int {
        var count: Int = 0
        let maxRow = auxMatrix.count - 1
        if (maxRow > 0){
            let maxCol = auxMatrix[0].count - 1
            let x = max(0, row-1)
            let y = max(0, col-1)
            
            for x in x...min(row + 1, maxRow) {
                for y in y...min(col + 1 , maxCol){
                    if(x != row || y != col) {
                        if (auxMatrix[x][y]) {
                            count+=1
                        }
                        
                    }
                }
            }
        }
        return count
        
    }
    
    func decideTileLife(col: Int, row: Int) {
        let tile = auxMatrix[row][col]
        let count = countNeighbours(row: row, col: col)
        if tile{
            if(count < 2 ){
                dead.append((row,col))
            }
            else if(count >= 2 && count <= 3) {
                alive.append((row,col))
            }
            else {
                dead.append((row,col))
            }
        }
            
        else{
            if (count == 3){
                alive.append((row,col))
            }
            else{
                dead.append((row,col))
            }
        }
    }
    
    @objc func start() {
        cleanArrays()
        for j in 0...10{
            for i in 0...10{
                decideTileLife(col: i, row: j)
            }
        }
        newGrid()
        
    }
    
    
    func newGrid() {
        for i in alive {
            auxMatrix[i.0][i.1]=true
            nodesMatrix[i.0][i.1].geometry?.firstMaterial?.diffuse.contents = UIColor.red
        }
        
        for j in dead {
            auxMatrix[j.0][j.1]=false
            nodesMatrix[j.0][j.1].geometry?.firstMaterial?.diffuse.contents = UIColor.black
        }
    }
    
    func cleanArrays() {
        dead.removeAll(keepingCapacity: false)
        alive.removeAll(keepingCapacity: false)
    }
    
    
    @objc func touchTap(_ gestureRecognize: UIGestureRecognizer) {
        let touched = gestureRecognize.location(in:scnView )
        let hitResults = scnView.hitTest(touched, options: [:])
        if hitResults.count > 0 {
            let result = hitResults[0]
            for j in 0..<11{
                for i in 0..<11{
                    if nodesMatrix[i][j] == result.node {
                        auxMatrix[i][j]=true
                        result.node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                    }
                }
            }
        }
    }
    
    
    @objc func startButtonAction(sender: UIButton){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.start), userInfo: nil, repeats: true)
    }
    
    
    @objc func stopButtonAction(sender: UIButton){
        cleanArrays()
        for j in 0..<11{
            for i in 0..<11{
                auxMatrix[i][j] = false
                dead.append((i,j))
            }
        }
        newGrid()
        timer.invalidate()
    }
}
    

