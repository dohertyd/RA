//
//  SelectDateViewController.swift
//  Ryanair
//
//  Created by Derek Doherty on 31/05/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import UIKit

// MARK: - Delegate Protocol
public protocol SelectDateViewControllerDelegate: class {
    func selectDateViewController(_ viewController: SelectDateViewController, didSelectDate date: Date)
}

public class SelectDateViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectButton: UIButton!
    
    public weak var delegate: SelectDateViewControllerDelegate?
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        delegate?.selectDateViewController(self, didSelectDate: datePicker.date)
        dismiss(animated: true)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
