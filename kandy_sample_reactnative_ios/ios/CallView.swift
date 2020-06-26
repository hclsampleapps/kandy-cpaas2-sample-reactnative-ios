// CounterView.swift
import UIKit
class CallView: UIView {
  
  var localView: UIView!
  var remoteView: UIView!
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .green
    
    localView = UIView()
    localView.backgroundColor = UIColor.red
    localView.frame =  CGRect(x:0, y: 0, width:self.frame.width / 2, height: self.frame.height)
    self.addSubview(localView)
    
    remoteView = UIView()
    remoteView.backgroundColor = UIColor.blue
    remoteView.frame =  CGRect(x:self.frame.width / 2, y: 0, width:self.frame.width / 2, height:self.frame.height)
    self.addSubview(remoteView)
    
    self.bringSubviewToFront(localView)
    self.bringSubviewToFront(remoteView)

  }
  
  required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
  }
  
}
