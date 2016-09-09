//
//  BaseManager.h
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ManagerDelegate;


@interface BaseManager : NSObject


typedef void(^successBlock)(id object);

typedef void(^failureBlock)(NSError * error);

@property (nonatomic, weak)   id                delegate;


- (id)initWithDelegate:(id<ManagerDelegate>)delegate;

- (void)postDataToEndpoint:(NSString *)endpoint withData:(id)postData successBlock:(successBlock)successBlock andFailureBlock:(failureBlock)failureBock;

- (void)getData:(NSString *)endpoint successBlock:(successBlock)successBlock andFailureBlock:(failureBlock)failureBock;

- (void)deleteDataFromEndpoint:(NSString *)endpoint successBlock:(successBlock)successBlock andFailureBlock:(failureBlock)failureBock;

- (NSMutableArray *)parseObjectsForClassRepresentation:(Class)classalloced withJsonObjects:(NSArray *)jsonObjects;

- (NSMutableArray *)responseArrayFromJSONObject:(NSArray *)jsonObject objectsWithClass:(Class ) classalloced;

- (void)cancelAllRequests;

@end

@protocol ManagerDelegate <NSObject>

@optional

- (void)managerWillStart:(BaseManager *)manager;

- (void)managerCanceled:(BaseManager *)manager;

- (void)managerDidFailed:(BaseManager *)manager withError:(NSError *)err;


@end
