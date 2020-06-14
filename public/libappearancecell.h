#import <Preferences/PSSpecifier.h>

@interface AppearanceTypeStackView : UIView
@end

@interface AppearanceSelectionTableCell : PSTableCell
@property(nonatomic, retain) UIStackView *containerStackView;
@property(nonatomic, retain) AppearanceTypeStackView *firstStackView;
@property(nonatomic, retain) AppearanceTypeStackView *secondStackView;

- (void)updateForType:(int)type;
@end
