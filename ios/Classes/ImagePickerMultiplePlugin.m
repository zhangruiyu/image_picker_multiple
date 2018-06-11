#import "ImagePickerMultiplePlugin.h"
#import "TZImagePickerController.h"

@interface ImagePickerMultiplePlugin()<TZImagePickerControllerDelegate>

@end

@implementation ImagePickerMultiplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"multiple_image_picker"
            binaryMessenger:[registrar messenger]];
  ImagePickerMultiplePlugin* instance = [[ImagePickerMultiplePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"pickImage" isEqualToString:call.method]) {
      TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
      
      // You can get the photos by block, the same as by delegate.
      // 你可以通过block或者代理，来得到用户选择的照片.
      [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
          NSMutableArray *selectedPics = [NSMutableArray arrayWithCapacity:[infos count]];

          for(id item in infos){
              [selectedPics addObject:[item objectForKey:@"PHImageFileSandboxExtensionTokenKey"]];
              
          }
           result(selectedPics);
           NSLog(@"%@",  infos);
      }];
//      [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//          result(assets);
//      }];
//      [self presentViewController:imagePickerVc animated:YES completion:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
//    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

//- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto;
//- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos;
////- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker __attribute__((deprecated("Use -tz_imagePickerControllerDidCancel:.")));
//- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker;
//
//// If user picking a video, this callback will be called.
//// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
//// 如果用户选择了一个视频，下面的handle会被执行
//// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
//- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset;
//
//// If user picking a gif image, this callback will be called.
//// 如果用户选择了一个gif图片，下面的handle会被执行
//- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset;

// Decide album show or not't
// 决定相册显示与否 albumName:相册名字 result:相册原始数据
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result{
    return YES;
}

// Decide asset show or not't
// 决定照片显示与否
- (BOOL)isAssetCanSelect:(id)asset{
    return YES;
}

@end
