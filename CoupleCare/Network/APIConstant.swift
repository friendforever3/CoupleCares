//
//  APIConstant.swift
//  CoupleCare
//
//  Created by Surinder kumar on 14/12/21.
//

import Foundation


struct APIConstant{
 
    static let kBaseUrl = "http://3.13.194.181:5004/api/v1/"
    
    static let kUser = "user/"
    static let kAdmin = "admin/"
    
    static let kSendOTP = kUser + "otp"
    static let kVerifyotp = kUser + "verifyotp"
    static let kResendotp = kUser + "resendotp"
    static let kInterestList = kAdmin + "interest/list"
    static let kRegister = kUser + "register"
    static let kNearBy = kUser + "nearbyyou"
    static let kDetail = kUser + "detail"
    static let kAllLikes = kUser + "all/likes"
    static let kLike = kUser + "like"
    static let kDislike = kUser + "dislike"
    static let kRemoveImage  = kUser + "remove/image"
    static let kUpdateprofileimage = kUser + "updateprofileimage"
    static let kUpdateprofile = kUser + "updateprofile"
    static let kUpdateimages = kUser + "updateimages"
    static let kAcceptProfile = kUser + "accept/profile"
    static let kSuperLikeProfile = kUser + "super/like/profile"
    static let kLikeProfile = kUser + "like/profile"
    static let kChatGroup = kUser + "chat/group"
    static let kChatHistory = kUser + "chat/history"
    
    static let kPostCreate = "post/create"
    static let kFeedList = kUser + "feed/list"
    static let kLikeUnlikePost = "likeUnlike/post"
    static let kLikeListPost = "like/list/post"
    
    static let kCommentAdd = "comment/add"
    static let kCommentList = "comment/list"
    static let kcommentAddReply = "comment/add/reply"
    static let kCommentReplyLikeUnlike = "comment/reply/likeUnlike"
    
    //Twilio Api Endpoint
    static let kTwillioVieoToken = kUser + "twillio/vieo/token"
    static let kTwillioAudioToken = kUser + "twillio/audio/token"
    static let kTwillioCall = kUser + "twillio/call"
    static let kTwillioCallAccept = kUser + "twillio/call/accept"
    static let kTwillioCallReject = kUser + "twillio/call/reject"

}

struct AppConstant{
    
    static let KOops = "Oops"
    static let kOk = "OK"
    static let kMsgMobile = "Please enter the mobile number"
    static let kMsgFullName = "Please enter the full name"
    static let kMsgDOB = "Please enter your birthday"
    static let kBio = "Please enter the bio"
    static let kJobTitle = "Please select the job title"
    static let kMsgGender = "Please select the gender"
    static let kMsgInterestedIn = "Please select the interested in"
    static let kMsgInterest = "Please select any interest"
    static let kMsgImage = "Please select the image"
    static let kMsgSelectImgCount = "Please select at least two images"
    static let kTextEmpty = "Please enter the text"
    static let kEmptyLocation = "Please enter the location"
    static let kEmptyCaption = "Please enter the caption"
    static let kSelectImage = "Please choose the image"
    static let kSelectVideo = "Please choose the video"
    
}
