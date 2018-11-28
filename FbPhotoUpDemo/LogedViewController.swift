
import UIKit
import Firebase

class LogedViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imgFromFb: UIImageView!
    @IBOutlet weak var DLFromFB: UIImageView!
    @IBOutlet weak var StaLabel: UILabel!
    @IBOutlet weak var Pui: UIButton!
    @IBOutlet weak var Uui: UIButton!
    @IBOutlet weak var Dui: UIButton!
    
    
    let filename = "fbprofile1.jpg"
    var imgPicker = UIImagePickerController()
    var imgRef : StorageReference{
        return Storage.storage().reference().child("Images")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Pui.layer.cornerRadius = 0.07 * Pui.bounds.size.width
        Uui.layer.cornerRadius = 0.07 * Uui.bounds.size.width
        Dui.layer.cornerRadius = 0.07 * Dui.bounds.size.width
        StaLabel.layer.cornerRadius = 0.05 * StaLabel.bounds.size.width
        StaLabel.clipsToBounds = true
        
        imgFromFb.layer.borderWidth = 3
        imgFromFb.layer.cornerRadius = imgFromFb.bounds.size.width/2
        imgFromFb.layer.borderColor = UIColor.black.cgColor
        imgFromFb.clipsToBounds = true
        
        DLFromFB.layer.borderWidth = 3
        DLFromFB.layer.cornerRadius = DLFromFB.bounds.size.width/2
        DLFromFB.layer.borderColor = UIColor.black.cgColor
        DLFromFB.clipsToBounds = true
        
        imgPicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //-------------------------------------------------------------------------------
   
    @IBAction func UpAct(_ sender: Any) {

        imgPicker.allowsEditing = false
        imgPicker.sourceType = .photoLibrary
        
        self.present(imgPicker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgFromFb.contentMode = .scaleAspectFit
            imgFromFb.image = pickedImage
            StaLabel.text = "Image Picked"
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        //StaLabel.text = "Image Picked"
    }
    
    //-------------------------------------------------------------------------------
    @IBAction func UploadToFB(_ sender: Any) {
        
        if(imgFromFb != nil){
            StaLabel.text = "Uploading...."
        
            guard let image = imgFromFb.image else{return}
            //guard let imageData = UIImageJPEGRepresentation(image, 1) else { return }
            guard let imageData = image.jpegData(compressionQuality: 1) else {return}

        
            let upRef = imgRef.child(filename)
        
            let uploadTask = upRef.putData(imageData, metadata: nil) { (metadata, error) in
                
                print("UPLOAD TASK FINISHED")
                print(metadata ?? "NO METADATA")
                print(error ?? "NO ERROR",self.StaLabel.text = "Upload Success")
                //self.StaLabel.text = "Upload Success"
            }
        
            uploadTask.observe(.progress) { (snapshot) in
                print(snapshot.progress ?? "NO MORE PROGRESS")
            }
        
            uploadTask.resume()
        }
        else{
            StaLabel.text = "Pick IMG First !!!"
        }
    }
    
    
    @IBAction func DownloadFB(_ sender: Any) {
        StaLabel.text = "Downloading..."
        
        let DLRef = imgRef.child(filename)
        
        
        let DLTask = DLRef.getData(maxSize: 1*2024*1024) { (data, error) in
            if let data = data{
                let image = UIImage(data: data)
                self.DLFromFB.image = image
            }
            print(error ?? "NO ERROR",self.StaLabel.text = "Download Success")
        }
        DLTask.observe(.progress) { (snap) in
            print(snap.progress ?? "NO MORE PROGRESS")
        }
        DLTask.resume()
        
        
    }
    
    

}
