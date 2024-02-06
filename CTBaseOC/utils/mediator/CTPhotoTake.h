//
//  CTPhotoTake.h
//  OCFramework
//
//  Created by curtis on 2021/3/15.
//  Copyright © 2021 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PhotoCompletionBlock)(UIImage *photo);
typedef void(^PhotosCompletionBlock)(NSArray<UIImage *> *photos);

///拍照或相册
@interface CTPhotoTake : NSObject

//照片选取最大数量
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) BOOL cropBool; // YES 裁剪 NO 不裁剪

- (instancetype)initWithParentController:(UIViewController *)parentController;
- (instancetype)initWithParentController:(UIViewController *)parentController isSave:(BOOL)isSave;
- (instancetype)initWithParentController:(UIViewController *)parentController maxCount:(NSInteger)maxCount;
- (instancetype)initWithParentController:(UIViewController *)parentController isSave:(BOOL)isSave maxCount:(NSInteger)maxCount;
- (void)takeOrChoose:(PhotoCompletionBlock)block;
- (void)take:(PhotoCompletionBlock)block;
- (void)takeISFront:(PhotoCompletionBlock)block;
- (void)choose:(PhotoCompletionBlock)block;
- (void)choosePhotos:(PhotosCompletionBlock)block;
- (void)takeOrChoosePhotos:(PhotosCompletionBlock)block;

@end

NS_ASSUME_NONNULL_END
