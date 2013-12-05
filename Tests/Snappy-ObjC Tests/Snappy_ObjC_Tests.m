//
//  Snappy_ObjC_Tests.m
//  Snappy-ObjC Tests
//
//  Created by Mathieu D'Amours on 12/4/13.
//
//

#include <stdlib.h>
#import <XCTest/XCTest.h>
#import <Snappy-ObjC.h>

#ifdef SNAPPY_NO_PREFIX
#define mn(_name_) _name_
#else
#define mn(_name_) snappy_ ## _name_
#endif

NSData* randomNSData(size_t size) {
    size = ceil(size/4) * 4;
    NSMutableData* theData = [NSMutableData dataWithCapacity:size];
    for( unsigned int i = 0 ; i < size/4 ; ++i ) {
        u_int32_t randomBits = arc4random();
        [theData appendBytes:(void*)&randomBits length:4];
    }
    return theData;
}

@interface Snappy_ObjC_Tests : XCTestCase

@end

@implementation Snappy_ObjC_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCompressionIntegrity {
    NSData *randomData = randomNSData(20*1024);
    NSData *compressedData = [randomData mn(compressedData)];
    XCTAssertEqualObjects([compressedData mn(decompressedData)], randomData, @"Decompressing the compressed data should yield the original data");
    
    randomData = randomNSData(20*1024*1024);
    compressedData = [randomData mn(compressedData)];
    XCTAssertEqualObjects([compressedData mn(decompressedData)], randomData, @"Decompressing the compressed data should yield the original data");
}

- (void)testTextCompression {
    NSString *text = @"Look, just because I don't be givin' no man a foot massage don't make it right for Marsellus to throw Antwone into a glass motherfuckin' house, fuckin' up the way the nigger talks. Motherfucker do that shit to me, he better paralyze my ass, 'cause I'll kill the motherfucker, know what I'm sayin'?\
    The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men. Blessed is he who, in the name of charity and good will, shepherds the weak through the valley of darkness, for he is truly his brother's keeper and the finder of lost children. And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.\
    Now that we know who you are, I know who I am. I'm not a mistake! It all makes sense! In a comic, you know how you can tell who the arch-villain's going to be? He's the exact opposite of the hero. And most times they're friends, like you and me! I should've known way back when... You know why, David? Because of the kids. They called me Mr Glass.";
    
    NSData *compressed = [text mn(compressedString)];
    XCTAssert(text.length > compressed.length, @"Compressed text should be smaller than uncompressed");
    XCTAssertEqualObjects(text, [compressed mn(decompressedString)], @"Decompressing the compressed text should yield the original text");
}

- (void)testJSONCompression {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *filepath = [NSString pathWithComponents:@[[bundle resourcePath], @"example.json"]];
    NSData *original = [NSData dataWithContentsOfFile:filepath];
    NSData *compressed = [original mn(compressedData)];
    XCTAssert(original.length > compressed.length, @"Compressed JSON should be smaller than uncompressed");
    NSData *decompressed = [compressed mn(decompressedData)];
    XCTAssertEqualObjects(decompressed, original, @"Decompressing the compressed JSON should yield the original text");
    
    NSError *error;
    [NSJSONSerialization JSONObjectWithData:decompressed options:0 error:&error];
    XCTAssertNil(error, @"Decompressed data should be valid JSON");
}

@end
