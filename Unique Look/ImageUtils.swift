//
//  ImageUtils.swift
//  Unique Look
//

import UIKit
import Toucan

class ImageCache {
    
    struct Static {
        static let instance = ImageCache()
    }
    
    //Mark: - Path utils
    func imageWithIdentifier(identifier: String?) -> UIImage? {
        
        if identifier == nil || identifier! == "" {
            return nil
        }
        
        let path = pathForIdentifier(identifier!)
        
        
        if let data = NSData(contentsOfFile: path) {
            return UIImage(data: data)
            
        }
        
        return nil
    }
    
    
    func getThumbWithIdentifier(identifier: String?) -> UIImage? {
        
        // If the identifier is nil, or empty, return nil
        if identifier == nil || identifier! == "" {
            return nil
        }
        
        let path = self.pathForIdentifier(identifier!,dir: "thumb")
        
        // Next Try the hard drive
        if let data = NSData(contentsOfFile: path) {
            return UIImage(data: data)
            
        }else{
            return nil
        }
        
        
    }
    
    func pathForIdentifier(identifier: String) -> String {
        let documentsDirectoryURL: NSURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as NSURL!)!
        let fullURL = documentsDirectoryURL.URLByAppendingPathComponent(identifier)
        
        return fullURL.path!
    }
    
    func pathForIdentifier(identifier: String, dir:String) -> String {
        
        
        let documentsDirectoryURL: NSURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as NSURL!)!
        var fullURL = documentsDirectoryURL.URLByAppendingPathComponent(dir,isDirectory: true)
        
        do {
            try NSFileManager.defaultManager().createDirectoryAtURL(fullURL, withIntermediateDirectories: true, attributes: nil)
        }catch{
        }
        
        fullURL=fullURL.URLByAppendingPathComponent(identifier)
        
        
        return fullURL.path!
    }
    
    //Mark: - Download, Store and remove Images
    func downloadImage(imageUrl: String, didComplete: (imageData: NSData?, error: NSError?) ->  Void) -> NSURLSessionDataTask {
        
        let url = NSURL(string: imageUrl)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let error = downloadError {
                    didComplete(imageData: nil, error: error)
                } else {
                    didComplete(imageData: data, error: nil)
                }
            }
        }
        
        task.resume()
        return task
    }
    
    func storeThumbImage(image: UIImage?,width:Int, height:Int, path: String!) -> NSData {
        
        let p = self.pathForIdentifier(path!,dir: "thumb")
        
        let img=Toucan(image: image!).resize(CGSize(width: width, height: height), fitMode: Toucan.Resize.FitMode.Crop).image
        
        let data = UIImageJPEGRepresentation(img, 0.8)
        
        let download=dispatch_get_global_queue(QOS_CLASS_DEFAULT,0)
        
        dispatch_async(download) {
            data!.writeToFile(p, atomically: true)
        }
        
        return data!
        
    }
    func removeImage(id:String!) {
        let p = self.pathForIdentifier(id)
        let p2 = self.pathForIdentifier(id,dir: "thumb")
        
        
        do {
            try NSFileManager.defaultManager().removeItemAtPath(p)
            try NSFileManager.defaultManager().removeItemAtPath(p2)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
        
        
        
    }
    func storeImage(image: UIImage?,withIdentifier identifier: String!) -> NSData {
        
        let p = self.pathForIdentifier(identifier)
        
        let data = UIImageJPEGRepresentation(image!, 0.8)
        
        let download=dispatch_get_global_queue(QOS_CLASS_DEFAULT,0)
        
        dispatch_async(download) {
            data!.writeToFile(p, atomically: true)
        }
        
        return data!
        
    }
    
    func downloadAndSaveImage(id:String!, url: String, didComplete: (image: UIImage, thumb:UIImage, error: NSError?) ->  Void) -> NSURLSessionDataTask  {
        
        let task=downloadImage(url) { imageData, error in
            
            if imageData != nil {
                
                let image=UIImage(data: imageData!)
                self.storeImage(image,withIdentifier: id!)
                
                let thumb=UIImage(data: self.storeThumbImage(image,width: 300,height: 300,path: id!))
                
                didComplete(image:image!, thumb:thumb!, error:nil)
            }
        }
        
        return task
        
    }
    
    //Mark: - Base64 utils
    func convertImageToBase64(image: UIImage) -> String {
        
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        return base64String
        
    }
    
    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters )
        
        let decodedimage = UIImage(data: decodedData!)
        
        return decodedimage!
        
    }
}
