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
    
    var tiles: [(Int, Int)] = []
    var scnView: SCNView!
    
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
        cameraNode.position = SCNVector3(x: 4.95, y:7.45, z: 16.7)
        scene.rootNode.addChildNode(cameraNode)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
       setUpMatrix(scene: scene)
        
    }
    
    func setUpSquare(scene: SCNScene, width: CGFloat, heigth: CGFloat, color: UIColor, positionX: Double, positionY: Double, squareId: (Int, Int)) {
        var geometry:SCNGeometry
        geometry = SCNBox(width: width , height: heigth, length: 0.1, chamferRadius: 1.0)
        let square = SCNNode(geometry: geometry)
        geometry.firstMaterial?.diffuse.contents = color
        scene.rootNode.addChildNode(square)
        square.position.x = Float(positionX)
        square.position.y = Float(positionY)
        let squareId = squareId
        self.tiles.append(squareId)
    }
    
    func setUpMatrix(scene: SCNScene) {
        for j in 0...20 {
            for i in 0...25 {
                setUpSquare(scene: scene, width: (self.view.frame.size.width / 420), heigth:(self.view.frame.size.width / 420), color: .black, positionX: Double(j) * 1.1, positionY: Double(i) * 1.1, squareId: (i,j) )
            }
            
        }
    }
    
    @objc func touchTap(_ gestureRecognize: UIGestureRecognizer) {
        let touched = gestureRecognize.location(in:scnView )
        let hitResults = scnView.hitTest(touched, options: [:])
        if hitResults.count > 0 {
            let result = hitResults[0]
            result.node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            print(result.node)
        }
    }
}

