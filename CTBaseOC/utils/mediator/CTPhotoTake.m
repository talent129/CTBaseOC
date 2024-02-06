//
//  CTPhotoTake.m
//  OCFramework
//
//  Created by curtis on 2021/3/15.
//  Copyright © 2021 CY. All rights reserved.
//

#import "CTPhotoTake.h"
#import <TZImagePickerController/TZImagePickerController.h>

#define PhotoWidth 750

@interface CTPhotoTake()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, copy) PhotoCompletionBlock photoCompletionBlock;
@property (nonatomic, copy) PhotosCompletionBlock photosCompletionBlock;
@property (nonatomic, strong) UIViewController *parentController;
@property (nonatomic, assign) BOOL isFront;
@property (nonatomic, assign) BOOL isSave;

@end

@implementation CTPhotoTake

- (instancetype)initWithParentController:(UIViewController *)parentController {
    return [self initWithParentController:parentController isSave:NO maxCount:1];
}

- (instancetype)initWithParentController:(UIViewController *)parentController isSave:(BOOL)isSave {
    return [self initWithParentController:parentController isSave:isSave maxCount:1];
}

- (instancetype)initWithParentController:(UIViewController *)parentController maxCount:(NSInteger)maxCount {
    return [self initWithParentController:parentController isSave:NO maxCount:maxCount];
}

- (instancetype)initWithParentController:(UIViewController *)parentController isSave:(BOOL)isSave maxCount:(NSInteger)maxCount {
    if (self = [super init]) {
        self.parentController = parentController;
        self.isFront = NO;
        self.isSave = isSave;
        self.maxCount = (maxCount == 0 ? 1: maxCount);
    }
    return self;
}

- (void)takeOrChoose:(PhotoCompletionBlock)block {
    self.photoCompletionBlock = block;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    [alert addAction:camera];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从手机相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self pushImagePickerController];
    }];
    [alert addAction:album];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:cancel];
    [self.parentController presentViewController:alert animated:YES completion:nil];
}

- (void)take:(PhotoCompletionBlock)block {
    self.photoCompletionBlock = block;
    [self takePhoto];
}

- (void)takeISFront:(PhotoCompletionBlock)block {
    self.photoCompletionBlock = block;
    self.isFront = YES;
    [self takePhoto];
}

- (void)choose:(PhotoCompletionBlock)block {
    self.photoCompletionBlock = block;
    [self pushImagePickerController];
}

- (void)choosePhotos:(PhotosCompletionBlock)block {
    self.photosCompletionBlock = block;
    [self pushImagePickerController];
}

- (void)takeOrChoosePhotos:(PhotosCompletionBlock)block {
    self.photosCompletionBlock = block;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    [alert addAction:camera];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从手机相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self pushImagePickerController];
    }];
    [alert addAction:album];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:cancel];
    [self.parentController presentViewController:alert animated:YES completion:nil];
}

- (void)takePhoto {
    if (![CTTool cameraAuthority]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""允许访问相机" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
        [alert addAction:cancel];
        
        UIAlertAction *setting = [UIAlertAction actionWithTitle:@"设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }];
        [alert addAction:setting];
        [self.parentController presentViewController:alert animated:YES completion:nil];
    } else if (![CTTool albumAuthority]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""允许访问相册" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
        [alert addAction:cancel];
        
        UIAlertAction *setting = [UIAlertAction actionWithTitle:@"设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }];
        [alert addAction:setting];
        [self.parentController presentViewController:alert animated:YES completion:nil];
    } else {
        
        if (@available(iOS 14.0, *)) {
            
            [PHPhotoLibrary requestAuthorizationForAccessLevel:(PHAccessLevelReadWrite) handler:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusLimited) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *message = @"\"照片->所有照片\"\n以便于上传照片作为您的头像";
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"推荐授权" message:message preferredStyle:(UIAlertControllerStyleAlert)];
                        UIAlertAction *setting = [UIAlertAction actionWithTitle:@"去授权" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                        }];
                        [alert addAction:setting];
                        NSMutableAttributedString *messageAttribute = [[NSMutableAttributedString alloc] initWithString:message];
                        NSRange range = NSMakeRange(0, 10);
                        [messageAttribute addAttributes:@{NSForegroundColorAttributeName: [UIColor systemBlueColor]} range:range];
                        //attributedTitle
                        //attributedMessage
                        //titleTextColor
                        [alert setValue:messageAttribute forKey:@"attributedMessage"];
                        [self.parentController presentViewController:alert animated:YES completion:nil];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                            picker.delegate = self;
                            picker.sourceType = sourceType;
                            picker.cameraDevice = self.isFront? UIImagePickerControllerCameraDeviceFront:UIImagePickerControllerCameraDeviceRear;
                            [self.parentController presentViewController:picker animated:YES completion:nil];
                        } else {
                            NSLog(@"模拟器中无法打开照相机");
                        }
                    });
                }
            }];
        } else {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.sourceType = sourceType;
                picker.cameraDevice = self.isFront? UIImagePickerControllerCameraDeviceFront:UIImagePickerControllerCameraDeviceRear;
    //            picker.modalPresentationStyle = UIModalPresentationFullScreen;
                [self.parentController presentViewController:picker animated:YES completion:nil];
            } else {
                NSLog(@"模拟器中无法打开照相机");
            }
        }
    }
}

- (void)pushImagePickerController {
    
    if (![CTTool albumAuthority]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""允许访问相册,以便于拍摄照片作为您的头像" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
        [alert addAction:cancel];
        
        UIAlertAction *setting = [UIAlertAction actionWithTitle:@"设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }];
        [alert addAction:setting];
        [self.parentController presentViewController:alert animated:YES completion:nil];
    } else {
        if (@available(iOS 14.0, *)) {
            
            [PHPhotoLibrary requestAuthorizationForAccessLevel:(PHAccessLevelReadWrite) handler:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusLimited) {
                    
//                    BOOL first = [[NSUserDefaults standardUserDefaults] boolForKey:kFirstAlbumAuthurity];
//                    if (!first) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount delegate:nil];
//                            picker.allowTakePicture = NO;
//                            picker.allowPickingVideo = NO;
//                            picker.allowPickingGif = NO;
//                            picker.allowPickingOriginalPhoto = NO;
//                            picker.allowCrop = self.cropBool;
//                            picker.cropRect = CGRectMake(0, (SCREEN_Height - SCREEN_Width)/2.0, SCREEN_Width, SCREEN_Width);
//                            picker.photoWidth = PhotoWidth;
//
//                            [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//                                if (photos.count > 0) {
//                                    UIImage *image = photos.firstObject;
//                                    if (image != nil) {
//                                        if (self.photoCompletionBlock) {
//                                            self.photoCompletionBlock(image);
//                                        }
//                                    }
//                                }
//                                if (self.photosCompletionBlock) {
//                                    self.photosCompletionBlock(photos);
//                                }
//                            }];
//                            picker.modalPresentationStyle = UIModalPresentationFullScreen;
//                            [self.parentController presentViewController:picker animated:YES completion:nil];
//                        });
////                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstAlbumAuthurity];
////                        [[NSUserDefaults standardUserDefaults] synchronize];
//                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSString *message = @"\"照片->所有照片\"\n以便于上传照片作为您的头像";
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"推荐授权" message:message preferredStyle:(UIAlertControllerStyleAlert)];
                            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self modifyNavigationBarWithType:true];
                                    TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount delegate:nil];
                                    picker.pickerDelegate = self;
                                    picker.allowTakePicture = NO;
                                    picker.allowPickingVideo = NO;
                                    picker.allowPickingGif = NO;
                                    picker.allowPickingOriginalPhoto = NO;
                                    picker.allowCrop = self.cropBool;
                                    picker.cropRect = CGRectMake(0, (SCREEN_Height - SCREEN_Width)/2.0, SCREEN_Width, SCREEN_Width);
                                    picker.photoWidth = PhotoWidth;
                                    
                                    [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                                        if (photos.count > 0) {
                                            UIImage *image = photos.firstObject;
                                            if (image != nil) {
                                                if (self.photoCompletionBlock) {
                                                    [self modifyNavigationBarWithType:false];
                                                    self.photoCompletionBlock(image);
                                                }
                                            }
                                        }
                                        if (self.photosCompletionBlock) {
                                            [self modifyNavigationBarWithType:false];
                                            self.photosCompletionBlock(photos);
                                        }
                                    }];
                                    picker.modalPresentationStyle = UIModalPresentationFullScreen;
                                    [self.parentController presentViewController:picker animated:YES completion:nil];
                                });
                            }];
                            [alert addAction:cancel];
                            UIAlertAction *setting = [UIAlertAction actionWithTitle:@"去授权" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                            }];
                            [alert addAction:setting];
                            NSMutableAttributedString *messageAttribute = [[NSMutableAttributedString alloc] initWithString:message];
                            NSRange range = NSMakeRange(0, 10);
                            [messageAttribute addAttributes:@{NSForegroundColorAttributeName: [UIColor systemBlueColor]} range:range];
                            //attributedTitle
                            //attributedMessage
                            //titleTextColor
                            [alert setValue:messageAttribute forKey:@"attributedMessage"];
                            [self.parentController presentViewController:alert animated:YES completion:nil];
                        });
//                    }
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self modifyNavigationBarWithType:true];
                        TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount delegate:nil];
                        picker.pickerDelegate = self;
                        picker.allowTakePicture = NO;
                        picker.allowPickingVideo = NO;
                        picker.allowPickingGif = NO;
                        picker.allowPickingOriginalPhoto = NO;
                        picker.allowCrop = self.cropBool;
                        picker.cropRect = CGRectMake(0, (SCREEN_Height - SCREEN_Width)/2.0, SCREEN_Width, SCREEN_Width);
                        picker.photoWidth = PhotoWidth;
                        
                        [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                            if (photos.count > 0) {
                                UIImage *image = photos.firstObject;
                                if (image != nil) {
                                    if (self.photoCompletionBlock) {
                                        [self modifyNavigationBarWithType:false];
                                        self.photoCompletionBlock(image);
                                    }
                                }
                            }
                            if (self.photosCompletionBlock) {
                                [self modifyNavigationBarWithType:false];
                                self.photosCompletionBlock(photos);
                            }
                        }];
                        picker.modalPresentationStyle = UIModalPresentationFullScreen;
                        [self.parentController presentViewController:picker animated:YES completion:nil];
                    });
                }
            }];
        } else {
            [self modifyNavigationBarWithType:true];
            TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount delegate:nil];
            picker.pickerDelegate = self;
            picker.allowTakePicture = NO;
            picker.allowPickingVideo = NO;
            picker.allowPickingGif = NO;
            picker.allowPickingOriginalPhoto = NO;
            picker.allowCrop = self.cropBool;
            picker.cropRect = CGRectMake(0, (SCREEN_Height - SCREEN_Width)/2.0, SCREEN_Width, SCREEN_Width);
            picker.photoWidth = PhotoWidth;
            
            [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                if (photos.count > 0) {
                    UIImage *image = photos.firstObject;
                    if (image != nil) {
                        if (self.photoCompletionBlock) {
                            [self modifyNavigationBarWithType:false];
                            self.photoCompletionBlock(image);
                        }
                    }
                }
                if (self.photosCompletionBlock) {
                    [self modifyNavigationBarWithType:false];
                    self.photosCompletionBlock(photos);
                }
            }];
            picker.modalPresentationStyle = UIModalPresentationFullScreen;
            [self.parentController presentViewController:picker animated:YES completion:nil];
        }
    }
}

#pragma mark -UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    NSString *type = info[UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        if (image != nil) {
            image = [image scaleImageToSize:CGSizeMake(PhotoWidth, (CGFloat)(PhotoWidth * image.size.height / image.size.width))];
            if (self.isSave) {
                [image savedPhotosAlbum];
            }
            if (self.photoCompletionBlock) {
                [self modifyNavigationBarWithType:false];
                self.photoCompletionBlock(image);
            }
            if (self.photosCompletionBlock) {
                self.photosCompletionBlock(@[image]);
            }
        }
        [picker dismissViewControllerAnimated:YES completion:^{
            NSLog(@"dismissViewControllerAnimated");
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismissViewControllerAnimated");
    }];
}

#pragma mark -TZImagePickerControllerDelegate
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    [self modifyNavigationBarWithType:false];
}

- (void)modifyNavigationBarWithType:(BOOL)type {
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *app = [UINavigationBarAppearance new];
        [app configureWithDefaultBackground];
        if (type) {
            app.backgroundColor = [UIColor colorWithDecimalRed:66 green:66 blue:66 alpha:1];
            app.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor appColorWhite]};
        } else {
            app.backgroundColor = [UIColor navigationColor];
            app.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor navigationTitleColor], NSFontAttributeName:[UIFont fontMedium17]};
        }
        app.shadowImage = [UIImage new];
        app.shadowColor = [UIColor clearColor];
        [[UINavigationBar appearance] setScrollEdgeAppearance:app];
        [[UINavigationBar appearance] setStandardAppearance:app];
    }
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
