//
//  KBLibrary.h
//  KBLibrary
//
//  Created by SXJY on 2021/6/25.
//

#ifndef KBLibrary_h
#define KBLibrary_h

#ifdef __OBJC__

#import <QuartzCore/QuartzCore.h>

/*其他三方库,如需KBLibrary.h自动引入这部分.h文件，请在自己项目中定义KB_AUTO_IMPORT*/
#ifdef KB_AUTO_IMPORT
//#define MAS_SHORTHAND   //用于省略mas前缀,如需该宏定义，请在自己工程中定义
#define MAS_SHORTHAND_GLOBALS
#import "IQKeyboardManager.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "Masonry.h"
#import "AvoidCrash.h"
#endif

/*本地文件*/
#import "KBMacroDefine.h"
#import "KBProperty.h"
#import "KBBlock.h"
#import "KBDateFormat.h"
#import "KBTool.h"
#import "NSObject+KBCustom.h"
#import "NSString+KBCustom.h"
#import "NSData+KBCustom.h"
#import "NSDate+KBCustom.h"
#import "UIImage+KB.h"
#import "NSMutableArray+KB.h"
#import "UIColor+KBCustom.h"
#import "UIView+KBCustom.h"
#import "UIImageView+KB.h"
#import "UITableView+KBCustom.h"
#import "UIViewController+KBCustom.h"
#import "KBTreeModel.h"
#import "KBTranslucentAlertViewController.h"

#endif

#endif /* KBLibrary_h */
