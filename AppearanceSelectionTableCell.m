#import "private/AppearanceSelectionTableCell.h"

@implementation AppearanceTypeStackView

- (AppearanceTypeStackView *)initWithType:(int)type forController:(AppearanceSelectionTableCell *)controller withImage:(UIImage *)image andText:(NSString *)text andSpecifier:(PSSpecifier *)specifier {
    self = [super init];
    if (self) {
        self.postNotification = specifier.properties[@"PostNotification"];
        self.key = specifier.properties[@"key"];
        self.tintColor = specifier.properties[@"tintColor"];
        self.defaults = [[NSUserDefaults alloc] initWithSuiteName:specifier.properties[@"defaults"]];
        self.hostController = controller;
        self.captionLabel = [[UILabel alloc] init];
        self.checkmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.checkmarkButton.frame = CGRectMake(0, 0, 22, 22);
        self.feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
        self.iconImage = image;
        self.captionLabel.text = text;

        [self.feedbackGenerator prepare];
        [self.defaults registerDefaults:@{ self.key : @0 }];

        int appearanceStyle = [[self.defaults objectForKey:self.key] intValue];
        self.type = type;

        self.checkmarkButton.selected = appearanceStyle == self.type;
        
        [self.checkmarkButton setImage:[[UIImage kitImageNamed:@"UIRemoveControlMultiNotCheckedImage.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.checkmarkButton setImage:[[UIImage kitImageNamed:@"UITintedCircularButtonCheckmark.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];

        if(self.checkmarkButton.selected) {
            if(self.tintColor) {
                self.checkmarkButton.tintColor = [UIColor colorFromHexString:self.tintColor];
            } else {
                self.checkmarkButton.tintColor = [UIColor systemBlueColor];
            }
        } else {
            self.checkmarkButton.tintColor = [UIColor systemGrayColor];
        }

        self.iconView = [[UIImageView alloc] initWithImage:self.iconImage];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.iconView.heightAnchor constraintEqualToConstant:120.5].active = true;

        [self.captionLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [self.captionLabel.heightAnchor constraintEqualToConstant:20].active = true;

        if (@available(iOS 13.0, *)) {
            [self.captionLabel setTextColor:[UIColor labelColor]];
        } else {
            [self.captionLabel setTextColor:[UIColor blackColor]];
        }

        [self.checkmarkButton.heightAnchor constraintEqualToConstant:22].active = true;
        [self.checkmarkButton.widthAnchor constraintEqualToConstant:22].active = true;

        [self.checkmarkButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];

        self.contentStackview = [[UIStackView alloc] init];
        self.contentStackview.axis = UILayoutConstraintAxisVertical;
        self.contentStackview.alignment = UIStackViewAlignmentCenter;
        self.contentStackview.spacing = 8;

        [self.contentStackview addArrangedSubview:self.iconView];
        [self.contentStackview addArrangedSubview:self.captionLabel];
        [self.contentStackview addArrangedSubview:self.checkmarkButton];

        self.contentStackview.translatesAutoresizingMaskIntoConstraints = false;
        self.translatesAutoresizingMaskIntoConstraints = false;

        self.tapGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped:)];
        self.tapGestureRecognizer.minimumPressDuration = 0;

        [self addSubview:self.contentStackview];
        [self.contentStackview setUserInteractionEnabled:YES];
        [self.contentStackview addGestureRecognizer:self.tapGestureRecognizer];

        [self.iconView.widthAnchor constraintEqualToConstant:85].active = true;
        [self.widthAnchor constraintEqualToAnchor:self.contentStackview.widthAnchor].active = true;
        [self.heightAnchor constraintEqualToAnchor:self.contentStackview.heightAnchor].active = true;
    }

    return self;
}

- (void)buttonTapped:(UILongPressGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0.5;
        } completion:^(BOOL finished) {}];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 1;
            [self.hostController updateForType:self.type];
        } completion:^(BOOL finished) {}];

        [self.feedbackGenerator impactOccurred];

        [self.defaults setObject:[NSNumber numberWithInt:self.type] forKey:self.key];
        [self.defaults synchronize];

        if(self.postNotification) {
            CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)self.postNotification, NULL, NULL, YES);
        }
    }
}

@end

@implementation AppearanceSelectionTableCell

- (AppearanceSelectionTableCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self) {
        self.options = specifier.properties[@"options"];

        self.containerStackView = [[UIStackView alloc] init];
        self.containerStackView.axis = UILayoutConstraintAxisHorizontal;
        self.containerStackView.alignment = UIStackViewAlignmentCenter;
        self.containerStackView.distribution = UIStackViewDistributionEqualSpacing;
        self.containerStackView.spacing = 40;
        self.containerStackView.translatesAutoresizingMaskIntoConstraints = NO;

        NSBundle *prefsBundle = [NSBundle bundleForClass:[specifier.target class]];
        for (NSDictionary *option in self.options) {
            AppearanceTypeStackView *stackView = [[AppearanceTypeStackView alloc] initWithType:[self.options indexOfObject:option] 
                                                                                  forController:self 
                                                                                  withImage:[UIImage imageNamed:option[@"image"] inBundle:prefsBundle compatibleWithTraitCollection:NULL]
                                                                                  andText:option[@"text"]
                                                                                  andSpecifier:specifier];
            [self.containerStackView addArrangedSubview:stackView];
        }

        [self.contentView addSubview:self.containerStackView];

        [self.containerStackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = true;
        [self.containerStackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = true;
        [self.heightAnchor constraintEqualToConstant:210].active = true;
    }

    return self;
}

- (AppearanceSelectionTableCell *)initWithSpecifier:(PSSpecifier *)specifier {
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AppearanceSelectionTableCell" specifier:specifier];
    return self;
}

- (void)updateForType:(int)type {
    for (AppearanceTypeStackView *subview in self.containerStackView.arrangedSubviews) {
        subview.checkmarkButton.selected = subview.type == type;

        if(subview.checkmarkButton.selected) {
            if(subview.tintColor) {
                subview.checkmarkButton.tintColor = [UIColor colorFromHexString:subview.tintColor];
            } else {
                subview.checkmarkButton.tintColor = [UIColor systemBlueColor];
            }
        } else {
            subview.checkmarkButton.tintColor = [UIColor systemGrayColor];
        }
    }
}

@end