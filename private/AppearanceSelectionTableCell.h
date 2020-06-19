#import "../libappearancecell.h"
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h> 

@interface UIImage (Private)
+ (UIImage*)kitImageNamed:(NSString*)name;
@end

@interface UIColor (libappearancecell)
+ (UIColor *)colorFromHexString:(NSString *)hexString;
@end

@interface AppearanceTypeStackView ()
@property(nonatomic, retain) UIImage *iconImage;
@property(nonatomic, retain) UIImageView *iconView;
@property(nonatomic, retain) UILabel *captionLabel;
@property(nonatomic, retain) UIButton *checkmarkButton;
@property(nonatomic, retain) UIStackView *contentStackview;
@property(nonatomic, retain) AppearanceSelectionTableCell *hostController;
@property(nonatomic, retain) UIImpactFeedbackGenerator *feedbackGenerator;
@property(nonatomic, retain) UILongPressGestureRecognizer *tapGestureRecognizer;
@property(nonatomic, assign) int type;
@property(nonatomic, retain) NSString *defaultsIdentifier;
@property(nonatomic, retain) NSString *postNotification;
@property(nonatomic, retain) NSString *key;
@property(nonatomic, retain) NSString *tintColor;
@property(nonatomic, retain) NSUserDefaults *defaults;

- (AppearanceTypeStackView *)initWithType:(int)type forController:(AppearanceSelectionTableCell *)controller withImage:(UIImage *)image andText:(NSString *)text andSpecifier:(PSSpecifier *)specifier;
- (void)buttonTapped:(UILongPressGestureRecognizer *)sender;
@end