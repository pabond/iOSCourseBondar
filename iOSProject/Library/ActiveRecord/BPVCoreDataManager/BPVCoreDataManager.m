//
//  BPVCoreDataManager.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCoreDataManager.h"

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

static BPVCoreDataManager *__sharedManager = nil;

BPVStringConstantWithValue(kBPVStore, Store);
BPVStringConstantWithValue(kBPVDefaultStoreType, SQLite);
BPVStringConstantWithValue(kBPVMomType, momd);
BPVStringConstant(BPVFiles);
BPVStringConstantWithValue(kBPVSQLite, sqlite);

#define BPVDefaultStoreName(momName) \
    [NSString stringWithFormat:@"%@%@%@", momName, kBPVStore, kBPVSQLite]

@interface BPVCoreDataManager ()
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *storeType;
@property (nonatomic, copy) NSString *momName;

@property (nonatomic, strong) NSManagedObjectContext       *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel         *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (instancetype)initWithMomName:(NSString *)momName;

- (instancetype)initWithMomName:(NSString *)momName
                      storeName:(NSString *)storeName;

- (instancetype)initWithMomName:(NSString *)momName
                      storeName:(NSString *)storeName
                      storeType:(NSString *)storeType;

@end

@implementation BPVCoreDataManager

#pragma mark -
#pragma mark Class methods

+ (instancetype)sharedManager {
    return __sharedManager ? __sharedManager : [self sharedManagerWithMomName:[[NSBundle mainBundle] bundleIdentifier]];
}

+ (instancetype)sharedManagerWithMomName:(NSString *)momName {
    return [self sharedManagerWithMomName:momName storeName:BPVDefaultStoreName(momName)];
}

+ (instancetype)sharedManagerWithMomName:(NSString *)momName
                               storeName:(NSString *)storeName
{
    return [self sharedManagerWithMomName:momName storeName:storeName storeType:kBPVDefaultStoreType];
}

+ (instancetype)sharedManagerWithMomName:(NSString *)momName
                               storeName:(NSString *)storeName
                               storeType:(NSString *)storeType
{
    BPVReturnOnce(BPVCoreDataManager, manager, ^{
        return [[BPVCoreDataManager alloc] initWithMomName:momName storeName:storeName storeType:storeType];
    });
}

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithMomName:(NSString *)momName {
    return [self initWithMomName:momName storeName:BPVDefaultStoreName(momName)];
}

- (instancetype)initWithMomName:(NSString *)momName
                      storeName:(NSString *)storeName
{
    return [self initWithMomName:momName storeName:storeName storeType:kBPVDefaultStoreType];
}

- (instancetype)initWithMomName:(NSString *)momName
                      storeName:(NSString *)storeName
                      storeType:(NSString *)storeType
{
    self = [super init];
    self.momName = momName;
    self.storeName = [NSString stringWithFormat:@"%@%@", storeName, kBPVSQLite];
    self.storeType = storeType;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = coordinator;
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    NSURL *url = [bundle URLForResource:self.momName withExtension:kBPVMomType];
//    
//    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
     _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSString *folderPath = [NSFileManager applicationDataPathWithFolderName:BPVFiles];
    NSString *filePath = [folderPath stringByAppendingPathComponent:self.storeName];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSString *storeType = self.storeType;
    if (!storeType) {
        storeType = kBPVDefaultStoreType;
    }

    [_persistentStoreCoordinator addPersistentStoreWithType:storeType
                                              configuration:nil
                                                        URL:url
                                                    options:nil
                                                      error:nil];
    
    return _persistentStoreCoordinator;
}

@end
