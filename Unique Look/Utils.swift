import Foundation
import SystemConfiguration
import UIKit

public class Utils {
    
    class func checkConnection(view:UIViewController){
        
        let url = NSURL(string: "https://google.com/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 5
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    showAlert(view, title: "You're Off-line", msg: "Check your internet connection")
                }
            }else{
                showAlert(view, title: "You're Off-line", msg: "Check your internet connection")
            }
        })
        
        task.resume()
        
    }
    
    //display a UIAlertAction for a given message
    class func showAlert(view:UIViewController, title:String, msg:String) -> Void{
        
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default,handler:nil)
        alertController.addAction(OKAction)
        
        dispatch_async(dispatch_get_main_queue()){
            view.presentViewController(alertController, animated: true, completion:nil)
        }
        
    }
}
