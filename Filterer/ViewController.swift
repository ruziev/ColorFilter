//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var compareButton: UIButton!
    
    var filteredShown = false
    
    @IBOutlet var editMenu: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var overlayingImageView: UIImageView!
    
    @IBOutlet var hintView: UIView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var filterButton: UIButton!
    
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var purple: UIButton!
    
    var currentFilterFunction: (UIImage,Double)->UIImage = Filters.makeRed
    
    func initFilterButtons() {
        red.titleLabel?.text = nil
        red.setImage(Filters.makeRed(imageView.image!), forState: .Normal)
        
        green.titleLabel?.text = nil
        green.setImage(Filters.makeGreen(imageView.image!), forState: .Normal)
        
        blue.titleLabel?.text = nil
        blue.setImage(Filters.makeBlue(imageView.image!), forState: .Normal)
        
        yellow.titleLabel?.text = nil
        yellow.setImage(Filters.makeYellow(imageView.image!), forState: .Normal)
        
        purple.titleLabel?.text = nil
        purple.setImage(Filters.makePurple(imageView.image!), forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compareButton.enabled = false
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        let tapGestureRecognizerForOriginalImage = UILongPressGestureRecognizer(target:self, action:#selector(ViewController.toggleImage(_:)))
        let tapGestureRecognizerForFilteredImage = UILongPressGestureRecognizer(target:self, action:#selector(ViewController.toggleImage(_:)))
        imageView.addGestureRecognizer(tapGestureRecognizerForOriginalImage)
        overlayingImageView.addGestureRecognizer(tapGestureRecognizerForFilteredImage)
        hintView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        hintView.translatesAutoresizingMaskIntoConstraints = false
        
        editMenu.translatesAutoresizingMaskIntoConstraints = false
        editMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        editButton.enabled = false
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            hideFilteredImage()
            hideHintView()
            compareButton.enabled = false
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
            
            if editButton.selected {
                hideEditMenu()
                editButton.selected = false
            }
            editButton.enabled = false
        } else {
            initFilterButtons()
            showSecondaryMenu()
            initFilterButtons()
            sender.selected = true
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    func showHintView() {
        view.addSubview(hintView)
        
        let topConstraint = hintView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 24)
        let centerXConstraint = hintView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        let heightConstraint = hintView.heightAnchor.constraintEqualToConstant(22)
        let widthConstraint = hintView.widthAnchor.constraintEqualToConstant(100)
        
        NSLayoutConstraint.activateConstraints([topConstraint, centerXConstraint, heightConstraint, widthConstraint])
        
        view.layoutIfNeeded()
        
        self.hintView.alpha = 0
        UIView.animateWithDuration(0.4, animations: {
            self.hintView.alpha = 1.0
        })

    }
    
    func hideHintView() {
        UIView.animateWithDuration(0.4, animations: {
            self.hintView.alpha = 0
        }) { completed in
            if completed == true {
                self.hintView.removeFromSuperview()
            }
        }
    }
    
    func showFilteredImage() {
        overlayingImageView.alpha = 0
        UIView.animateWithDuration(0.4, animations: {
            self.overlayingImageView.alpha = 1.0
        }) {completed in
            if completed {
                self.filteredShown = true
            }
        }
    }
    
    func hideFilteredImage() {
        UIView.animateWithDuration(0.4, animations: {
            self.overlayingImageView.alpha = 0
        }) {completed in
            if completed {
                self.filteredShown = false
            }
        }
        
    }

    @IBAction func onChooseFilter(sender: UIButton) {
        let oldImage = imageView.image!
        var newImage = oldImage
        switch sender {
        case red:
            newImage = Filters.makeRed(oldImage)
            currentFilterFunction = Filters.makeRed
        case green:
            newImage = Filters.makeGreen(oldImage)
            currentFilterFunction = Filters.makeGreen
        case blue:
            newImage = Filters.makeBlue(oldImage)
            currentFilterFunction = Filters.makeBlue
        case yellow:
            newImage = Filters.makeYellow(oldImage)
            currentFilterFunction = Filters.makeYellow
        case purple:
            newImage = Filters.makePurple(oldImage)
            currentFilterFunction = Filters.makePurple
        default: break
        }
        overlayingImageView.image = newImage
        compareButton.enabled = true
        showFilteredImage()
        hideHintView()
        
        editButton.enabled = true
    }
    
    func changeImage() {
        if !filteredShown {
            showFilteredImage()
            hideHintView()
        } else {
            hideFilteredImage()
            showHintView()
        }
    }
    
    @IBAction func onCompare(sender: UIButton) {
        changeImage()
        sender.selected = !sender.selected
    }
    
    @IBAction func toggleImage(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began || sender.state == .Ended {
            changeImage()
        }
    }
    
    func showEditMenu() {
        view.addSubview(editMenu)
        
        let bottomConstraint = editMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = editMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = editMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstaint = editMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([leftConstraint, rightConstraint, bottomConstraint, heightConstaint])
        
        view.layoutIfNeeded()
        
        self.editMenu.alpha = 0
        UIView.animateWithDuration(0.4, animations: {
            self.editMenu.alpha = 1.0
        })
    }
    
    func hideEditMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.editMenu.alpha = 0
        }) { completed in
            if completed == true {
                self.editMenu.removeFromSuperview()
            }
        }
    }
    
    @IBAction func onEditButton(sender: UIButton) {
        if !sender.selected {
            hideSecondaryMenu()
            showEditMenu()
        } else {
            hideEditMenu()
            showSecondaryMenu()
        }
        sender.selected = !sender.selected
    }
    
    @IBAction func intensityChanged(sender: UISlider) {
        overlayingImageView.image = currentFilterFunction(imageView.image!, Double(sender.value))
    }
}

