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
BPVStringConstantWithValue(kBPVDefaultStoreType, NSSQLiteStoreType);
BPVStringConstantWithValue(kBPVMomType, momd);
BPVStringConstant(BPVFiles);
BPVStringConstantWithValue(kBPVSQLite, sqlite);

#define BPVDefaultStoreName(momName) \
    [NSString stringWithFormat:@"%@%@", momName, kBPVStore]

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
    return __sharedManager;
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
    self.storeName = storeName;
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
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:self.momName ofType:kBPVMomType];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
 
    NSURL *url = [NSURL fileURLWithPath:[[NSFileManager applicationDataPathWithFolderName:BPVFiles] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", self.storeName, kBPVSQLite]]];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSString *storeType = self.storeType;
    if (!storeType) {
        storeType = kBPVDefaultStoreType;
    }
    
    [_persistentStoreCoordinator addPersistentStoreWithType:storeType
                                              configuration:nil
                                                        URL:url
                                                    options:nil
                                                      error:&error] ;
    
    return _persistentStoreCoordinator;
}

#pragma mark -
#pragma mark Public Implementations

- (void)deleteCurrentStore {
    NSString *storePath = [[NSFileManager libraryDirectoryPath] stringByAppendingString:[NSString stringWithFormat:@"%@%@",self.storeName, kBPVSQLite]];
    NSPersistentStore *persistentStore = [[self.persistentStoreCoordinator persistentStores] firstObject];
    [self.persistentStoreCoordinator removePersistentStore:persistentStore error:nil];
    [[NSFileManager defaultManager] removeItemAtURL:persistentStore.URL error:nil];
    
    NSLog(@"Store at path:%@, was deleted", storePath);
    __sharedManager = nil;
}

@end
