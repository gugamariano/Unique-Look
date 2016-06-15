// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.1 clang-703.0.29)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import UIKit;
@import CoreGraphics;
@import FBSDKLoginKit;
@import CoreData;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

SWIFT_CLASS("_TtC11Unique_Look9AppConfig")
@interface AppConfig : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWindow;
@class User;
@class UIApplication;
@class NSURL;

SWIFT_CLASS("_TtC11Unique_Look11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
@property (nonatomic, strong) User * _Nullable loggedUser;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (BOOL)application:(UIApplication * _Nonnull)application openURL:(NSURL * _Nonnull)url sourceApplication:(NSString * _Nullable)sourceApplication annotation:(id _Nonnull)annotation;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
@end

@class Look;
@class FIRDatabaseReference;
@class FIRStorage;
@class NSManagedObjectContext;
@class UIImagePickerController;
@class UIImage;
@class UIStoryboardSegue;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC11Unique_Look20CameraViewController")
@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) Look * _Null_unspecified look;
@property (nonatomic, readonly, strong) FIRDatabaseReference * _Nonnull firebase;
@property (nonatomic, readonly, strong) FIRStorage * _Nonnull storage;
- (IBAction)choosePicture:(id _Nonnull)sender;
- (IBAction)takePicture:(id _Nonnull)sender;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)logOut;
- (void)didReceiveMemoryWarning;
@property (nonatomic, readonly, strong) NSManagedObjectContext * _Nonnull sharedContext;
- (void)showCamera;
- (void)showLibray;
- (void)imagePickerController:(UIImagePickerController * _Nonnull)picker didFinishPickingImage:(UIImage * _Null_unspecified)image editingInfo:(NSDictionary * _Null_unspecified)editingInfo;
- (void)saveLook:(UIImage * _Nonnull)image;
- (void)prepareForSegue:(UIStoryboardSegue * _Nonnull)segue sender:(id _Nullable)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIColor;
@class TagView;

SWIFT_CLASS("_TtC11Unique_Look11CloseButton")
@interface CloseButton : UIButton
@property (nonatomic) CGFloat iconSize;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor * _Nonnull lineColor;
@property (nonatomic, weak) TagView * _Nullable tagView;
- (void)drawRect:(CGRect)rect;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSFetchedResultsController;
@class NSDictionary;
@class FBSDKLoginButton;
@class FBSDKLoginManagerLoginResult;
@class NSError;
@class UIActivityIndicatorView;
@class UILabel;

SWIFT_CLASS("_TtC11Unique_Look19LoginViewController")
@interface LoginViewController : UIViewController <FBSDKLoginButtonDelegate, UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView * _Null_unspecified activityIndicator;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified loading;
@property (nonatomic, readonly, strong) FIRDatabaseReference * _Nonnull database;
@property (nonatomic, strong) User * _Null_unspecified localUser;
@property (nonatomic, readonly, strong) NSManagedObjectContext * _Nonnull sharedContext;
- (NSFetchedResultsController * _Nonnull)fetchedResultsControllerUser:(NSString * _Nonnull)uid;
- (NSFetchedResultsController * _Nonnull)fetchedResultsControllerLooks;
- (void)fetch:(NSFetchedResultsController * _Nonnull)frcToFetch;
- (void)viewDidLoad;
- (void)hideLoading;
- (void)showLoading;
- (void)viewWillAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (void)addFBLoginBtn;
- (void)deleteLocalLooks;
- (void)syncRemote:(NSDictionary * _Nonnull)user;
- (void)loginAction:(NSString * _Nonnull)accessToken;
- (void)loginButton:(FBSDKLoginButton * _Null_unspecified)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult * _Null_unspecified)result error:(NSError * _Null_unspecified)error;
- (void)loginButtonDidLogOut:(FBSDKLoginButton * _Null_unspecified)loginButton;
- (NSString * _Nullable)checkFBToken;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class FIRStorageReference;
@class NSEntityDescription;
@class LookTag;

SWIFT_CLASS("_TtC11Unique_Look4Look")
@interface Look : NSManagedObject
@property (nonatomic, readonly, strong) FIRDatabaseReference * _Nonnull database;
@property (nonatomic, readonly, strong) FIRStorageReference * _Nonnull storage;
@property (nonatomic, readonly, strong) NSManagedObjectContext * _Nonnull sharedContext;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDictionary:(NSDictionary * _Nonnull)dictionary context:(NSManagedObjectContext * _Nonnull)context OBJC_DESIGNATED_INITIALIZER;
- (void)addLookTag:(LookTag * _Nonnull)tag;
- (void)addTag:(NSString * _Nonnull)t;
- (void)deleteTag:(NSString * _Nonnull)tag;
- (void)deleteLookRemote:(double)lastUpdate;
- (void)deleteLook:(BOOL)remote;
- (void)saveLocalImage:(UIImage * _Nonnull)image;
- (void)saveImage:(UIImage * _Nonnull)image;
@end

@class NSNumber;
@class NSSet;

@interface Look (SWIFT_EXTENSION(Unique_Look))
@property (nonatomic, copy) NSString * _Nullable id;
@property (nonatomic, strong) NSNumber * _Nullable creationDate;
@property (nonatomic, strong) NSNumber * _Nullable lastUpdate;
@property (nonatomic, strong) NSNumber * _Nullable dayOfWeek;
@property (nonatomic, copy) NSString * _Nullable key;
@property (nonatomic, strong) NSSet * _Nullable tags;
@property (nonatomic, copy) NSString * _Nullable url;
@property (nonatomic, copy) NSString * _Nullable thumbUrl;
@property (nonatomic, strong) User * _Nullable user;
@end

@class NSURLSessionTask;
@class UIImageView;

SWIFT_CLASS("_TtC11Unique_Look8LookCell")
@interface LookCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView * _Null_unspecified activityIndicator;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified photo;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified date;
@property (nonatomic, strong) NSURLSessionTask * _Nullable taskToCancelifCellIsReused;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11Unique_Look24LookCollectionHeaderView")
@interface LookCollectionHeaderView : UICollectionReusableView
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified title;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSIndexPath;
@class UISearchBar;
@class UICollectionView;
@protocol NSFetchedResultsSectionInfo;

SWIFT_CLASS("_TtC11Unique_Look25LookHistoryViewController")
@interface LookHistoryViewController : UIViewController <UIBarPositioningDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, UISearchBarDelegate, UIScrollViewDelegate, UICollectionViewDelegate>
@property (nonatomic, strong) Look * _Null_unspecified look;
@property (nonatomic, strong) UIImagePickerController * _Null_unspecified imagePicker;
@property (nonatomic, copy) NSArray<NSIndexPath *> * _Nonnull selectedIndexes;
@property (nonatomic, copy) NSArray<NSIndexPath *> * _Null_unspecified insertedIndexPaths;
@property (nonatomic, copy) NSArray<NSIndexPath *> * _Null_unspecified deletedIndexPaths;
@property (nonatomic, copy) NSArray<NSIndexPath *> * _Null_unspecified updatedIndexPaths;
@property (nonatomic, weak) IBOutlet UICollectionView * _Null_unspecified collectionView;
@property (nonatomic, strong) UISearchBar * _Nonnull searchbar;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)fetch:(NSFetchedResultsController * _Nonnull)frcToFetch;
- (BOOL)searchBarShouldBeginEditing:(UISearchBar * _Nonnull)searchBar;
- (BOOL)searchBarShouldEndEditing:(UISearchBar * _Nonnull)searchBar;
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
@property (nonatomic, readonly, strong) NSManagedObjectContext * _Nonnull sharedContext;
@property (nonatomic, strong) NSFetchedResultsController * _Nonnull fetchedResultsController;
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView * _Nonnull)collectionView;
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)collectionView:(UICollectionView * _Nonnull)collectionView didSelectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)prepareForSegue:(UIStoryboardSegue * _Nonnull)segue sender:(id _Nullable)sender;
- (UICollectionReusableView * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView viewForSupplementaryElementOfKind:(NSString * _Nonnull)kind atIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)controllerWillChangeContent:(NSFetchedResultsController * _Nonnull)controller;
- (void)controller:(NSFetchedResultsController * _Nonnull)controller didChangeObject:(id _Nonnull)anObject atIndexPath:(NSIndexPath * _Nullable)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath * _Nullable)newIndexPath;
- (void)controller:(NSFetchedResultsController * _Nonnull)controller didChangeSection:(id <NSFetchedResultsSectionInfo> _Nonnull)sectionInfo atIndex:(NSInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type;
- (void)controllerDidChangeContent:(NSFetchedResultsController * _Nonnull)controller;
- (void)searchBarSearchButtonClicked:(UISearchBar * _Nonnull)searchBar;
- (void)searchBarCancelButtonClicked:(UISearchBar * _Nonnull)searchBar;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITableView;
@class LookTableViewCell;
@class UITableViewCell;
@class NSFetchRequest;

SWIFT_CLASS("_TtC11Unique_Look24LookSearchViewController")
@interface LookSearchViewController : UIViewController <UIScrollViewDelegate, NSFetchedResultsControllerDelegate, UITableViewDataSource, UINavigationControllerDelegate, UITableViewDelegate, UIBarPositioningDelegate, UISearchBarDelegate>
@property (nonatomic, weak) IBOutlet UITableView * _Null_unspecified tableView;
@property (nonatomic, strong) Look * _Null_unspecified look;
@property (nonatomic, strong) UISearchBar * _Nonnull searchbar;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)setupNavBar;
- (void)addSearchBar;
- (void)logOut;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)tableView:(UITableView * _Nonnull)tableView canEditRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)prepareForSegue:(UIStoryboardSegue * _Nonnull)segue sender:(id _Nullable)sender;
- (void)getRemoteImage:(LookTableViewCell * _Nonnull)cell look:(Look * _Nonnull)look;
- (void)controllerDidChangeContent:(NSFetchedResultsController * _Nonnull)controller;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)searchBarShouldBeginEditing:(UISearchBar * _Nonnull)searchBar;
- (BOOL)searchBarShouldEndEditing:(UISearchBar * _Nonnull)searchBar;
- (void)searchBarSearchButtonClicked:(UISearchBar * _Nonnull)searchBar;
- (void)searchBarCancelButtonClicked:(UISearchBar * _Nonnull)searchBar;
- (void)searchBar:(UISearchBar * _Nonnull)searchBar textDidChange:(NSString * _Nonnull)searchText;
@property (nonatomic, readonly, strong) NSManagedObjectContext * _Nonnull sharedContext;
@property (nonatomic, strong) NSFetchedResultsController * _Nonnull fetchedResultsController;
- (NSFetchRequest * _Nonnull)fetchRequest;
- (void)fetch:(NSFetchedResultsController * _Nonnull)frcToFetch;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11Unique_Look10LookTabBar")
@interface LookTabBar : UITabBar
- (CGSize)sizeThatFits:(CGSize)size;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class TagListView;

SWIFT_CLASS("_TtC11Unique_Look17LookTableViewCell")
@interface LookTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified photo;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified creationDate;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified weekDay;
@property (nonatomic, weak) IBOutlet TagListView * _Null_unspecified tagList;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView * _Null_unspecified activityView;
@property (nonatomic, strong) NSURLSessionTask * _Nullable taskToCancelifCellIsReused;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11Unique_Look7LookTag")
@interface LookTag : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDictionary:(NSDictionary * _Nonnull)dictionary context:(NSManagedObjectContext * _Nonnull)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface LookTag (SWIFT_EXTENSION(Unique_Look))
@property (nonatomic, copy) NSString * _Nullable text;
@property (nonatomic, strong) NSNumber * _Nullable creationDate;
@property (nonatomic, copy) NSString * _Nullable key;
@property (nonatomic, strong) Look * _Nullable look;
@end


SWIFT_PROTOCOL("_TtP11Unique_Look19TagListViewDelegate_")
@protocol TagListViewDelegate
@optional
- (void)tagPressed:(NSString * _Nonnull)title tagView:(TagView * _Nonnull)tagView sender:(TagListView * _Nonnull)sender;
- (void)tagRemoveButtonPressed:(NSString * _Nonnull)title tagView:(TagView * _Nonnull)tagView sender:(TagListView * _Nonnull)sender;
@end

@class UITextField;
@class NSNotification;

SWIFT_CLASS("_TtC11Unique_Look21LookTagViewController")
@interface LookTagViewController : UIViewController <UITextFieldDelegate, TagListViewDelegate>
@property (nonatomic, strong) Look * _Null_unspecified look;
@property (nonatomic, weak) IBOutlet TagListView * _Null_unspecified tagListView;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified imageView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView * _Null_unspecified activityIndicator;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified tagText;
- (IBAction)addTag:(id _Nonnull)sender;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;

/// return after done
- (BOOL)textFieldShouldReturn:(UITextField * _Nonnull)textField;

/// Get the keyboard height to use when need to scroll the screen.
- (CGFloat)getKeyboardHeight:(NSNotification * _Nonnull)notification;
- (void)setup;
@property (nonatomic, readonly, strong) NSManagedObjectContext * _Nonnull sharedContext;
- (void)tagPressed:(NSString * _Nonnull)title tagView:(TagView * _Nonnull)tagView sender:(TagListView * _Nonnull)sender;
- (void)tagRemoveButtonPressed:(NSString * _Nonnull)title tagView:(TagView * _Nonnull)tagView sender:(TagListView * _Nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface NSDate (SWIFT_EXTENSION(Unique_Look))
@end

enum Alignment : NSInteger;
@class UIFont;

SWIFT_CLASS("_TtC11Unique_Look11TagListView")
@interface TagListView : UIView
@property (nonatomic, strong) UIColor * _Nonnull textColor;
@property (nonatomic, strong) UIColor * _Nonnull selectedTextColor;
@property (nonatomic, strong) UIColor * _Nonnull tagBackgroundColor;
@property (nonatomic, strong) UIColor * _Nullable tagHighlightedBackgroundColor;
@property (nonatomic, strong) UIColor * _Nullable tagSelectedBackgroundColor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic, strong) UIColor * _Nullable borderColor;
@property (nonatomic, strong) UIColor * _Nullable selectedBorderColor;
@property (nonatomic) CGFloat paddingY;
@property (nonatomic) CGFloat paddingX;
@property (nonatomic) CGFloat marginY;
@property (nonatomic) CGFloat marginX;
@property (nonatomic) enum Alignment alignment;
@property (nonatomic, strong) UIColor * _Nonnull shadowColor;
@property (nonatomic) CGFloat shadowRadius;
@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) float shadowOpacity;
@property (nonatomic) BOOL enableRemoveButton;
@property (nonatomic) CGFloat removeButtonIconSize;
@property (nonatomic) CGFloat removeIconLineWidth;
@property (nonatomic, strong) UIColor * _Nonnull removeIconLineColor;
@property (nonatomic, strong) UIFont * _Nonnull textFont;
@property (nonatomic, weak) IBOutlet id <TagListViewDelegate> _Nullable delegate;
@property (nonatomic, readonly, copy) NSArray<TagView *> * _Nonnull tagViews;
@property (nonatomic, readonly, copy) NSArray<UIView *> * _Nonnull tagBackgroundViews;
@property (nonatomic, readonly, copy) NSArray<UIView *> * _Nonnull rowViews;
@property (nonatomic, readonly) CGFloat tagViewHeight;
@property (nonatomic, readonly) NSInteger rows;
- (void)prepareForInterfaceBuilder;
- (void)layoutSubviews;
- (CGSize)intrinsicContentSize;
- (TagView * _Nonnull)addTag:(NSString * _Nonnull)title;
- (TagView * _Nonnull)addTagView:(TagView * _Nonnull)tagView;
- (void)removeTag:(NSString * _Nonnull)title;
- (void)removeTagView:(TagView * _Nonnull)tagView;
- (void)removeAllTags;
- (NSArray<TagView *> * _Nonnull)selectedTags;
- (void)tagPressed:(TagView * _Null_unspecified)sender;
- (void)removeButtonPressed:(CloseButton * _Null_unspecified)closeButton;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

typedef SWIFT_ENUM(NSInteger, Alignment) {
  AlignmentLeft = 0,
  AlignmentCenter = 1,
  AlignmentRight = 2,
};



SWIFT_CLASS("_TtC11Unique_Look7TagView")
@interface TagView : UIButton
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic, strong) UIColor * _Nullable borderColor;
@property (nonatomic, strong) UIColor * _Nonnull textColor;
@property (nonatomic, strong) UIColor * _Nonnull selectedTextColor;
@property (nonatomic) CGFloat paddingY;
@property (nonatomic) CGFloat paddingX;
@property (nonatomic, strong) UIColor * _Nonnull tagBackgroundColor;
@property (nonatomic, strong) UIColor * _Nullable highlightedBackgroundColor;
@property (nonatomic, strong) UIColor * _Nullable selectedBorderColor;
@property (nonatomic, strong) UIColor * _Nullable selectedBackgroundColor;
@property (nonatomic, strong) UIFont * _Nonnull textFont;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;
@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic, readonly, strong) CloseButton * _Nonnull removeButton;
@property (nonatomic) BOOL enableRemoveButton;
@property (nonatomic) CGFloat removeButtonIconSize;
@property (nonatomic) CGFloat removeIconLineWidth;
@property (nonatomic, strong) UIColor * _Nonnull removeIconLineColor;

/// Handles Tap (TouchUpInside)
@property (nonatomic, copy) void (^ _Nullable onTap)(TagView * _Nonnull);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithTitle:(NSString * _Nonnull)title OBJC_DESIGNATED_INITIALIZER;
- (CGSize)intrinsicContentSize;
- (void)layoutSubviews;
@end


SWIFT_CLASS("_TtC11Unique_Look4User")
@interface User : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDictionary:(NSDictionary<NSString *, id> * _Nonnull)dictionary context:(NSManagedObjectContext * _Nonnull)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface User (SWIFT_EXTENSION(Unique_Look))
@property (nonatomic, copy) NSString * _Nullable uid;
@property (nonatomic, copy) NSString * _Nullable displayName;
@property (nonatomic, strong) NSNumber * _Nullable lastLogin;
@property (nonatomic, strong) NSNumber * _Nullable lastUpdate;
@property (nonatomic, strong) NSNumber * _Nullable creationDate;
@property (nonatomic, copy) NSString * _Nullable provider;
@property (nonatomic, copy) NSString * _Nullable email;
@property (nonatomic, strong) NSSet * _Nullable looks;
@end

#pragma clang diagnostic pop
