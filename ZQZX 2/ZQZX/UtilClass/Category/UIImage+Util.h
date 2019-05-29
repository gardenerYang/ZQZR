//
//  UIImage+Util.h
//  Ninesecretary
//
//  Created by 少爷 on 2017/6/3.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

- (instancetype)extendImageWithEdge:(UIEdgeInsets)insets;

+ (UIImage *)autoImageWithName:(NSString *)imageName;
+ (UIImage *)aroundImageWithName:(NSString *)imageName;
+ (UIImage *)imgWithColor:(UIColor *)color frame:(CGRect)frame;
- (UIImage *)compressed:(float)ratio;
/**
 获取视频的缩略图
 */
+ (UIImage *)videoThumbnailWithString:(NSString *)string;
/**
 等比例缩放

 @param width 缩放后的宽
 @return 结果
 */
- (UIImage *)equalScale:(CGFloat)width;
- (UIImage *)fitToSize:(CGSize)newSize;

/*垂直翻转*/
- (UIImage *)flipVertical;

/*水平翻转*/
- (UIImage *)flipHorizontal;

/*改变size*/
- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height;
/// 等比例缩放
- (UIImage *)resizeToScale:(CGFloat)scale;
///不变形改变size
- (UIImage *)NonDeformationResizeToWidth:(CGFloat)width height:(CGFloat)height backgroundColor:(UIColor *)color;
///在图片下方绘制文字，并生成一张新的图片
- (UIImage *)addText:(NSString *)text attributes:(nullable NSDictionary<NSAttributedStringKey,id> *)attrs inset:(UIEdgeInsets)insets;
/*裁切*/
- (UIImage *_Nonnull)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

/**
 自动转换图片为竖屏模式
 */
- (UIImage *_Nonnull)autoOrientationUp;
/**
 旋转图片

 @param orientation UIImageOrientationLeft  就 表示向左旋转（以数学坐标系为准，逆时针旋转90˚）
 @return 结果
 */
- (UIImage *_Nonnull)rotationToOrientation:(UIImageOrientation)orientation;

@end
