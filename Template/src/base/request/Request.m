//
//  Request.m
//  
//
//  Created by Yiming Lin on 11/7/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "Request.h"
#import "RequestDataSource.h"
#import "TBGlobalErrorView.h"
#import "RequestConf.h"

@implementation Request

@synthesize type = _type; 
@synthesize method = _method;
@synthesize params = _params;

- (id) init
{
    if (self= [super init]) {
        _params = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (Request*) requestWithMethod:(int) method
                      paramArray:(NSArray*) values
{
    Request * result = [[Request alloc] init];
    
    result.type = method;
    result.method = [[RequestDataSource globalRequestDataSource] getName:method];

    NSArray * paramArray = [Request getParamArray:method];
    
    int paramCount = values.count;
    for (int i=0; i<paramCount; ++i) {
        if (EMPTYPARAMVALUE==[values objectAtIndex:i]) {
            continue;
        }
        [result.params setObject:[values objectAtIndex:i]
                          forKey:[paramArray objectAtIndex:i]];
    }

    TTDASSERT(paramArray.count>=values.count);
    
    return result;
}

+ (Request*) requestWithMethod:(int) method
                          params:(id) value1, ...
{
    Request * result = [[Request alloc] init];
    result.type = method;
    result.method = [[RequestDataSource globalRequestDataSource] getName:method];
    
    NSArray* paramArray =[Request getParamArray:method];
    
    va_list args;
    va_start(args, value1);
    
    int i =0;
    for (id arg = value1; arg != nil; arg = va_arg(args, id),++i)
    {
        if (arg==EMPTYPARAMVALUE) {
            continue;
        }
        TTDASSERT(paramArray.count>=i);
        [result.params setObject:arg
                          forKey:[paramArray objectAtIndex:i]];
    }
    va_end(args);
    
    TTDASSERT(paramArray.count>=result.params.count);
    
    return result;
}

+ (NSArray*) getParamArray:(int) method
{
    NSString* paramStr= [[RequestDataSource globalRequestDataSource] getParams:method];
    NSArray* paramArray = [paramStr componentsSeparatedByString:@","];
    return paramArray;
}

- (NSArray*) getRequest
{
    NSArray* result=[NSArray arrayWithObjects:_method,_params,nil];
    return result;
}

- (NSDictionary*) parseJSONResponse:(NSArray*) response
                             status:(NSMutableDictionary**) status{
    
    NSDictionary* statusEntry = [response objectAtIndex:0];
    [*status setDictionary:statusEntry];

    if (response.count>1) {
        NSDictionary* contentEntry = [response objectAtIndex:1];
        return contentEntry;
    }

    return nil;
}

- (id) parseResponse:(PBCodedInputStream *)input
{
    MsgApiStatus* status = [MsgApiStatus parseFromData:[input readData]];
    if(status.code == STATUS_SUCCESS)
    {
        Class returnClass = [[RequestDataSource globalRequestDataSource] getReturnClass:_type];
        if (returnClass!=nil) {
            id returnValue=nil;
            returnValue = [returnClass parseFromData:[input readData]];
            return returnValue;
        }
    }else
    {
        TTDERROR(@"%d:%@", status.code,status.message);
        @throw [NSException exceptionWithName:@"DSRequest parseResponse" 
                                       reason:status.message 
                                     userInfo:[NSDictionary dictionaryWithObject:status 
                                                                          forKey:@"status"]];
    }
    return nil;
}

- (NSString*) description{
    return [NSString stringWithFormat:@"request %@ with params:\n%@",self.method,self.params];
}

@end

@implementation EmptyParamValue
+ (EmptyParamValue*) emptyParamValue
{
    static EmptyParamValue* emptyParamValue=nil;
    if (nil == emptyParamValue) {
        emptyParamValue = [[EmptyParamValue alloc] init];
    }
    return emptyParamValue;
}
@end
