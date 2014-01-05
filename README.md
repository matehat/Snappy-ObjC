# Snappy-ObjC

Google's Snappy compression power as NSData/NSString categories. All you need to know to use it:

```objective-c
#import "Snappy-ObjC.h"
NSData *someCompressedData = [NSData dataWithContentsOfURL:somewhereOnDiskWhereThereIsCompressedData];
NSData *uncompressedData = [someCompressedData snappy_decompressedData];
NSData *backToCompressedData = [uncompressedData snappy_compressedData];
NSAssert([backToCompressedData isEqualToData:someCompressedData], @"IT SHOULD HAVE BEEN EQUAL!");

// It works with NSString (UTF8 only) too!
NSString *imGoingToGetShrinked = @"Hello, World!";
NSData *shrinked = [imGoingToGetShrinked snappy_compressedString];
NSString *imBackAsAWhole = [shrinked snappy_decompressedString];
NSAssert([imGoingToGetShrinked isEqualToString:imBackAsAWhole], @"IT SHOULD HAVE BEEN EQUAL!");
```

It uses [snappy-c][2], a C port of [Google's Snappy][1] compression library (originally written in C++). It performs
pretty well, by trading off some compression ratio. In their own words:

> Snappy is a compression/decompression library. It does not aim for maximum compression, or compatibility with any 
other compression library; instead, it aims for very high speeds and reasonable compression. For instance, compared 
to the fastest mode of zlib, Snappy is an order of magnitude faster for most inputs, but the resulting compressed files 
are anywhere from 20% to 100% bigger. On a single core of a Core i7 processor in 64-bit mode, Snappy compresses at 
about 250 MB/sec or more and decompresses at about 500 MB/sec or more.

### Installation

Using [CocoaPods][3] (which you should be using), only add a line saying `pod 'Snappy'` and compress away.

### Method prefix

If you want to do without the `snappy_*` prefix in front of all method names, simply add a preprocessor macro named `SNAPPY_NO_PREFIX`. 

If you are using cocoapods, that means going to the `Pods-Snappy` target in your "Pods" Xcode project, to its build settings, finding the "Preprocessor Macros" setting and adding the above macro. Note that you'll have to do this after every run of cocoapod (everytime you type `pod [something]` in your project's folder), since cocoapod overrides that setting when it runs. There is going to be a fix for this [sometime in the future](https://github.com/CocoaPods/CocoaPods/issues/833). Meanwhile, you can add this code to your project's Podfile:

```ruby
post_install do |rep|
  rep.project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= '$(inherited)'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] <<= " SNAPPY_NO_PREFIX=1"
    end
  end
end
```

### Testing

The project includes a (simple) [test suite](Tests/Snappy-ObjC Tests/Snappy_ObjC_Tests.m).

1. Clone the repo
2. Go in Tests/
3. `pod install`
4. Open Snappy-ObjC.xcworkspace and run the tests

### License

The MIT License (MIT)

Copyright (c) 2013 Mathieu D'Amours

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[1]: http://code.google.com/p/snappy/
[2]: https://github.com/andikleen/snappy-c
[3]: http://cocoapods.org
