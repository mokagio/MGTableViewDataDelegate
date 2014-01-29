
#import <UIKit/UIKit.h>

typedef void (^MGTableViewDataDelegateVoidBlock)();

@interface MGTableViewDataDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *sections;

- (instancetype)initWithSections:(NSArray *)sections;

@end

extern NSString * const MGTableViewDataDelegateSectionHeaderKey;
extern NSString * const MGTableViewDataDelegateSectionFooterKey;
extern NSString * const MGTableViewDataDelegateSectionRowsKey;

extern NSString * const MGTableViewDataDelegateRowTextKey;
extern NSString * const MGTableViewDataDelegateRowTextColorKey;
extern NSString * const MGTableViewDataDelegateRowDetailTextKey;
extern NSString * const MGTableViewDataDelegateRowAccessoryTypeKey;
extern NSString * const MGTableViewDataDelegateRowDidSelectBlockKey;
