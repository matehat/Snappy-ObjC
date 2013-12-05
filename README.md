# Snappy-ObjC

Google's Snappy compression power as NSData/NSString categories. All you need to know to use it:

```objective-c
#import "Snappy-ObjC.h"
NSData *someCompressedData = [NSData dataWithContentsOfURL:somewhereOnDiskWhereThereIsCompressedData];
NSData *uncompressedData = [someCompressedData decompressedData];
NSData *backToCompressedData = [uncompressedData compressedData];
NSAssert([backToCompressedData isEqualToData:someCompressedData], @"IT SHOULD HAVE BEEN EQUAL!");

// It works with NSString (UTF8 only) too!
NSString *imGoingToGetShrinked = @"Hello, World!";
NSData *shrinked = [imGoingToGetShrinked compressedString];
NSString *imBackAsAWhole = [shrinked decompressedString];
NSAssert([imGoingToGetShrinked isEqualToString:imBackAsAWhole], @"IT SHOULD HAVE BEEN EQUAL!");
```

It uses [snappy-c][2], a C port of [Google's Snappy][1] compression library (originally written in C++). It performs
pretty well, by trading off some compression ratio. In their own words:

> Snappy is a compression/decompression library. It does not aim for maximum compression, or compatibility with any 
other compression library; instead, it aims for very high speeds and reasonable compression. For instance, compared 
to the fastest mode of zlib, Snappy is an order of magnitude faster for most inputs, but the resulting compressed files 
are anywhere from 20% to 100% bigger. On a single core of a Core i7 processor in 64-bit mode, Snappy compresses at 
about 250 MB/sec or more and decompresses at about 500 MB/sec or more.

### Testing

The project includes a (simple) test suite.

1. Clone the repo
2. Go in Tests/
3. `pod install`
4. Open Snappy-ObjC.xcworkspace and run the tests

[1]: http://code.google.com/p/snappy/
[2]: https://github.com/andikleen/snappy-c
