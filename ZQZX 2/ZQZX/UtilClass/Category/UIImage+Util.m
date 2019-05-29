//
//  UIImage+Util.m
//  Ninesecretary
//
//  Created by 少爷 on 2017/6/3.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "UIImage+Util.h"
#import <Accelerate/Accelerate.h>
#import <AVKit/AVKit.h>

@implementation UIImage (Util)

+ (UIImage *)autoImageWithName:(NSString *)imageName {
    // 加载原有图片
    UIImage *norImage = [UIImage imageNamed:imageName];
    
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [norImage extendImageWithEdge:UIEdgeInsetsMake(0.9, 0.9, 0.9, 0.9)];
    
    return newImage;
}

+ (UIImage *)aroundImageWithName:(NSString *)imageName {
    // 加载原有图片
    UIImage *norImage = [UIImage imageNamed:imageName];
    
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [norImage extendImageWithEdge:UIEdgeInsetsMake(0.1, 0.1, 0.9, 0.9)];
    
    return newImage;
}

- (instancetype)extendImageWithEdge:(UIEdgeInsets)insets {
    // 获取原有图片的宽高的一半
    CGFloat top = self.size.width * insets.top;//0.1;
    CGFloat left = self.size.height * insets.left;//0.1;
    CGFloat rigth = self.size.height * insets.right;//0.9;
    CGFloat bottom = self.size.height * insets.bottom;//0.9;
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [self resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, rigth) resizingMode:UIImageResizingModeStretch];
    
    return newImage;
}

+ (UIImage *)imgWithColor:(UIColor *)color frame:(CGRect)frame {
    CGRect imgRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imgRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, imgRect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data, 
                                             outBuffer.width, 
                                             outBuffer.height, 
                                             8, 
                                             outBuffer.rowBytes, 
                                             colorSpace, 
                                             kCGImageAlphaNoneSkipLast); 
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx); 
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef]; 
    //clean up 
    CGContextRelease(ctx); 
    CGColorSpaceRelease(colorSpace); 
    free(pixelBuffer); 
    CFRelease(inBitmapData); 
    CGColorSpaceRelease(colorSpace); 
    CGImageRelease(imageRef); 
    return returnImage;
}

/**
 压缩图片

 @param ratio 压缩率
 @return 结果
 */
- (UIImage *)compressed:(float)ratio; {
//    0.5压缩率，3.1M -> 485.8KB 缩放率  6.53
//    6.3M(6427.2KB) -> 1026.5KB(1M)
    NSData *imageData = UIImageJPEGRepresentation(self, ratio);
    
//    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    file = [file stringByAppendingFormat:@"/imgRatio%.2f.jpg", ratio];
//    
//    NSLog(@"image at path: %@", file);
//    
//    NSFileManager *manage = [NSFileManager defaultManager];
//    
//    [manage createFileAtPath:file contents:imageData attributes:nil];
//    
//    NSLog(@"image compress %lu", (unsigned long)imageData.length / 1024);
    
    return [UIImage imageWithData:imageData];
}

- (UIImage *)equalScale:(CGFloat)width {
    CGFloat redio = self.size.height / self.size.width;
    CGFloat height = redio * width;
    return [self fitToSize:CGSizeMake(width, height)];
}

- (UIImage *)fitToSize:(CGSize)newSize; {
    UIGraphicsBeginImageContext(newSize);
    
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)flip:(BOOL)isHorizontal {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToRect(ctx, rect);
    if (isHorizontal) {
        CGContextRotateCTM(ctx, M_PI);
        CGContextTranslateCTM(ctx, -rect.size.width, -rect.size.height);
    }
    CGContextDrawImage(ctx, rect, self.CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)flipVertical {
    return [self flip:NO];
}

- (UIImage *)flipHorizontal {
    return [self flip:YES];
}

- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height {
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)resizeToScale:(CGFloat)scale {
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    UIImage *image = [self resizeToWidth:size.width * scale height:size.height * scale];
    return image;
}

- (UIImage *)NonDeformationResizeToWidth:(CGFloat)width height:(CGFloat)height backgroundColor:(UIColor *)color {
    UIImage *image1 = [UIImage imgWithColor:color frame:CGRectMake(0, 0, width, height)];
    UIImage *image2 = self;
    
    CGSize size = CGSizeMake(width, height);
    
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:CGRectMake(0, 0, width, height)];
    
    CGSize size2 = image2.size;
    
    if (size2.width > width || size2.height > height) {
        CGFloat scale = size2.width < size2.height ? height / size2.height : width / size2.width;
        image2 = [image2 resizeToScale:scale];
    }
    CGRect frame2 = CGRectMake(0, 0, size2.width, size2.height);
    
    frame2.origin.y = height / 2 - CGRectGetMidY(frame2);
    frame2.origin.x = width / 2 - CGRectGetMidX(frame2);
    
    [image2 drawInRect:frame2];
    UIImage *ZImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ZImage;
}

///在图片下方绘制文字，并生成一张新的图片
- (UIImage *)addText:(NSString *)text attributes:(nullable NSDictionary<NSAttributedStringKey,id> *)attr inset:(UIEdgeInsets)insets {
    CGFloat scale = [UIScreen mainScreen].scale;
    NSMutableDictionary<NSAttributedStringKey,id> *attrs = [attr mutableCopy];
    UIFont *font = [attrs objectForKey:NSFontAttributeName];
    [attrs setObject:[UIFont systemFontOfSize:font.pointSize] forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(self.size.width - insets.left - insets.right, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//    UIGraphicsBeginImageContext(CGSizeMake(self.size.width, self.size.height + insets.top + size.height + insets.bottom));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width, self.size.height + insets.top + size.height + insets.bottom), NO, scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *image1 = [UIImage imgWithColor:[UIColor whiteColor] frame:CGRectMake(0, 0, self.size.width, insets.top + size.height + insets.bottom)];
    [image1 drawInRect:CGRectMake(0, self.size.height, self.size.width, insets.top + size.height + insets.bottom + 1)];
    [text drawInRect:CGRectMake(insets.left, insets.top + self.size.height, self.size.width - insets.left - insets.right , size.height + 1) withAttributes:attrs];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)convertViewToImage:(UIView *)view
{
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    view.layer.contents = nil;
    return image;
}

- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    return image;
}

- (UIImage *)autoOrientationUp {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    
    //参考坐标系为数学坐标系，旋转方向为逆时针
    UIImage *img = [[self restoreImage] rotationToOrientation:self.imageOrientation];
    
    return img;
}

- (UIImage *)rotationToOrientation:(UIImageOrientation)orientation {
    CGFloat angle = 0;
    CGFloat tx = 0;
    CGFloat ty = 0;
    
    switch (orientation) {
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            tx = self.size.width;
            ty = self.size.height;
            angle = -M_PI;
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            tx = self.size.height;
            angle = M_PI_2;
            break;
            
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            tx = self.size.width;
            ty = self.size.height;
            angle = M_PI;
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            ty = self.size.width;
            angle = -M_PI_2;
            
        default:
            break;
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, tx, ty);
    transform = CGAffineTransformRotate(transform, angle);
    
    switch (orientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformScale(transform, 1, -1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = nil;
    
    if (fabs(angle / M_PI) == 1) {
        ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                    CGImageGetBitsPerComponent(self.CGImage), 0,
                                    CGImageGetColorSpace(self.CGImage),
                                    CGImageGetBitmapInfo(self.CGImage));
    } else {
        ctx = CGBitmapContextCreate(NULL, self.size.height, self.size.width,
                                    CGImageGetBitsPerComponent(self.CGImage), 0,
                                    CGImageGetColorSpace(self.CGImage),
                                    CGImageGetBitmapInfo(self.CGImage));
    }
    CGContextConcatCTM(ctx, transform);
    CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

/**
 由于从系统相册或者相机中获取的图像都经过特殊旋转处理，但这种旋转又不会影响实际图像的方向，故而还原图像为UIImageOrientationUp，从而剔除系统处理
 */
- (UIImage *)restoreImage {
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.height, self.size.width,
                                CGImageGetBitsPerComponent(self.CGImage), 0,
                                CGImageGetColorSpace(self.CGImage),
                                CGImageGetBitmapInfo(self.CGImage));
    CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage);
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg scale:self.scale orientation:UIImageOrientationUp];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

+ (UIImage *)videoThumbnailWithString:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumbnail = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return thumbnail;
}

@end
