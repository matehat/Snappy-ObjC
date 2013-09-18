//
//  NSData+Snappy.m
//  Snappy for Objective-C
//
//  Created by Mathieu D'Amours on 5/18/13.
//
//

#import "snappy.h"

@implementation NSData (Snappy)

- (NSData *) compressedData {
    struct snappy_env *env;
    assert(snappy_init_env(env) == 0);
    size_t clen = snappy_max_compressed_length(self.length);
    assert(clen >= 0);
    char *buffer = malloc(clen);
    assert(snappy_compress(env, self.bytes, self.length, buffer, &clen) == 0);
    snappy_free_env(env);
    return [NSData dataWithBytesNoCopy:buffer length:clen];
}
- (NSData *) uncompressedData {
    size_t ulen;
    snappy_uncompressed_length(self.bytes, self.length, &ulen);
    char *buffer = malloc(ulen);
    assert(snappy_uncompress(self.bytes, self.length, buffer) == 0);
    return [NSData dataWithBytesNoCopy:buffer length:ulen];
}

@end