//
//  Utilities.m
//  Country
//
//  Created by Quyen Trinh on 5/10/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities
    
+ (NSBundle *)resourceBundle{
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Phone-Country-Code-and-Flags" ofType:@"bundle"]];
}
    
+ (NSData *)jsonDataForPath:(NSString *)path {
    return [[[NSString alloc] initWithContentsOfFile:[[self resourceBundle] pathForResource:path ofType:@"json"]
                                            encoding:NSUTF8StringEncoding
                                               error:NULL]
            dataUsingEncoding:NSUTF8StringEncoding];
}
    
+ (NSDictionary *)flagIndices {
    return [NSJSONSerialization JSONObjectWithData:[self jsonDataForPath:@"flag_indices"]
                                           options:kNilOptions
                                             error:nil];
}

+ (UIImage *)imageForCountryCode:(NSString *)code {
    NSNumber * y = [self flagIndices][code];
    if (!y) {
        y = @0;
    }
    CGImageRef cgImage = CGImageCreateWithImageInRect([[UIImage imageWithContentsOfFile:[[self resourceBundle] pathForResource:@"flags" ofType:@"png"]] CGImage], CGRectMake(0, y.integerValue * 2, 32, 32));
    UIImage * result = [UIImage imageWithCGImage:cgImage scale:2.0 orientation:UIImageOrientationUp];
    CGImageRelease(cgImage);
    return result;
}
    
@end
