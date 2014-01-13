//
//  RWLOOK.m
//  Red Event App
//
//  Created by Thorbjørn Steen on 9/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import "RWLOOK.h"

@implementation RWLOOK

+ (NSString *)APPEARANCEFILENAME {return @"appearance.xml";}

//Color Constants
+ (NSString *)INVISIBLE {return @"invisible";}

//Gui Constants
+ (NSString *)SCROLLBOUNCES {return @"scrollbounces";}

//Style Constants
+ (NSString *)TYPEFACE_BOLD {return @"bold";}
+ (NSString *)TYPEFACE_BOLD_ITALIC {return @"bold_italic";}
+ (NSString *)TYPEFACE_ITALIC {return @"italic";}
+ (NSString *)TYPEFACE_NORMAL {return @"normal";}

//Global
+ (NSString *)BACKBUTTONBACKGROUNDCOLOR {return @"backbuttoncolor";}
+ (NSString *)BACKBUTTONBACKGROUNDIMAGE {return @"backbuttonimage";}
+ (NSString *)BACKBUTTONICON {return @"backbuttonicon";}
+ (NSString *)BACKBUTTONTEXTCOLOR {return @"backbuttontextcolor";}
+ (NSString *)BACKBUTTONTEXTSHADOWCOLOR {return @"backbuttontextshadowcolor";}
+ (NSString *)BACKBUTTONTEXTSHADOWOFFSET {return @"backbuttontextshadowoffset";}
+ (NSString *)BACKBUTTONTEXTSIZE {return @"backbuttontextsize";}
+ (NSString *)BACKBUTTONTEXTSTYLE {return @"backbuttontextstyle";}
+ (NSString *)BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)BACKGROUNDIMAGE {return @"backgroundimage";}
+ (NSString *)BUTTONBACKGROUNDCOLOR {return @"buttoncolor";}
+ (NSString *)BUTTONBACKGROUNDIMAGE {return @"buttonimage";}
+ (NSString *)BUTTONICON {return @"buttonicon";}
+ (NSString *)BUTTONTEXTCOLOR {return @"buttontextcolor";}
+ (NSString *)BUTTONTEXTSHADOWCOLOR {return @"buttontextshadowcolor";}
+ (NSString *)BUTTONTEXTSHADOWOFFSET {return @"buttontextshadowoffset";}
+ (NSString *)BUTTONTEXTSIZE {return @"buttontextsize";}
+ (NSString *)BUTTONTEXTSTYLE {return @"buttontextstyle";}
+ (NSString *)CELLBACKGROUNDCOLOR {return @"cellbackgroundcolor";}
+ (NSString *)ITEMTITLECOLOR {return @"itemtitlecolor";}
+ (NSString *)ITEMTITLESHADOWCOLOR {return @"itemtitleshadowcolor";}
+ (NSString *)ITEMTITLESHADOWOFFSET {return @"itemtitleshadowoffset";}
+ (NSString *)ITEMTITLESIZE {return @"itemtitlesize";}
+ (NSString *)ITEMTITLESTYLE {return @"itemtitlestyle";}
+ (NSString *)TEXTCOLOR {return @"textcolor";}
+ (NSString *)TEXTSHADOWCOLOR {return @"textshadowcolor";}
+ (NSString *)TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)TEXTSIZE {return @"textsize";}
+ (NSString *)TEXTSTYLE {return @"textstyle";}
+ (NSString *)TITLECOLOR {return @"titlecolor";}
+ (NSString *)TITLESHADOWCOLOR {return @"titleshadowcolor";}
+ (NSString *)TITLESHADOWOFFSET {return @"titleshadowoffset";}
+ (NSString *)TITLESIZE {return @"titlesize";}
+ (NSString *)TITLESTYLE {return @"titlestyle";}

//Default
+ (NSString *)DEFAULT {return @"default";}
+ (NSString *)DEFAULT_ALTCOLOR {return @"altcolor";}
+ (NSString *)DEFAULT_ALTTEXTCOLOR {return @"alttextcolor";}
+ (NSString *)DEFAULT_ALTTEXTSHADOWCOLOR {return @"alttextshadowcolor";}
+ (NSString *)DEFAULT_BACKCOLOR {return @"backcolor";}
+ (NSString *)DEFAULT_BACKTEXTCOLOR {return @"backtextcolor";}
+ (NSString *)DEFAULT_BACKTEXTSHADOWCOLOR {return @"backtextshadowcolor";}
+ (NSString *)DEFAULT_BARCOLOR {return @"barcolor";}
+ (NSString *)DEFAULT_BARTEXTCOLOR {return @"bartextcolor";}
+ (NSString *)DEFAULT_BARTEXTSHADOWCOLOR {return @"bartextshadowcolor";}
+ (NSString *)DEFAULT_ITEMTITLESHADOWOFFSET {return @"itemtitleshadowoffset";}
+ (NSString *)DEFAULT_ITEMTITLESIZE {return @"itemtitlesize";}
+ (NSString *)DEFAULT_ITEMTITLESTYLE {return @"itemtitlestyle";}
+ (NSString *)DEFAULT_TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)DEFAULT_TEXTSIZE {return @"textsize";}
+ (NSString *)DEFAULT_TEXTSTYLE {return @"textstyle";}
+ (NSString *)DEFAULT_TITLESHADOWOFFSET {return @"titleshadowoffset";}
+ (NSString *)DEFAULT_TITLESIZE {return @"titlesize";}
+ (NSString *)DEFAULT_TITLESTYLE {return @"titlestyle";}

//Navigationbar
+ (NSString *)NAVIGATIONBAR {return @"navigationbar";}
+ (NSString *)NAVBAR_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)NAVBAR_BACKGROUNDIMAGE {return @"backgroundimage";}
+ (NSString *)NAVBAR_HASTITLE {return @"hastitle";}
+ (NSString *)NAVBAR_HOMEBUTTONBACKIMAGE {return @"homebuttonbackimage";}
+ (NSString *)NAVBAR_HOMEBUTTONCOLOR {return @"homebuttoncolor";}
+ (NSString *)NAVBAR_HOMEBUTTONIMAGE {return @"homebuttonimage";}
+ (NSString *)NAVBAR_HOMEBUTTONTEXTCOLOR {return @"homebuttontextcolor";}
+ (NSString *)NAVBAR_HOMEBUTTONTEXTSHADOWCOLOR {return @"homebuttontextshadowcolor";}
+ (NSString *)NAVBAR_HOMEBUTTONTEXTSHADOWOFFSET {return @"homebuttontextshadowoffset";}
+ (NSString *)NAVBAR_HOMEBUTTONTEXTSIZE {return @"homebuttontextsize";}
+ (NSString *)NAVBAR_HOMEBUTTONTEXTSTYLE {return @"homebuttontextstyle";}
+ (NSString *)NAVBAR_TITLECOLOR {return @"titlecolor";}
+ (NSString *)NAVBAR_TITLESIZE {return @"titlesize";}
+ (NSString *)NAVBAR_TITLESTYLE {return @"titlestyle";}
+ (NSString *)NAVBAR_TITLESHADOWCOLOR {return @"titleshadowcolor";}
+ (NSString *)NAVBAR_TITLESHADOWOFFSET {return @"titleshadowoffset";}
+ (NSString *)NAVBAR_UPBUTTONBACKIMAGE {return @"upbuttonbackimage";}
+ (NSString *)NAVBAR_UPBUTTONCOLOR {return @ "upbuttoncolor";}
+ (NSString *)NAVBAR_UPBUTTONIMAGE {return @ "upbuttonimage";}
+ (NSString *)NAVBAR_UPBUTTONTEXTCOLOR {return @ "upbuttontextcolor";}
+ (NSString *)NAVBAR_UPBUTTONTEXTSHADOWCOLOR {return @ "upbuttontextshadowcolor";}
+ (NSString *)NAVBAR_UPBUTTONTEXTSHADOWOFFSET {return @ "upbuttontextshadowoffset";}
+ (NSString *)NAVBAR_UPBUTTONTEXTSIZE {return @ "upbuttontextsize";}
+ (NSString *)NAVBAR_UPBUTTONTEXTSTYLE {return @ "upbuttontextstyle";}
+ (NSString *)NAVBAR_VISIBLE {return @"visible";}

//Tabbar
+ (NSString *)TABBAR {return @"tabbar";}
+ (NSString *)TABBAR_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)TABBAR_BACKGROUNDIMAGE {return @"backgroundimage";}
+ (NSString *)TABBAR_TEXTCOLOR {return @"textcolor";}
+ (NSString *)TABBAR_TEXTSHADOWCOLOR {return @"textshadowcolor";}
+ (NSString *)TABBAR_TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)TABBAR_TEXTSIZE {return @"textsize";}
+ (NSString *)TABBAR_TEXTSTYLE {return @"textstyle";}
+ (NSString *)TABBAR_VISIBLE {return @"visible";}

//ButtonGallery
+ (NSString *)BUTTONGALLERY_BUTTON1BACKGROUNDIMAGE{return @"button1image";}
+ (NSString *)BUTTONGALLERY_BUTTON1ICON{return @"button1icon";}
+ (NSString *)BUTTONGALLERY_BUTTON2BACKGROUNDIMAGE{return @"button2image";}
+ (NSString *)BUTTONGALLERY_BUTTON2ICON{return @"button2icon";}
+ (NSString *)BUTTONGALLERY_BUTTON3BACKGROUNDIMAGE{return @"button3image";}
+ (NSString *)BUTTONGALLERY_BUTTON3ICON{return @"button3icon";}
+ (NSString *)BUTTONGALLERY_BUTTON4BACKGROUNDIMAGE{return @"button4image";}
+ (NSString *)BUTTONGALLERY_BUTTON4ICON{return @"button4icon";}
+ (NSString *)BUTTONGALLERY_BUTTON5BACKGROUNDIMAGE{return @"button5image";}
+ (NSString *)BUTTONGALLERY_BUTTON5ICON{return @"button5icon";}
+ (NSString *)BUTTONGALLERY_BUTTON6BACKGROUNDIMAGE{return @"button6image";}
+ (NSString *)BUTTONGALLERY_BUTTON6ICON{return @"button6icon";}
+ (NSString *)BUTTONGALLERY_BUTTON7BACKGROUNDIMAGE{return @"button7image";}
+ (NSString *)BUTTONGALLERY_BUTTON7ICON{return @"button7icon";}
+ (NSString *)BUTTONGALLERY_BUTTON8BACKGROUNDIMAGE{return @"button8image";}
+ (NSString *)BUTTONGALLERY_BUTTON8ICON{return @"button8icon";}

//DailySessionList
+ (NSString *)DAILYSESSIONLIST_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)DAILYSESSIONLIST_LEFTARROW {return @"leftarrow";}
+ (NSString *)DAILYSESSIONLIST_RIGHTARROW {return @"rightarrow";}
+ (NSString *)DAILYSESSIONLIST_DATETEXTCOLOR {return @"datetextcolor";}
+ (NSString *)DAILYSESSIONLIST_DATETEXTSHADOWCOLOR {return @"datetextshadowcolor";}
+ (NSString *)DAILYSESSIONLIST_DATETEXTSHADOWOFFSET {return @"datetextshadowoffset";}
+ (NSString *)DAILYSESSIONLIST_DATETEXTSIZE {return @"datetextsize";}
+ (NSString *)DAILYSESSIONLIST_DATETEXTSTYLE {return @"datetextstyle";}
+ (NSString *)DAILYSESSIONLIST_DATEUNDERLINECOLOR {return @"dateunderlinecolor";}

//PushMessageDetail
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTSHADOWCOLOR {return @"authortextshadowcolor";}
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTSHADOWOFFSET {return @"authortextshadowoffset";}
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTCOLOR {return @"authortextcolor";}
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTSIZE {return @"authortextsize";}
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTSTYLE {return @"authortextstyle";}
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTSHADOWCOLOR {return @"senttextshadowcolor";}
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTSHADOWOFFSET {return @"senttextshadowoffset";}
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTCOLOR {return @"senttextcolor";}
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTSIZE {return @"senttextsize";}
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTSTYLE {return @"senttextstyle";}

//SessionDetail
+ (NSString *)SESSIONDETAIL_LABELCOLOR {return @"labelcolor";}
+ (NSString *)SESSIONDETAIL_LABELSHADOWCOLOR {return @"labelshadowcolor";}
+ (NSString *)SESSIONDETAIL_LABELSHADOWOFFSET {return @"labelshadowoffset";}
+ (NSString *)SESSIONDETAIL_LABELSIZE {return @"labelsize";}
+ (NSString *)SESSIONDETAIL_LABELSTYLE {return @"labelstyle";}

+ (NSString *)SWIPEVIEW_SELECTEDPAGECOLOR {return @"selectedpagecolor";}
+ (NSString *)SWIPEVIEW_UNSELECTEDPAGECOLOR {return @"unselectedpagecolor";}

//VenueDetail
+ (NSString *)VENUEDETAIL_LABELCOLOR {return @"labelcolor";}
+ (NSString *)VENUEDETAIL_LABELSHADOWCOLOR {return @"labelshadowcolor";}
+ (NSString *)VENUEDETAIL_LABELSHADOWOFFSET {return @"labelshadowoffset";}
+ (NSString *)VENUEDETAIL_LABELSIZE {return @"labelsize";}
+ (NSString *)VENUEDETAIL_LABELSTYLE {return @"labelstyle";}

@end
