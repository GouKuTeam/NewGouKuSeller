//
//  NotificationService.m
//  GouKuSellerPush
//
//  Created by 窦建斌 on 2018/4/24.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "NotificationService.h"
#import <AVFoundation/AVFoundation.h>
@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
//    AVSpeechSynthesizer * av = [[AVSpeechSynthesizer alloc]init];
//    //设置播报的内容
//    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc]initWithString:@"成功收款100元"];
//    //设置语言类别
//    utterance.rate = AVSpeechUtteranceDefaultSpeechRate;
//    AVSpeechSynthesisVoice * voiceType = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
//    utterance.voice = voiceType;
//    //设置播报语速
//    utterance.rate = 0.5;
//    [av speakUtterance:utterance];
    
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
