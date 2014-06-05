
#import "MGTableViewDataDelegate.h"

NSString * const MGTableViewDataDelegateSectionHeaderKey = @"mg_section_header";
NSString * const MGTableViewDataDelegateSectionFooterKey = @"mg_section_footer";
NSString * const MGTableViewDataDelegateSectionRowsKey = @"mg_section_rows";

NSString * const MGTableViewDataDelegateRowTextKey = @"mg_row_text";
NSString * const MGTableViewDataDelegateRowTextColorKey = @"mg_row_text_color";
NSString * const MGTableViewDataDelegateRowDetailTextKey = @"mg_row_detail";
NSString * const MGTableViewDataDelegateRowAccessoryTypeKey = @"mg_row_accessory";
NSString * const MGTableViewDataDelegateRowDidSelectBlockKey = @"mg_row_block";

@implementation MGTableViewDataDelegate

- (instancetype)initWithSections:(NSArray *)sections
{
    self = [super init];
    if (!self) return nil;
    
    self.sections = sections;
    
    return self;
}

- (id)init
{
    return [self initWithSections:nil];
}

#pragma mark - UITableViewDataSource Sections

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sections[section][MGTableViewDataDelegateSectionHeaderKey];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.sections[section][MGTableViewDataDelegateSectionFooterKey];
}

#pragma mark - UITabelViewDataSource Rows

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sections[section][MGTableViewDataDelegateSectionRowsKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MGCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *cellDescription = self.sections[indexPath.section][MGTableViewDataDelegateSectionRowsKey][indexPath.row];

    cell.textLabel.text = cellDescription[MGTableViewDataDelegateRowTextKey];
    
    if (cellDescription[MGTableViewDataDelegateRowTextColorKey]) {
        cell.textLabel.textColor = cellDescription[MGTableViewDataDelegateRowTextColorKey];
    } else {
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    
    cell.detailTextLabel.text = cellDescription[MGTableViewDataDelegateRowDetailTextKey];
    
    UITableViewCellAccessoryType accessoryType = cellDescription[MGTableViewDataDelegateRowAccessoryTypeKey]
    ? [cellDescription[MGTableViewDataDelegateRowAccessoryTypeKey] integerValue]
    : UITableViewCellAccessoryNone;
    cell.accessoryType = accessoryType;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellDescription = [self dictionaryForRowAtIndexPath:indexPath];
    MGTableViewDataDelegateVoidBlock action = cellDescription[MGTableViewDataDelegateRowDidSelectBlockKey];
    if (action) action();
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Utils

- (NSDictionary *)dictionaryForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.sections[indexPath.section][MGTableViewDataDelegateSectionRowsKey][indexPath.row];
}

@end
