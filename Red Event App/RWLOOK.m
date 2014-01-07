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

//Maps
+ (NSString *)MAPVIEW_BACKBUTTONBACKGROUNDCOLOR {return @"backbuttoncolor";}
+ (NSString *)MAPVIEW_BACKBUTTONBACKGROUNDIMAGE {return @"backbuttonimage";}
+ (NSString *)MAPVIEW_BACKBUTTONICON {return @"backbuttonicon";}
+ (NSString *)MAPVIEW_BACKBUTTONTEXTCOLOR {return @"backbuttontextcolor";}
+ (NSString *)MAPVIEW_BACKBUTTONTEXTSHADOWCOLOR {return @"backbuttontextshadowcolor";}
+ (NSString *)MAPVIEW_BACKBUTTONTEXTSHADOWOFFSET {return @"backbuttontextshadowoffset";}
+ (NSString *)MAPVIEW_BACKBUTTONTEXTSIZE {return @"backbuttontextsize";}
+ (NSString *)MAPVIEW_BACKBUTTONTEXTSTYLE {return @"backbuttontextstyle";}
+ (NSString *)MAPVIEW_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)MAPVIEW_BACKGROUNDIMAGE {return @"backgroundimage";}

//AdventCal
+ (NSString *)ADVENTCAL_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)ADVENTCAL_BACKGROUNDIMAGE {return @"backgroundimage";}

//AdventWindow
+ (NSString *)ADVENTWINDOW_BACKBUTTONBACKGROUNDCOLOR {return @"backbuttoncolor";}
+ (NSString *)ADVENTWINDOW_BACKBUTTONBACKGROUNDIMAGE {return @"backbuttonimage";}
+ (NSString *)ADVENTWINDOW_BACKBUTTONICON {return @"backbuttonicon";}
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTCOLOR {return @"backbuttontextcolor";}
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTSHADOWCOLOR {return @"backbuttontextshadowcolor";}
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTSHADOWOFFSET {return @"backbuttontextshadowoffset";}
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTSIZE {return @"backbuttontextsize";}
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTSTYLE {return @"backbuttontextstyle";}
+ (NSString *)ADVENTWINDOW_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)ADVENTWINDOW_BACKGROUNDIMAGE {return @"backgroundimage";}
+ (NSString *)ADVENTWINDOW_TEXTBACKGROUNDCOLOR {return @"textbackgroundcolor";}
+ (NSString *)ADVENTWINDOW_TEXTBACKGROUNDIMAGE {return @"textbackgroundimage";}
+ (NSString *)ADVENTWINDOW_TEXTCOLOR {return @"textcolor";}
+ (NSString *)ADVENTWINDOW_TEXTSHADOWCOLOR {return @"textshadowcolor";}
+ (NSString *)ADVENTWINDOW_TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)ADVENTWINDOW_TEXTSIZE {return @"textsize";}
+ (NSString *)ADVENTWINDOW_TEXTSTYLE {return @"textstyle";}
+ (NSString *)ADVENTWINDOW_TITLECOLOR {return @"titlecolor";}
+ (NSString *)ADVENTWINDOW_TITLESHADOWCOLOR {return @"titleshadowcolor";}
+ (NSString *)ADVENTWINDOW_TITLESHADOWOFFSET {return @"titleshadowoffset";}
+ (NSString *)ADVENTWINDOW_TITLESHADOWRADIUS {return @"titleshadowradius";}
+ (NSString *)ADVENTWINDOW_TITLESIZE {return @"titlesize";}
+ (NSString *)ADVENTWINDOW_TITLESTYLE {return @"titlestyle";}

//ArticleDetail
+ (NSString *)ARTICLEDETAIL_BACKBUTTONBACKGROUNDCOLOR {return @"backbuttoncolor";}
+ (NSString *)ARTICLEDETAIL_BACKBUTTONBACKGROUNDIMAGE {return @"backbuttonimage";}
+ (NSString *)ARTICLEDETAIL_BACKBUTTONICON {return @"backbuttonicon";}
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTCOLOR {return @"backbuttontextcolor";}
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTSHADOWCOLOR {return @"backbuttontextshadowcolor";}
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTSHADOWOFFSET {return @"backbuttontextshadowoffset";}
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTSIZE {return @"backbuttontextsize";}
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTSTYLE {return @"backbuttontextstyle";}
+ (NSString *)ARTICLEDETAIL_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)ARTICLEDETAIL_TEXTCOLOR {return @"textcolor";}
+ (NSString *)ARTICLEDETAIL_TEXTSHADOWCOLOR {return @"textshadowcolor";}
+ (NSString *)ARTICLEDETAIL_TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)ARTICLEDETAIL_TEXTSIZE {return @"textsize";}
+ (NSString *)ARTICLEDETAIL_TEXTSTYLE {return @"textstyle";}
+ (NSString *)ARTICLEDETAIL_TITLECOLOR {return @"titlecolor";}
+ (NSString *)ARTICLEDETAIL_TITLESHADOWCOLOR {return @"titleshadowcolor";}
+ (NSString *)ARTICLEDETAIL_TITLESHADOWOFFSET {return @"titleshadowoffset";}
+ (NSString *)ARTICLEDETAIL_TITLESIZE {return @"titlesize";}
+ (NSString *)ARTICLEDETAIL_TITLESTYLE {return @"titlestyle";}

//ButtonGallery
+ (NSString *)BUTTONGALLERY_BUTTONBACKGROUNDCOLOR{return @"buttonbackgroundcolor";}
+ (NSString *)BUTTONGALLERY_BUTTONBACKGROUNDIMAGE{return @"buttonbackgroundimage";}
+ (NSString *)BUTTONGALLERY_BUTTONICON{return @"buttonicon";}
+ (NSString *)BUTTONGALLERY_BUTTONTEXTCOLOR{return @"buttontextcolor";}
+ (NSString *)BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR{return @"buttontextshadowcolor";}
+ (NSString *)BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET{return @"buttontextshadowoffset";}
+ (NSString *)BUTTONGALLERY_BUTTONTEXTSIZE{return @"buttontextsize";}
+ (NSString *)BUTTONGALLERY_BUTTONTEXTSTYLE{return @"buttontextstyle";}
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
+ (NSString *)DAILYSESSIONLIST_TEXTCOLOR {return @"textcolor";}
+ (NSString *)DAILYSESSIONLIST_TEXTSHADOWCOLOR {return @"textshadowcolor";}
+ (NSString *)DAILYSESSIONLIST_TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)DAILYSESSIONLIST_TEXTSIZE {return @"textsize";}
+ (NSString *)DAILYSESSIONLIST_TEXTSTYLE {return @"textstyle";}

//ImageArticleList
+ (NSString *)IMAGEARTICLELIST_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)IMAGEARTICLELIST_BACKGROUNDIMAGE {return @"backgroundimage";}
+ (NSString *)IMAGEARTICLELIST_CELLBACKGROUNDCOLOR {return @"cellbackgroundcolor";}
+ (NSString *)IMAGEARTICLELIST_ITEMTITLECOLOR {return @"articletitlecolor";}
+ (NSString *)IMAGEARTICLELIST_ITEMTITLESHADOWCOLOR {return @"articletitleshadowcolor";}
+ (NSString *)IMAGEARTICLELIST_ITEMTITLESHADOWOFFSET {return @"articletitleshadowoffset";}
+ (NSString *)IMAGEARTICLELIST_ITEMTITLESIZE {return @"articletitlesize";}
+ (NSString *)IMAGEARTICLELIST_ITEMTITLESTYLE {return @"articletitlestyle";}
+ (NSString *)IMAGEARTICLELIST_TEXTCOLOR {return @"textcolor";}
+ (NSString *)IMAGEARTICLELIST_TEXTSHADOWCOLOR {return @"textshadowcolor";}
+ (NSString *)IMAGEARTICLELIST_TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)IMAGEARTICLELIST_TEXTSIZE {return @"textsize";}
+ (NSString *)IMAGEARTICLELIST_TEXTSTYLE {return @"textstyle";}

//NewsTicker
+ (NSString *)NEWSTICKER_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)NEWSTICKER_ITEMTITLECOLOR {return @"articletitlecolor";}
+ (NSString *)NEWSTICKER_ITEMTITLESHADOWCOLOR {return @"articletitleshadowcolor";}
+ (NSString *)NEWSTICKER_ITEMTITLESHADOWOFFSET {return @"articletitleshadowoffset";}
+ (NSString *)NEWSTICKER_ITEMTITLESIZE {return @"articletitlesize";}
+ (NSString *)NEWSTICKER_ITEMTITLESTYLE {return @"articletitlestyle";}
+ (NSString *)NEWSTICKER_TEXTSHADOWCOLOR {return @"articletextshadowcolor";}
+ (NSString *)NEWSTICKER_TEXTSHADOWOFFSET {return @"articletextshadowoffset";}
+ (NSString *)NEWSTICKER_TEXTCOLOR {return @"articletextcolor";}
+ (NSString *)NEWSTICKER_TEXTSIZE {return @"articletextsize";}
+ (NSString *)NEWSTICKER_TEXTSTYLE {return @"articletextstyle";}
+ (NSString *)NEWSTICKER_TITLECOLOR {return @"titlecolor";}
+ (NSString *)NEWSTICKER_TITLESHADOWCOLOR {return @"titleshadowcolor";}
+ (NSString *)NEWSTICKER_TITLESHADOWOFFSET {return @"titleshadowoffset";}
+ (NSString *)NEWSTICKER_TITLESIZE {return @"titlesize";}
+ (NSString *)NEWSTICKER_TITLESTYLE {return @"titlestyle";}

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
+ (NSString *)SESSIONDETAIL_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)SESSIONDETAIL_BUTTONCOLOR {return @"buttoncolor";}
+ (NSString *)SESSIONDETAIL_BUTTONICON {return @"buttonicon";}
+ (NSString *)SESSIONDETAIL_BUTTONTEXTCOLOR {return @"buttontextcolor";}
+ (NSString *)SESSIONDETAIL_BUTTONTEXTSHADOWCOLOR {return @"buttontextshadowcolor";}
+ (NSString *)SESSIONDETAIL_BUTTONTEXTSHADOWOFFSET {return @"buttontextshadowoffset";}
+ (NSString *)SESSIONDETAIL_BUTTONTEXTSIZE {return @"buttontextsize";}
+ (NSString *)SESSIONDETAIL_BUTTONTEXTSTYLE {return @"buttontextstyle";}
+ (NSString *)SESSIONDETAIL_LABELCOLOR {return @"labelcolor";}
+ (NSString *)SESSIONDETAIL_LABELSHADOWCOLOR {return @"labelshadowcolor";}
+ (NSString *)SESSIONDETAIL_LABELSHADOWOFFSET {return @"labelshadowoffset";}
+ (NSString *)SESSIONDETAIL_LABELSIZE {return @"labelsize";}
+ (NSString *)SESSIONDETAIL_LABELSTYLE {return @"labelstyle";}
+ (NSString *)SESSIONDETAIL_TEXTCOLOR {return @"textcolor";}
+ (NSString *)SESSIONDETAIL_TEXTSHADOWCOLOR {return @"textshadowcolor";}
+ (NSString *)SESSIONDETAIL_TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)SESSIONDETAIL_TEXTSIZE {return @"textsize";}
+ (NSString *)SESSIONDETAIL_TEXTSTYLE {return @"textstyle";}
+ (NSString *)SESSIONDETAIL_TITLECOLOR {return @"titlecolor";}
+ (NSString *)SESSIONDETAIL_TITLESHADOWCOLOR {return @"titleshadowcolor";}
+ (NSString *)SESSIONDETAIL_TITLESHADOWOFFSET {return @"titleshadowoffset";}
+ (NSString *)SESSIONDETAIL_TITLESIZE {return @"titlesize";}
+ (NSString *)SESSIONDETAIL_TITLESTYLE {return @"titlestyle";}

//StaticArticle
+ (NSString *)STATICARTICLE_BACKGROUNDCOLOR {return @"backgroundcolor";}

//SwipeView
+ (NSString *)SWIPEVIEW_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)SWIPEVIEW_BACKGROUNDIMAGE {return @"backgroundimage";}
+ (NSString *)SWIPEVIEW_SELECTEDPAGECOLOR {return @"selectedpagecolor";}
+ (NSString *)SWIPEVIEW_UNSELECTEDPAGECOLOR {return @"unselectedpagecolor";}

//UpcomingSessions
+ (NSString *)UPCOMINGSESSIONS_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)UPCOMINGSESSIONS_TITLEUNDERLINECOLOR {return @"titleunderlinecolor";}
+ (NSString *)UPCOMINGSESSIONS_TEXTCOLOR {return @"textcolor";}
+ (NSString *)UPCOMINGSESSIONS_TEXTSHADOWCOLOR {return @"textshadowcolor";}
+ (NSString *)UPCOMINGSESSIONS_TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)UPCOMINGSESSIONS_TEXTSIZE {return @"textsize";}
+ (NSString *)UPCOMINGSESSIONS_TEXTSTYLE {return @"textstyle";}
+ (NSString *)UPCOMINGSESSIONS_TITLECOLOR {return @"titlecolor";}
+ (NSString *)UPCOMINGSESSIONS_TITLESHADOWCOLOR {return @"titleshadowcolor";}
+ (NSString *)UPCOMINGSESSIONS_TITLESHADOWOFFSET {return @"titleshadowoffset";}
+ (NSString *)UPCOMINGSESSIONS_TITLESIZE {return @"titlesize";}
+ (NSString *)UPCOMINGSESSIONS_TITLESTYLE {return @"titlestyle";}

//VenueDetail
+ (NSString *)VENUEDETAIL_BACKGROUNDCOLOR {return @"backgroundcolor";}
+ (NSString *)VENUEDETAIL_BACKGROUNDIMAGE {return @"backgroundimage";}
+ (NSString *)VENUEDETAIL_BUTTONCOLOR {return @"buttoncolor";}
+ (NSString *)VENUEDETAIL_BUTTONICON {return @"buttonicon";}
+ (NSString *)VENUEDETAIL_BUTTONTEXTCOLOR {return @"buttontextcolor";}
+ (NSString *)VENUEDETAIL_BUTTONTEXTSHADOWCOLOR {return @"buttontextshadowcolor";}
+ (NSString *)VENUEDETAIL_BUTTONTEXTSHADOWOFFSET {return @"buttontextshadowoffset";}
+ (NSString *)VENUEDETAIL_BUTTONTEXTSIZE {return @"buttontextsize";}
+ (NSString *)VENUEDETAIL_BUTTONTEXTSTYLE {return @"buttontextstyle";}
+ (NSString *)VENUEDETAIL_LABELCOLOR {return @"labelcolor";}
+ (NSString *)VENUEDETAIL_LABELSHADOWCOLOR {return @"labelshadowcolor";}
+ (NSString *)VENUEDETAIL_LABELSHADOWOFFSET {return @"labelshadowoffset";}
+ (NSString *)VENUEDETAIL_LABELSIZE {return @"labelsize";}
+ (NSString *)VENUEDETAIL_LABELSTYLE {return @"labelstyle";}
+ (NSString *)VENUEDETAIL_TEXTCOLOR {return @"textcolor";}
+ (NSString *)VENUEDETAIL_TEXTSHADOWCOLOR {return @"textshadowcolor";}
+ (NSString *)VENUEDETAIL_TEXTSHADOWOFFSET {return @"textshadowoffset";}
+ (NSString *)VENUEDETAIL_TEXTSIZE {return @"textsize";}
+ (NSString *)VENUEDETAIL_TEXTSTYLE {return @"textstyle";}
+ (NSString *)VENUEDETAIL_TITLECOLOR {return @"titlecolor";}
+ (NSString *)VENUEDETAIL_TITLESHADOWCOLOR {return @"titleshadowcolor";}
+ (NSString *)VENUEDETAIL_TITLESHADOWOFFSET {return @"titleshadowoffset";}
+ (NSString *)VENUEDETAIL_TITLESIZE {return @"titlesize";}
+ (NSString *)VENUEDETAIL_TITLESTYLE {return @"titlestyle";}

@end
