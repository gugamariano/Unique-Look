//
//  Constants.swift
//  yniquedress
//
//  Created by antonio silva on 5/15/16.
//  Copyright © 2016 antonio silva. All rights reserved.
//

import Foundation


class AppConfig:NSObject{

struct Constants {
    
    static let FIREBASE_BUCKET:String = "gs://project-5169073298756295405.appspot.com"

    static let SEGUE_LOOK_DETAILS_TAG:String = "lookDetailSegue"

}

struct JSONKeys {
    
    static let PHOTO_PATH = "photoPath"
    static let PHOTO_URL = "photoURL"
    static let UID = "uid"
    static let ID = "id"
    static let KEY = "key"
    static let CREATION_DATE = "creationDate"
    static let DAY_OF_WEEK = "dayOfWeek"
    static let LAST_UPDATE = "lastUpdate"
    static let LAST_LOGIN = "lastLogin"

    static let THUMB_URL = "thumbUrl"
    static let IMAGE_URL = "url"
    static let EMAIL = "email"
    static let PROVIDER = "provider"
    static let DISPLAY_NAME = "displayName"
    
    static let TAGS = "tags"
    static let LOOKS = "looks"
    static let USERS = "users"
    static let IMAGES = "images"
    static let THUMBS = "thumbs"

    
}
    
    
}