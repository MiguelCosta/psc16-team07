//
//  BaseManager.m
//  MyMenu
//
//  Created by Renata on 09/09/16.
//  Copyright © 2016 Caldonian. All rights reserved.
//

#import "BaseManager.h"
#import <AFNetworking/AFNetworking.h>
#import "JSONObject.h"
#import "HTTPConstants.h"

@interface BaseManager ()


@property (nonatomic, strong) AFHTTPSessionManager     * requestManager;


@end

@implementation BaseManager

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.requestManager = [[AFHTTPSessionManager alloc] init];
        [self createHTTPHeaders];
        [self createResponseSerializer];
        [self configureBackgroundQueueToResponse];
    }
    return self;
}

- (id)initWithDelegate:(id<ManagerDelegate>)delegate {
    
    self=[self init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)createHTTPHeaders {
    
    [self.requestManager.requestSerializer setValue:@"application/json, text/plain, */*" forHTTPHeaderField:@"Accept"];
}

- (void)createResponseSerializer {
    
    AFJSONResponseSerializer * serializer = [[AFJSONResponseSerializer alloc] init];
    serializer.removesKeysWithNullValues = YES;
    [serializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"text/html;charset=utf-8", nil]];
    self.requestManager.responseSerializer = serializer;
}

- (void)createRequestSerializer {
    
    AFJSONRequestSerializer * serializer = [[AFJSONRequestSerializer alloc] init];
    self.requestManager.requestSerializer = serializer;
}

- (void)configureBackgroundQueueToResponse {
    
    self.requestManager.completionQueue= dispatch_queue_create("com.mymenu.requestQueue", DISPATCH_QUEUE_SERIAL);
}

- (NSError *)handleErrorForRequestOperation:(NSURLSessionDataTask *)task andError:(NSError *)error {
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    
    return [NSError errorWithDomain:error.domain code:httpResponse.statusCode userInfo:error.userInfo];
}

- (NSString *)constructEndpointFromString:(NSString *)endpoint {
    
    return [NSString stringWithFormat:@"http://%@/%@", HTTPHostServerURL, endpoint];
}

- (void)postDataToEndpoint:(NSString *)endpoint withData:(id)postData successBlock:(successBlock)successBlock andFailureBlock:(failureBlock)failureBock {
    
    if (postData) {
        [self createRequestSerializer];
    }
    [self createHTTPHeaders];
    
    [self.requestManager POST:[self constructEndpointFromString:endpoint] parameters:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                successBlock([responseObject objectForKey:@"data"]);
            } else if ([responseObject isKindOfClass:[NSData class]]) {
                id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                if ([jsonData isKindOfClass:[NSDictionary class]]) {
                    successBlock([responseObject objectForKey:@"data"]);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(managerDidFailed:withError:)]) {
            [self.delegate managerDidFailed:self withError:[self handleErrorForRequestOperation:task andError:error]];
        }
        if (failureBock) {
            failureBock([self handleErrorForRequestOperation:task andError:error]);
        }
        
    }];
}

- (void)getDataFromEndpoint:(NSString *) endpoint respondToDelegate:(BOOL)respondToDelegate cached:(BOOL)cached successBlock:(successBlock)successBlock andFailureBlock:(failureBlock)failureBock {
    
    [self createHTTPHeaders];
    
    [self.requestManager GET:[self constructEndpointFromString:endpoint] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                successBlock(responseObject);
            } else if ([responseObject isKindOfClass:[NSData class]]) {
                id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                if ([jsonData isKindOfClass:[NSDictionary class]]) {
                    successBlock([responseObject objectForKey:@"data"]);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (respondToDelegate) {
            
            NSLog(@"DEU C");
            
            if ([self.delegate respondsToSelector:@selector(managerDidFailed:withError:)]) {
                [self.delegate managerDidFailed:self withError:[self handleErrorForRequestOperation:task andError:error]];
            }
        }
        if (failureBock) {
            failureBock([self handleErrorForRequestOperation:task andError:error]);
        }
    }];
}

- (void)getData:(NSString *)endpoint successBlock:(successBlock)successBlock andFailureBlock:(failureBlock)failureBock {
    
    [self getDataFromEndpoint:endpoint respondToDelegate:YES cached:YES successBlock:successBlock andFailureBlock:failureBock];
}

- (void)deleteDataFromEndpoint:(NSString *)endpoint successBlock:(successBlock)successBlock andFailureBlock:(failureBlock)failureBock {
    
    [self.requestManager DELETE:[self constructEndpointFromString:endpoint] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                successBlock([responseObject objectForKey:@"data"]);
            }else if ([responseObject isKindOfClass:[NSData class]]) {
                id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                if ([jsonData isKindOfClass:[NSDictionary class]]) {
                    successBlock([responseObject objectForKey:@"data"]);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(managerDidFailed:withError:)]) {
            [self.delegate managerDidFailed:self withError:[self handleErrorForRequestOperation:task andError:error]];
        }
        if (failureBock) {
            failureBock([self handleErrorForRequestOperation:task andError:error]);
        }
    }];
}

- (NSMutableArray *)parseObjectsForClassRepresentation:(Class)classalloced withJsonObjects:(NSArray *)jsonObjects {
    
    NSMutableArray * returnObjects = [NSMutableArray array];
    
    if ([jsonObjects isKindOfClass:[NSArray class]]) {
        for (NSDictionary * jsonobj in jsonObjects) {
            id<JSONObject> obj=[[classalloced alloc] initFromJSONObject:jsonobj];
            if ([obj respondsToSelector:@selector(isValid)]) {
                if ([obj isValid]) {
                    [returnObjects addObject:obj];
                } else {
                    NSLog(@"[BaseManager - parseObjectsForClassRepresentation] --> Alguma coisa se passa %@!!!", [obj class]);
                }
            }
        }
    }
    return returnObjects;
}

- (NSMutableArray *)responseArrayFromJSONObject:(NSArray *)jsonObject objectsWithClass:(Class ) classalloced {
    
    NSMutableArray * returnObjects;
    returnObjects = [self parseObjectsForClassRepresentation:classalloced withJsonObjects:jsonObject];
    return returnObjects;
}

- (void)cancelAllRequests {
    
    for (NSURLSessionTask *task in self.requestManager.tasks) {
        [task cancel];
    }
}

@end
