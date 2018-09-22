import UIKit

class XXRootViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var floodUrl: URL?
    var controller: TrollController?
    var logArea: UITextView?

    func trollLog(_ message: String) {
        logArea?.text = (logArea?.text ?? "") + message + "\n"
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        // start creating the buttons
        let librarybutton = UIButton(type: .roundedRect)
        librarybutton.addTarget(self, action: #selector(XXRootViewController.choose(fromLibrary:)), for: .touchUpInside)
        librarybutton.setTitle("Choose from library", for: .normal)
        librarybutton.frame = CGRect(x: 20, y: 80, width: view.frame.size.width - 40, height: 40)
        view.addSubview(librarybutton)

        let urlbutton = UIButton(type: .roundedRect)
        urlbutton.addTarget(self, action: #selector(XXRootViewController.choose(fromURL:)), for: .touchUpInside)
        urlbutton.setTitle("Choose from URL", for: .normal)
        urlbutton.frame = CGRect(x: 20, y: 120, width: view.frame.size.width - 40, height: 40)
        view.addSubview(urlbutton)

        let floodbutton = UIButton(type: .roundedRect)
        floodbutton.addTarget(self, action: #selector(XXRootViewController.startFlooding(_:)), for: .touchUpInside)
        floodbutton.setTitle("Start flooding", for: .normal)
        floodbutton.frame = CGRect(x: 20, y: 160, width: view.frame.size.width - 40, height: 40)
        view.addSubview(floodbutton)

        let stopfloodbutton = UIButton(type: .roundedRect)
        stopfloodbutton.addTarget(self, action: #selector(XXRootViewController.stopFlooding(_:)), for: .touchUpInside)
        stopfloodbutton.setTitle("Stop flooding", for: .normal)
        stopfloodbutton.frame = CGRect(x: 20, y: 200, width: view.frame.size.width - 40, height: 40)
        view.addSubview(stopfloodbutton)

        logArea = UITextView(frame: CGRect(x: 20, y: 240, width: view.frame.size.width - 40, height: 200))
        logArea!.isEditable = false
        logArea!.text = "-trolldropapp log-\nremember to turn on wifi and bluetooth before trolldropping\n"
        logArea!.layer.borderWidth = 1
        logArea!.layer.borderColor = UIColor.gray.cgColor
        logArea!.layer.cornerRadius = 10
        view.addSubview(logArea!)
    }

    @objc func choose(fromLibrary sender: Any?) {
        // This code presents a prompt for an image from the phone's library
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    // this is the method called when the picker finishes
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        picker.dismiss(animated: true)

        let directory = NSTemporaryDirectory()
        let fileName = "image.png"
        floodUrl = URL(fileURLWithPath: fileName, relativeTo: URL(fileURLWithPath: directory))
        floodUrl = URL(string: floodUrl!.absoluteString)
        trollLog("image saved to " + floodUrl!.absoluteString)

        try! UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage)!.write(to: floodUrl!)
    }

    @objc func choose(fromURL sender: Any?) {
        // create an alert controller to handle getting the url
        let alertController = UIAlertController(title: "TrollDrop", message: "Choose URL", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { textField in
            // configure the text input field we just added
            textField.placeholder = "Name"
            textField.textColor = UIColor.black
            textField.clearButtonMode = .whileEditing
            textField.borderStyle = .roundedRect
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
        }))
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
            let textfields = alertController.textFields
            guard let urlstr = textfields![0].text else {return}
            self.floodUrl = URL(string: urlstr)
            self.trollLog("url set to " + self.floodUrl!.absoluteString)
        }))
        // show the alert
        present(alertController, animated: true)
    }

    @objc func startFlooding(_ sender: Any?) {
        // here you should put your code for trolldrop
        guard floodUrl != nil else {
            trollLog("no url selected");
            return
        }
        trollLog("started flooding")
        controller = TrollController(sharedURL: floodUrl!, rechargeDuration: 0, logger: {message in
            self.trollLog(message)
        });
        controller!.start();
    }

    @objc func stopFlooding(_ sender: Any?) {
        trollLog("stopped flooding")
        controller?.stop();
    }

}