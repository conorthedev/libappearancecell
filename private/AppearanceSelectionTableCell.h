#import "../public/libappearancecell.h"
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h> 

@interface NSUserDefaults (Private)
- (instancetype)_initWithSuiteName:(NSString *)suiteName container:(NSURL *)container;
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

- (id)initWithType:(int)type forController:(AppearanceSelectionTableCell *)controller;
- (void)buttonTapped;
@end