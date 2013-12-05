//
//  Snappy-ObjC.m
//  Snappy for Objective-C
//
//  Created by Mathieu D'Amours on 5/18/13.
//
//  The MIT License (MIT)
//  
//  Copyright (c) 2013 Mathieu D'Amours
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "snappy.h"
#import "Snappy-ObjC.h"

@implementation NSData (Snappy)

- (NSData *) compressedData {
    struct snappy_env env;
    NSAssert(snappy_init_env(&env) == 0, @"Initialization of a Snappy compression environment was not successful.");
    size_t clen = snappy_max_compressed_length(self.length);
    NSAssert(clen >= 0, @"The length of the compressed buffer shouldn't be zero");
    char *buffer = malloc(clen);
    NSAssert(snappy_compress(&env, self.bytes, self.length, buffer, &clen) == 0, @"Compression of data was not successful");
    snappy_free_env(&env);
    return [NSData dataWithBytesNoCopy:buffer length:clen];
}
- (NSData *) decompressedData {
    size_t ulen;
    snappy_uncompressed_length(self.bytes, self.length, &ulen);
    char *buffer = malloc(ulen);
    assert(snappy_uncompress(self.bytes, self.length, buffer) == 0);
    return [NSData dataWithBytesNoCopy:buffer length:ulen];
}

- (NSString *) decompressedString {
    return [[NSString alloc] initWithData:[self decompressedData]
                                 encoding:NSUTF8StringEncoding];
}

@end

@implementation NSString (Snappy)

- (NSData *)compressedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO] compressedData];
}

@end
