//
//  utf.h
//  libShadowTrackerExtraDylib
//
//  Created by 李良林 on 2021/1/29.
//

#ifndef utf_h
#define utf_h

#include <stdio.h>
#include <MacTypes.h>
#define FALSE  0
#define TRUE   1
 
#define halfShift    10
#define UNI_SUR_HIGH_START  (UTF32)0xD800
#define UNI_SUR_HIGH_END    (UTF32)0xDBFF
#define UNI_SUR_LOW_START   (UTF32)0xDC00
#define UNI_SUR_LOW_END     (UTF32)0xDFFF
/* Some fundamental constants */
#define UNI_REPLACEMENT_CHAR (UTF32)0x0000FFFD
#define UNI_MAX_BMP (UTF32)0x0000FFFF
#define UNI_MAX_UTF16 (UTF32)0x0010FFFF
#define UNI_MAX_UTF32 (UTF32)0x7FFFFFFF
#define UNI_MAX_LEGAL_UTF32 (UTF32)0x0010FFFF
 
typedef unsigned char   boolean;
typedef unsigned int    CharType;
typedef unsigned char   UTF8;
typedef unsigned short  UTF16;
typedef unsigned int    UTF32;

static const UTF32 halfMask = 0x3FFUL;
static const UTF32 halfBase = 0x0010000UL;
static const UTF8 firstByteMark[7] = { 0x00, 0x00, 0xC0, 0xE0, 0xF0, 0xF8, 0xFC };
static const UTF32 offsetsFromUTF8[6] = { 0x00000000UL, 0x00003080UL, 0x000E2080UL, 0x03C82080UL, 0xFA082080UL, 0x82082080UL };
static const char trailingBytesForUTF8[256] =
{
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5
};

typedef enum
{
    strictConversion = 0,
    lenientConversion
} ConversionFlags;

typedef enum
{
    conversionOK,         /* conversion successful */
    sourceExhausted,    /* partial character in source, but hit end */
    targetExhausted,    /* insuff. room in target for conversion */
    sourceIllegal,        /* source sequence is illegal/malformed */
    conversionFailed
} ConversionResult;

//ConversionResult ConvertUTF8toUTF16 (
//        const UTF8** sourceStart, const UTF8* sourceEnd,
//        UTF16** targetStart, UTF16* targetEnd, ConversionFlags flags);
//
//ConversionResult ConvertUTF16toUTF8 (
//        const UTF16** sourceStart, const UTF16* sourceEnd,
//        UTF8** targetStart, UTF8* targetEnd, ConversionFlags flags);
//
//ConversionResult ConvertUTF8toUTF32 (
//        const UTF8** sourceStart, const UTF8* sourceEnd,
//        UTF32** targetStart, UTF32* targetEnd, ConversionFlags flags);
//
//ConversionResult ConvertUTF32toUTF8 (
//        const UTF32** sourceStart, const UTF32* sourceEnd,
//        UTF8** targetStart, UTF8* targetEnd, ConversionFlags flags);
//
//ConversionResult ConvertUTF16toUTF32 (
//        const UTF16** sourceStart, const UTF16* sourceEnd,
//        UTF32** targetStart, UTF32* targetEnd, ConversionFlags flags);
//
//ConversionResult ConvertUTF32toUTF16 (
//        const UTF32** sourceStart, const UTF32* sourceEnd,
//        UTF16** targetStart, UTF16* targetEnd, ConversionFlags flags);
//
//Boolean isLegalUTF8Sequence(const UTF8 *source, const UTF8 *sourceEnd);

int Utf32_To_Utf8 (const UTF32* sourceStart, UTF8* targetStart, size_t outLen ,  ConversionFlags flags);
int ConvertUTF32toUTF8 (const UTF32* sourceStart, UTF8* targetStart, size_t outLen ,  ConversionFlags flags);
#endif /* utf_h */










