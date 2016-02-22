//
//  XXTEA.h
//  XXTEA - https://github.com/everbeen/xxtea
//
//  Copyright (c) 2015 Eric
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import <Foundation/Foundation.h>

#ifndef __G7_EVERBEEN_XXTEA_H__
#define __G7_EVERBEEN_XXTEA_H__

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Secret key length.
 */
extern const size_t G7_XXTEA_KEY_LENGTH;

/**
 * Encrypt @p data using specified key @p key.
 *
 * @param data The @p NSData object to be encrypted.
 * @param key 16 bytes secret key.
 *
 * @return Encrypted data chunk or @p nil if error occurred.
 */
NSData *G7_XXTEAEncryptData(NSData *data, const unsigned char *key);

/**
 * Decrypt data chunk @p data using specified key @p key.
 *
 * @param data Data chunk to be decrypted.
 * @param key 16 bytes secret key.
 *
 * @return Origin data or @p nil if error occurred.
 */
NSData *G7_XXTEADecryptData(NSData *data, const unsigned char *key);

/**
 * Create a random secret key and fill it to @p key with ARC4-derived random data.
 *
 * @param key 16 bytes memory region.
 */
void G7_XXTEAFillRandomKey(unsigned char *key);

#ifdef __cplusplus
}
#endif

#endif
