//
//  DatePickerPopupViewController.swift
//  House
//
//  Created by Shmeel Ahmad on 20/06/2023.
//  Copyright (c) 2023 All rights reserved.
//

import UIKit

public class DatePickerPopupViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var panDismissView: UIView!
    var didPickDate:(Date)->Void = {_ in}
    fileprivate var date = Date(){
        didSet{
            if isViewLoaded {
                datePicker.date = date
            }
        }
    }
    
    fileprivate var maxDate:Date? = nil{
        didSet{
            if isViewLoaded,let mxDate = maxDate {
                datePicker.maximumDate = mxDate
            }
        }
    }
    
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var tickBtn: UIButton!
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 16
            mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    private var dismissViewTranslation = CGPoint(x: 0, y: 0)

    // MARK: -- View LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        panDismissView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        panDismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        setupUI()
    }
    
    
    
    @IBAction func crossBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func tickBtnTapped(_ sender: Any) {
        didPickDate(self.datePicker.date)
        self.dismiss(animated: true)
    }
    
    
    func setupUI() {
        var img = UIImage.init(named: "grayCross", in: Bundle.module, compatibleWith: nil)
        crossBtn.setImage(img, for: .normal)
        img = UIImage.init(named: "chekboxChecked", in: Bundle.module, compatibleWith: nil)
        tickBtn.setImage(img, for: .normal)
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.datePickerMode = .date
        }
        if let mxDate = maxDate {
            datePicker.maximumDate = mxDate
        }
        datePicker.date = date
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

extension UIViewController {
    public func presentDatePicker(selectedDate:Date = Date(), maxDate:Date? = nil, didPickDate:@escaping (Date)->Void) {
        let vc = UIStoryboard(name: "DatePickerPopup", bundle: Bundle.module).instantiateViewController(withIdentifier: "DatePickerPopupViewController") as! DatePickerPopupViewController
        vc.didPickDate=didPickDate
        vc.date = selectedDate
        vc.maxDate = maxDate
        vc.modalPresentationStyle = .overFullScreen
        vc.modalPresentationCapturesStatusBarAppearance = true
        present(vc)
    }
}
