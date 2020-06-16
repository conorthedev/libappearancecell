#import "private/AppearanceSelectionTableCell.h"

NSString *defaultsIdentifier;
NSString *postNotification;
NSString *key;
NSUserDefaults *userDefaults;

@implementation AppearanceTypeStackView

- (AppearanceTypeStackView *)initWithType:(int)type forController:(AppearanceSelectionTableCell *)controller withImage:(UIImage *)image andText:(NSString *)text {
    self = [super init];
    if (self) {
        self.hostController = controller;
        self.captionLabel = [[UILabel alloc] init];
        self.checkmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.checkmarkButton.frame = CGRectMake(0, 0, 22, 22);

        self.feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
        [self.feedbackGenerator prepare];

        self.iconImage = image;
        self.captionLabel.text = text;

        int appearanceStyle = [[userDefaults objectForKey:key] intValue];
        self.type = type;

        self.checkmarkButton.selected = appearanceStyle == self.type;
        
        [self.checkmarkButton setImage:[[UIImage kitImageNamed:@"UIRemoveControlMultiNotCheckedImage.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.checkmarkButton setImage:[[UIImage kitImageNamed:@"UITintedCircularButtonCheckmark.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];

        self.iconView = [[UIImageView alloc] initWithImage:self.iconImage];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.iconView.heightAnchor constraintEqualToConstant:85].active = true;

        [self.captionLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
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
        self.contentStackview.spacing = 5;

        [self.contentStackview addArrangedSubview:self.iconView];
        [self.contentStackview addArrangedSubview:self.captionLabel];
        [self.contentStackview addArrangedSubview:self.checkmarkButton];

        self.contentStackview.translatesAutoresizingMaskIntoConstraints = false;
        self.translatesAutoresizingMaskIntoConstraints = false;

        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped)];
        self.tapGestureRecognizer.numberOfTapsRequired = 1;

        [self addSubview:self.contentStackview];
        [self.contentStackview setUserInteractionEnabled:YES];
        [self.contentStackview addGestureRecognizer:self.tapGestureRecognizer];

        [self.widthAnchor constraintEqualToConstant:85].active = true;
        [self.iconView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = true;
        [self.heightAnchor constraintEqualToConstant:140].active = true;
    }

    return self;
}

- (void)buttonTapped {
    [self.feedbackGenerator impactOccurred];

    [userDefaults setObject:[NSNumber numberWithInt:self.type] forKey:key];
    [userDefaults synchronize];

    if(postNotification) {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)postNotification, NULL, NULL, YES);
    }

    [self.hostController updateForType:self.type];
}

@end

@implementation AppearanceSelectionTableCell

- (AppearanceSelectionTableCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self) {
        self.options = specifier.properties[@"options"];
        defaultsIdentifier = specifier.properties[@"defaults"];
        postNotification = specifier.properties[@"PostNotification"];
        key = specifier.properties[@"key"];
        
        userDefaults = [[NSUserDefaults alloc] initWithSuiteName:defaultsIdentifier];
        [userDefaults registerDefaults:@{ key : @0 }];

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
                                                                                  andText:option[@"text"]];
            [self.containerStackView addArrangedSubview:stackView];
        }

        [self.contentView addSubview:self.containerStackView];

        [self.containerStackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = true;
        [self.containerStackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = true;
        [self.heightAnchor constraintEqualToConstant:160].active = true;
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
    }
}

@end