#import "../public/libappearancecell.h"
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h> 

@interface UIImage (Private)
+ (UIImage*)kitImageNamed:(NSString*)name;
@end

@interface AppearanceTypeStackView ()
@property(nonatomic, retain) UIImage *iconImage;
@property(nonatomic, retain) UIImageView *iconView;
@property(nonatomic, retain) UILabel *captionLabel;
@property(nonatomic, retain) UIButton *checkmarkButton;
@property(nonatomic, retain) UIStackView *contentStackview;
@property(nonatomic, retain) AppearanceSelectionTableCell *hostController;
@property(nonatomic, retain) UIImpactFeedbackGenerator *feedbackGenerator;
@property(nonatomic, retain) UITapGestureRecognizer *tapGestureRecognizer;
@property(nonatomic, assign) int type;

- (AppearanceTypeStackView *)initWithType:(int)type forController:(AppearanceSelectionTableCell *)controller withImage:(UIImage *)image andText:(NSString *)text;
- (void)buttonTapped;
@end