//
//  NSData+Snappy.h
//  Snappy for Objective-C
//
//  Created by Mathieu D'Amours on 5/18/13.
//
//

#import <Foundation/Foundation.h>

@interface NSData (Snappy)

- (NSData *) compressedData;
- (NSData *) uncompressedData;

@end
