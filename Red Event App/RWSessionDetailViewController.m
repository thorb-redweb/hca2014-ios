//
//  RWSessionDetailViewController.m
//  Red Event App
//
//  Created by redWEB Praktik on 8/22/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <EventKit/EventKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

#import "UIScrollView+RWScrollView.h"
#import "UIView+RWViewLayout.h"
#import "UIWebView+RWWebView.h"

#import "RWSessionDetailViewController.h"

#import "RWSessionVM.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@interface RWSessionDetailViewController ()

@end

@implementation RWSessionDetailViewController {
    RWSessionVM *_model;
    EKEventStore *_store;
}


- (id)initWithPage:(RWXmlNode *)page {
    self = [super initWithNibName:@"RWSessionDetailViewController" bundle:nil page:page];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
    int sessionId = [_page getIntegerFromNode:[RWPAGE SESSIONID]];
    _model = [_db.Sessions getVMFromId:sessionId];
    _store = [[EKEventStore alloc] init];
	
	[self setAppearance];
	[self setText];

    _lblTitle.text = _model.title;
    _lblTypeText.text = _model.type;
	_lblTypeText.textColor = _model.typeColor;
    _lblDateText.text = [NSString stringWithFormat:@"%@", _model.startDateLong];
    _lblPlaceText.text = [NSString stringWithFormat:@"%@", _model.venue];
    _lblTimeText.text = [NSString stringWithFormat:@"%@ - %@", _model.startTime, _model.endTime];

    if([_page hasChild:[RWPAGE BODYUSESHTML]] && [_page getBoolFromNode:[RWPAGE BODYUSESHTML]])
    {
        [_lblBody setHidden:YES];
        [_webBody loadHTMLString:_model.detailsWithHtml baseURL:nil];
    } else {
        [_webBody setHidden:YES];
		NSString *details = _model.details;
        _lblBody.text = details;
    }

    if(!([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] ||
            [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter] ||
            [MFMessageComposeViewController canSendText])) {
        _btnShare.hidden = YES;
    }

    NSString *urlRegex = @"\\(?\\bhttp://[-A-Za-z0-9+&@#/%?=~_()|!:,.;]*[-A-Za-z0-9+&@#/%=~_()|]";
	NSPredicate *isAnUrlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];

	if (![isAnUrlTest evaluateWithObject:_model.submissionPath]) {
		[_btnTicket setHidden: YES];
		[_btnTicket setEnabled: YES];
		[_btnTicket RWsetHeightAsConstraint:0.0];
	}

    if ([_model.imagePath length] != 0) {
        if (_model.image != NULL) {
            _imgView.image = _model.image;
        }
        else {
			[_imgView sd_setImageWithURL:_model.imageUrl placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]
							completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *url) {
                                if(image != nil) {
                                    float imageHeight = image.size.height;
                                    float aspectHeight = imageHeight * _imgView.frame.size.width / image.size.width;
                                    [_imgView RWsetHeightAsConstraint:aspectHeight];
                                }
                            }];
        }
    }
	
	if(![_page hasChild:[RWPAGE RETURNBUTTON]] ||
	   ([_page hasChild:[RWPAGE RETURNBUTTON]] && ![_page getBoolFromNode:[RWPAGE RETURNBUTTON]])){
		[_btnBack RWsetHeightAsConstraint:0.0];
	}

    NSArray *prices = [_model prices];
    if(prices){
        UILabel *lastCell;
        for(NSDictionary *priceObject in prices){
            NSString *type = priceObject[@"pricetype"];
            NSString *price = priceObject[@"price"];

            UILabel *lblPrice = [UILabel new];
            [lblPrice setTranslatesAutoresizingMaskIntoConstraints:NO];
            [lblPrice setText:[NSString stringWithFormat:@"%@ %@", type, price]];
            [lblPrice setFont:[UIFont boldSystemFontOfSize:14.0f]];
            [lblPrice setTextColor:[UIColor blackColor]];
            [lblPrice setContentHuggingPriority:500.0f forAxis:UILayoutConstraintAxisVertical];
            [_vwPricesContainer addSubview:lblPrice];

            if(!lastCell){
                [_vwPricesContainer RWpinChildToTop:lblPrice];
            }
            else {
                //Attach lblPrice to bottom of last cell
                [_vwPricesContainer RWpinChildrenTogetherWithTopChild:lastCell BottomChild:lblPrice constant:4.0f];
            }
            [_vwPricesContainer.superview RWalignChildrenLeadingSideWithView:_lblDateText view:lblPrice];
            [_vwPricesContainer RWpinChildToTrailing:lblPrice];
            lastCell = lblPrice;
        }
        //Attach lastCell to bottom of vwPricesContainer (actual last cell)
        [_vwPricesContainer RWpinChildToBottom:lastCell];
    }
    else {
        UILabel *lblPrice = [UILabel new];
        [lblPrice setTranslatesAutoresizingMaskIntoConstraints:NO];
        [lblPrice setText:@"Gratis"];
        [lblPrice setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [lblPrice setTextColor:[UIColor blackColor]];
        [lblPrice setContentHuggingPriority:500.0f forAxis:UILayoutConstraintAxisVertical];
        [_vwPricesContainer addSubview:lblPrice];

        [_vwPricesContainer RWpinChildToTop:lblPrice];
        [_vwPricesContainer.superview RWalignChildrenLeadingSideWithView:_lblDateText view:lblPrice];
        [_vwPricesContainer RWpinChildToTrailing:lblPrice];
        [_vwPricesContainer RWpinChildToBottom:lblPrice];
    }
}

- (void)setAppearance{
    RWAppearanceHelper *helper = [[RWAppearanceHelper alloc] initWithLocalLook:_localLook globalLook:_globalLook];

    [helper setBackgroundColor:self.view localName:[RWLOOK BACKGROUNDCOLOR] globalName:[RWLOOK DEFAULT_BACKCOLOR]];

    [helper.label setTitleStyle:_lblTitle];

    [self.btnShare addTarget:self action:@selector(shareToSocialMedia:) forControlEvents:UIControlEventTouchUpInside];
    self.btnShare.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.btnShare setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    UIImage *image = [self.btnShare.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.btnShare setImage:image forState:UIControlStateNormal];
    self.btnShare.tintColor = [UIColor whiteColor];

    [helper.label setBackTextStyle:_lblBody];

    [helper.button setBackButtonStyle:_btnBack];
	
	[helper setScrollBounces:_scrollView localName:[RWLOOK SCROLLBOUNCES] globalName:[RWLOOK SCROLLBOUNCES]];

    [_store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
        if (!granted) {
            [_btnCalendar setEnabled:NO];
            [_cnstBtnCalendarWidth setConstant:8];
            [_vwBtnCalendar setHidden:YES];
        }
    }];
}

- (void)setText{
	RWTextHelper *helper = [[RWTextHelper alloc] initWithPageName:_name xmlStore:_xml];
	
	[helper setText:_lblDate textName:[RWTEXT SESSIONDETAIL_DATE] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_DATE]];
	[helper setText:_lblPlace textName:[RWTEXT SESSIONDETAIL_PLACE] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_PLACE]];
	[helper setText:_lblTime textName:[RWTEXT SESSIONDETAIL_TIME] defaultText:[RWDEFAULTTEXT SESSIONDETAIL_TIME]];
	
	BOOL backButtonHasBackgroundImage = [_xml.appearance hasChild:_name] && [[_xml getAppearanceForPage:_name] hasChild:[RWLOOK BACKBUTTONBACKGROUNDIMAGE]];
	if(!backButtonHasBackgroundImage){
		[helper setButtonText:_btnBack textName:[RWTEXT MAPVIEW_BACKBUTTON] defaultText:[RWDEFAULTTEXT MAPVIEW_BACKBUTTON]];
	}
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_lblTime sizeToFit];

    [webView RWSizeThatFitsContent];
    [_scrollView RWContentSizeToFit];
}

- (IBAction)shareToSocialMedia:(id)sender {
    NSMutableArray *availableServices = [[NSMutableArray alloc] init];
    [availableServices addObject:@"Facebook"];
    [availableServices addObject:@"Twitter"];
//    if([MFMessageComposeViewController canSendText]){
//        [availableServices addObject:@"SMS"];
//    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for(NSString *buttonTitle in availableServices){
        [actionSheet addButtonWithTitle:buttonTitle];
    }
    [actionSheet showInView:self.view.window];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqual:@"Facebook"]) {
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [tweetSheet setInitialText:_model.websitelink];
            [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else if ([buttonTitle isEqual:@"Twitter"]) {
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:_model.websitelink];
            [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else if([buttonTitle isEqual:@"SMS"]) {
        if([MFMessageComposeViewController canSendText]) {
            controller.messageComposeDelegate = self;
            controller.body = _model.websitelink;

            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];

    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else
        NSLog(@"Message failed");
}

- (IBAction)btnMapPressed:(id)sender {
    RWXmlNode *nextPage = [[_xml getPage:_childname] deepClone];
    [nextPage addNodeWithName:[RWPAGE SESSIONID] value:_model.sessionid];

    [_app.navController pushViewWithPage:nextPage];
}

- (IBAction)btnTicketPressed:(id)sender{
	NSURL *submissionUrl = [NSURL URLWithString:_model.submissionPath];
	if (![[UIApplication sharedApplication] openURL:submissionUrl]) {
		NSLog(@"Failed to open url: %@", [submissionUrl description]);
	}
}

- (IBAction)btnCalendarPressed:(id)sender {
	[self startActivityIndicatorWithTitle:@"Tilføjer event til kalender" message:@"Tilføjer..."];
	[_store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
        if(!granted){
			[self hideActivityIndicator];
			return;
		}
        EKEvent *event = [EKEvent eventWithEventStore:_store];
        event.title = _model.title;
        event.startDate = _model.startDatetime;
        event.endDate = _model.endDatetime;
		event.location = _model.venue;
        [event setCalendar:[_store defaultCalendarForNewEvents]];
        NSError *err = nil;
        [_store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
		NSString *alertMessage = [NSString stringWithFormat:@"\"%@\" er blevet tilføjet til din kalender", event.title];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tilføjet til kalender" message:alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[self hideActivityIndicator];
    }];
}


-(IBAction)btnBackClicked{
	NSArray *constraints = self.view.constraints;
	constraints = [[NSArray alloc] init];
	
	UIScrollView *scrollView = _scrollView;
	CGSize size = scrollView.contentSize;
	NSArray *constraints2 = scrollView.constraints;
	constraints2 = [[NSArray alloc] init];
	size = CGSizeMake(0, 0);
	
    [_app.navController popPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
