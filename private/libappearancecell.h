#import <Preferences/PSSpecifier.h>

@protocol PreferencesTableCustomView
- (id)initWithSpecifier:(PSSpecifier *)specifier;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
@end

@interface AppearanceTypeStackView : UIView
@end

@interface AppearanceSelectionTableCell : PSTableCell <PreferencesTableCustomView>
@property(nonatomic, retain) UIStackView *containerStackView;
@property(nonatomic, retain) AppearanceTypeStackView *firstStackView;
@property(nonatomic, retain) AppearanceTypeStackView *secondStackView;

- (void)updateForType:(int)type;
@end
