//
//  StringPickerPopupViewController.swift
//  House
//
//  Created by Shmeel Ahmad on 20/06/2023.
//  Copyright (c) 2023 All rights reserved.
//

import UIKit

public class StringPickerPopupViewController: UIViewController {
    
    @IBOutlet weak var panDismissView: UIView!
    
    var options:[String]=[]{
        didSet{
            if isViewLoaded{
                setTableViewHeight()
            }
        }
    }
    
    var calculatingCell:PickerOptionTableViewCell!
    var didPickOption:(Int)->Void = {_ in}
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 16
            mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    private var dismissViewTranslation = CGPoint(x: 0, y: 0)

    // MARK: -- View LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        calculatingCell = tableView.dequeueReusableCell(withIdentifier: "PickerOptionTableViewCell") as? PickerOptionTableViewCell
        panDismissView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        panDismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        setupUI()
    }
    
    
    
    @IBAction func crossBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        setTableViewHeight()
        let img = UIImage.init(named: "grayCross", in: Bundle.module, compatibleWith: nil)
        crossBtn.setImage(img, for: .normal)
    }
    
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            dismissViewTranslation = sender.translation(in: view)
            if dismissViewTranslation.y > 0 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: self.dismissViewTranslation.y)
                })
            }
        case .ended:
            if dismissViewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            }
            else {
                dismiss(animated: true) {
                    
                }
            }
        default:
            break
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        dismiss(animated: true) {
            
        }
    }
}
extension StringPickerPopupViewController:UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true){
            self.didPickOption(indexPath.row)            
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerOptionTableViewCell") as! PickerOptionTableViewCell
        cell.titleLbl.text = options[indexPath.row]
        return cell
    }
    
    
    func setTableViewHeight(){
        UIView.animate(withDuration: 0, animations: {
            self.tableView.layoutIfNeeded()
            }) { (complete) in
                var totalHeight: CGFloat = 0
                for d in self.options {
                    self.calculatingCell.titleLbl.text = d
                    self.calculatingCell.setNeedsLayout()
                    self.calculatingCell.layoutIfNeeded()
                    let targetSize = CGSize(width: self.tableView.frame.width, height: UIView.layoutFittingCompressedSize.height)
                    let size = self.calculatingCell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
                    totalHeight += size.height
                }
                
                self.tableViewHeight.constant = min(totalHeight,self.view.frame.size.height*0.7)
        }
    }
}
extension UIViewController {
    public func present(options:[String], didPickOption:@escaping (Int)->Void) {
        let vc = UIStoryboard(name: "StringPickerPopup", bundle: Bundle.module).instantiateViewController(withIdentifier: "StringPickerPopupViewController") as! StringPickerPopupViewController
        vc.options=options
        vc.didPickOption=didPickOption
        vc.modalPresentationStyle = .overFullScreen
        vc.modalPresentationCapturesStatusBarAppearance = true
        present(vc)
    }
}
