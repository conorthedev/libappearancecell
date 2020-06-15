#import <Preferences/PSSpecifier.h>

@interface AppearanceTypeStackView : UIView
@end

@interface AppearanceSelectionTableCell : PSTableCell
@property(nonatomic, retain) UIStackView *containerStackView;
@property(nonatomic, retain) NSArray *options;

- (void)updateForType:(int)type;
@end
