//
//  RWLOOK.h
//  Red Event App
//
//  Created by Thorbjørn Steen on 9/27/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWLOOK : NSObject

+ (NSString *)APPEARANCEFILENAME;

//Color Constants
+ (NSString *)INVISIBLE;

//Gui Constants
+ (NSString *)SCROLLBOUNCES;

//Style Constants
+ (NSString *)TYPEFACE_BOLD;
+ (NSString *)TYPEFACE_BOLD_ITALIC;
+ (NSString *)TYPEFACE_ITALIC;
+ (NSString *)TYPEFACE_NORMAL;

//Global
+ (NSString *)BACKBUTTONBACKGROUNDCOLOR;
+ (NSString *)BACKBUTTONBACKGROUNDIMAGE;
+ (NSString *)BACKBUTTONICON;
+ (NSString *)BACKBUTTONTEXTCOLOR;
+ (NSString *)BACKBUTTONTEXTSHADOWCOLOR;
+ (NSString *)BACKBUTTONTEXTSHADOWOFFSET;
+ (NSString *)BACKBUTTONTEXTSIZE;
+ (NSString *)BACKBUTTONTEXTSTYLE;
+ (NSString *)BACKGROUNDCOLOR;
+ (NSString *)BACKGROUNDIMAGE;
+ (NSString *)CELLBACKGROUNDCOLOR;
+ (NSString *)ITEMTITLECOLOR;
+ (NSString *)ITEMTITLESHADOWCOLOR;
+ (NSString *)ITEMTITLESHADOWOFFSET;
+ (NSString *)ITEMTITLESIZE;
+ (NSString *)ITEMTITLESTYLE;
+ (NSString *)TEXTCOLOR;
+ (NSString *)TEXTSHADOWCOLOR;
+ (NSString *)TEXTSHADOWOFFSET;
+ (NSString *)TEXTSIZE;
+ (NSString *)TEXTSTYLE;
+ (NSString *)TITLECOLOR;
+ (NSString *)TITLESHADOWCOLOR;
+ (NSString *)TITLESHADOWOFFSET;
+ (NSString *)TITLESIZE;
+ (NSString *)TITLESTYLE;

//Default
+ (NSString *)DEFAULT;
+ (NSString *)DEFAULT_ALTCOLOR;
+ (NSString *)DEFAULT_ALTTEXTCOLOR;
+ (NSString *)DEFAULT_ALTTEXTSHADOWCOLOR;
+ (NSString *)DEFAULT_BACKCOLOR;
+ (NSString *)DEFAULT_BACKTEXTCOLOR;
+ (NSString *)DEFAULT_BACKTEXTSHADOWCOLOR;
+ (NSString *)DEFAULT_BARCOLOR;
+ (NSString *)DEFAULT_BARTEXTCOLOR;
+ (NSString *)DEFAULT_BARTEXTSHADOWCOLOR;
+ (NSString *)DEFAULT_ITEMTITLESHADOWOFFSET;
+ (NSString *)DEFAULT_ITEMTITLESIZE;
+ (NSString *)DEFAULT_ITEMTITLESTYLE;
+ (NSString *)DEFAULT_TEXTSHADOWOFFSET;
+ (NSString *)DEFAULT_TEXTSIZE;
+ (NSString *)DEFAULT_TEXTSTYLE;
+ (NSString *)DEFAULT_TITLESHADOWOFFSET;
+ (NSString *)DEFAULT_TITLESIZE;
+ (NSString *)DEFAULT_TITLESTYLE;

//Navigationbar
+ (NSString *)NAVIGATIONBAR;
+ (NSString *)NAVBAR_BACKGROUNDCOLOR;
+ (NSString *)NAVBAR_BACKGROUNDIMAGE;
+ (NSString *)NAVBAR_HASTITLE;
+ (NSString *)NAVBAR_HOMEBUTTONBACKIMAGE;
+ (NSString *)NAVBAR_HOMEBUTTONCOLOR;
+ (NSString *)NAVBAR_HOMEBUTTONIMAGE;
+ (NSString *)NAVBAR_HOMEBUTTONTEXTCOLOR;
+ (NSString *)NAVBAR_HOMEBUTTONTEXTSHADOWCOLOR;
+ (NSString *)NAVBAR_HOMEBUTTONTEXTSHADOWOFFSET;
+ (NSString *)NAVBAR_HOMEBUTTONTEXTSIZE;
+ (NSString *)NAVBAR_HOMEBUTTONTEXTSTYLE;
+ (NSString *)NAVBAR_TITLECOLOR;
+ (NSString *)NAVBAR_TITLESIZE;
+ (NSString *)NAVBAR_TITLESTYLE;
+ (NSString *)NAVBAR_TITLESHADOWCOLOR;
+ (NSString *)NAVBAR_TITLESHADOWOFFSET;
+ (NSString *)NAVBAR_UPBUTTONBACKIMAGE;
+ (NSString *)NAVBAR_UPBUTTONCOLOR;
+ (NSString *)NAVBAR_UPBUTTONIMAGE;
+ (NSString *)NAVBAR_UPBUTTONTEXTCOLOR;
+ (NSString *)NAVBAR_UPBUTTONTEXTSHADOWCOLOR;
+ (NSString *)NAVBAR_UPBUTTONTEXTSHADOWOFFSET;
+ (NSString *)NAVBAR_UPBUTTONTEXTSIZE;
+ (NSString *)NAVBAR_UPBUTTONTEXTSTYLE;
+ (NSString *)NAVBAR_VISIBLE;

//Tabbar
+ (NSString *)TABBAR;
+ (NSString *)TABBAR_BACKGROUNDCOLOR;
+ (NSString *)TABBAR_BACKGROUNDIMAGE;
+ (NSString *)TABBAR_TEXTCOLOR;
+ (NSString *)TABBAR_TEXTSHADOWCOLOR;
+ (NSString *)TABBAR_TEXTSHADOWOFFSET;
+ (NSString *)TABBAR_TEXTSIZE;
+ (NSString *)TABBAR_TEXTSTYLE;
+ (NSString *)TABBAR_VISIBLE;

//Maps
+ (NSString *)MAPVIEW_BACKBUTTONBACKGROUNDCOLOR;
+ (NSString *)MAPVIEW_BACKBUTTONBACKGROUNDIMAGE;
+ (NSString *)MAPVIEW_BACKBUTTONICON;
+ (NSString *)MAPVIEW_BACKBUTTONTEXTCOLOR;
+ (NSString *)MAPVIEW_BACKBUTTONTEXTSHADOWCOLOR;
+ (NSString *)MAPVIEW_BACKBUTTONTEXTSHADOWOFFSET;
+ (NSString *)MAPVIEW_BACKBUTTONTEXTSIZE;
+ (NSString *)MAPVIEW_BACKBUTTONTEXTSTYLE;
+ (NSString *)MAPVIEW_BACKGROUNDCOLOR;
+ (NSString *)MAPVIEW_BACKGROUNDIMAGE;


//AdventCal
+ (NSString *)ADVENTCAL_BACKGROUNDCOLOR;
+ (NSString *)ADVENTCAL_BACKGROUNDIMAGE;

//AdventWindow
+ (NSString *)ADVENTWINDOW_BACKBUTTONBACKGROUNDCOLOR;
+ (NSString *)ADVENTWINDOW_BACKBUTTONBACKGROUNDIMAGE;
+ (NSString *)ADVENTWINDOW_BACKBUTTONICON;
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTCOLOR;
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTSHADOWCOLOR;
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTSHADOWOFFSET;
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTSIZE;
+ (NSString *)ADVENTWINDOW_BACKBUTTONTEXTSTYLE;
+ (NSString *)ADVENTWINDOW_BACKGROUNDCOLOR;
+ (NSString *)ADVENTWINDOW_BACKGROUNDIMAGE;
+ (NSString *)ADVENTWINDOW_TEXTBACKGROUNDCOLOR;
+ (NSString *)ADVENTWINDOW_TEXTBACKGROUNDIMAGE;
+ (NSString *)ADVENTWINDOW_TEXTCOLOR;
+ (NSString *)ADVENTWINDOW_TEXTSHADOWCOLOR;
+ (NSString *)ADVENTWINDOW_TEXTSHADOWOFFSET;
+ (NSString *)ADVENTWINDOW_TEXTSIZE;
+ (NSString *)ADVENTWINDOW_TEXTSTYLE;
+ (NSString *)ADVENTWINDOW_TITLECOLOR;
+ (NSString *)ADVENTWINDOW_TITLESHADOWCOLOR;
+ (NSString *)ADVENTWINDOW_TITLESHADOWOFFSET;
+ (NSString *)ADVENTWINDOW_TITLESHADOWRADIUS;
+ (NSString *)ADVENTWINDOW_TITLESIZE;
+ (NSString *)ADVENTWINDOW_TITLESTYLE;

//ArticleDetail
+ (NSString *)ARTICLEDETAIL_BACKBUTTONBACKGROUNDCOLOR;
+ (NSString *)ARTICLEDETAIL_BACKBUTTONBACKGROUNDIMAGE;
+ (NSString *)ARTICLEDETAIL_BACKBUTTONICON;
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTCOLOR;
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTSHADOWCOLOR;
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTSHADOWOFFSET;
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTSIZE;
+ (NSString *)ARTICLEDETAIL_BACKBUTTONTEXTSTYLE;
+ (NSString *)ARTICLEDETAIL_BACKGROUNDCOLOR;
+ (NSString *)ARTICLEDETAIL_TEXTCOLOR;
+ (NSString *)ARTICLEDETAIL_TEXTSHADOWCOLOR;
+ (NSString *)ARTICLEDETAIL_TEXTSHADOWOFFSET;
+ (NSString *)ARTICLEDETAIL_TEXTSIZE;
+ (NSString *)ARTICLEDETAIL_TEXTSTYLE;
+ (NSString *)ARTICLEDETAIL_TITLECOLOR;
+ (NSString *)ARTICLEDETAIL_TITLESHADOWCOLOR;
+ (NSString *)ARTICLEDETAIL_TITLESHADOWOFFSET;
+ (NSString *)ARTICLEDETAIL_TITLESIZE;
+ (NSString *)ARTICLEDETAIL_TITLESTYLE;

//ButtonGallery
+ (NSString *)BUTTONGALLERY_BUTTONBACKGROUNDCOLOR;
+ (NSString *)BUTTONGALLERY_BUTTONBACKGROUNDIMAGE;
+ (NSString *)BUTTONGALLERY_BUTTONICON;
+ (NSString *)BUTTONGALLERY_BUTTONTEXTCOLOR;
+ (NSString *)BUTTONGALLERY_BUTTONTEXTSHADOWCOLOR;
+ (NSString *)BUTTONGALLERY_BUTTONTEXTSHADOWOFFSET;
+ (NSString *)BUTTONGALLERY_BUTTONTEXTSIZE;
+ (NSString *)BUTTONGALLERY_BUTTONTEXTSTYLE;
+ (NSString *)BUTTONGALLERY_BUTTON1BACKGROUNDIMAGE;
+ (NSString *)BUTTONGALLERY_BUTTON1ICON;
+ (NSString *)BUTTONGALLERY_BUTTON2BACKGROUNDIMAGE;
+ (NSString *)BUTTONGALLERY_BUTTON2ICON;
+ (NSString *)BUTTONGALLERY_BUTTON3BACKGROUNDIMAGE;
+ (NSString *)BUTTONGALLERY_BUTTON3ICON;
+ (NSString *)BUTTONGALLERY_BUTTON4BACKGROUNDIMAGE;
+ (NSString *)BUTTONGALLERY_BUTTON4ICON;
+ (NSString *)BUTTONGALLERY_BUTTON5BACKGROUNDIMAGE;
+ (NSString *)BUTTONGALLERY_BUTTON5ICON;
+ (NSString *)BUTTONGALLERY_BUTTON6BACKGROUNDIMAGE;
+ (NSString *)BUTTONGALLERY_BUTTON6ICON;
+ (NSString *)BUTTONGALLERY_BUTTON7BACKGROUNDIMAGE;
+ (NSString *)BUTTONGALLERY_BUTTON7ICON;
+ (NSString *)BUTTONGALLERY_BUTTON8BACKGROUNDIMAGE;
+ (NSString *)BUTTONGALLERY_BUTTON8ICON;

//DailySessionList
+ (NSString *)DAILYSESSIONLIST_BACKGROUNDCOLOR;
+ (NSString *)DAILYSESSIONLIST_LEFTARROW;
+ (NSString *)DAILYSESSIONLIST_RIGHTARROW;
+ (NSString *)DAILYSESSIONLIST_DATETEXTCOLOR;
+ (NSString *)DAILYSESSIONLIST_DATETEXTSHADOWCOLOR;
+ (NSString *)DAILYSESSIONLIST_DATETEXTSHADOWOFFSET;
+ (NSString *)DAILYSESSIONLIST_DATETEXTSIZE;
+ (NSString *)DAILYSESSIONLIST_DATETEXTSTYLE;
+ (NSString *)DAILYSESSIONLIST_DATEUNDERLINECOLOR;
+ (NSString *)DAILYSESSIONLIST_TEXTCOLOR;
+ (NSString *)DAILYSESSIONLIST_TEXTSHADOWCOLOR;
+ (NSString *)DAILYSESSIONLIST_TEXTSHADOWOFFSET;
+ (NSString *)DAILYSESSIONLIST_TEXTSIZE;
+ (NSString *)DAILYSESSIONLIST_TEXTSTYLE;

//ImageArticleList
+ (NSString *)IMAGEARTICLELIST_BACKGROUNDCOLOR;
+ (NSString *)IMAGEARTICLELIST_BACKGROUNDIMAGE;
+ (NSString *)IMAGEARTICLELIST_CELLBACKGROUNDCOLOR;
+ (NSString *)IMAGEARTICLELIST_ITEMTITLECOLOR;
+ (NSString *)IMAGEARTICLELIST_ITEMTITLESHADOWCOLOR;
+ (NSString *)IMAGEARTICLELIST_ITEMTITLESHADOWOFFSET;
+ (NSString *)IMAGEARTICLELIST_ITEMTITLESIZE;
+ (NSString *)IMAGEARTICLELIST_ITEMTITLESTYLE;
+ (NSString *)IMAGEARTICLELIST_TEXTCOLOR;
+ (NSString *)IMAGEARTICLELIST_TEXTSHADOWCOLOR;
+ (NSString *)IMAGEARTICLELIST_TEXTSHADOWOFFSET;
+ (NSString *)IMAGEARTICLELIST_TEXTSIZE;
+ (NSString *)IMAGEARTICLELIST_TEXTSTYLE;

//NewsTicker
+ (NSString *)NEWSTICKER_BACKGROUNDCOLOR;
+ (NSString *)NEWSTICKER_ITEMTITLESHADOWCOLOR;
+ (NSString *)NEWSTICKER_ITEMTITLESHADOWOFFSET;
+ (NSString *)NEWSTICKER_ITEMTITLECOLOR;
+ (NSString *)NEWSTICKER_ITEMTITLESIZE;
+ (NSString *)NEWSTICKER_ITEMTITLESTYLE;
+ (NSString *)NEWSTICKER_TEXTSHADOWCOLOR;
+ (NSString *)NEWSTICKER_TEXTSHADOWOFFSET;
+ (NSString *)NEWSTICKER_TEXTCOLOR;
+ (NSString *)NEWSTICKER_TEXTSIZE;
+ (NSString *)NEWSTICKER_TEXTSTYLE;
+ (NSString *)NEWSTICKER_TITLECOLOR;
+ (NSString *)NEWSTICKER_TITLESHADOWCOLOR;
+ (NSString *)NEWSTICKER_TITLESHADOWOFFSET;
+ (NSString *)NEWSTICKER_TITLESIZE;
+ (NSString *)NEWSTICKER_TITLESTYLE;

//PushMessageDetail
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTSHADOWCOLOR;
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTSHADOWOFFSET;
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTCOLOR;
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTSIZE;
+ (NSString *)PUSHMESSAGEDETAIL_AUTHORTEXTSTYLE;
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTSHADOWCOLOR;
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTSHADOWOFFSET;
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTCOLOR;
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTSIZE;
+ (NSString *)PUSHMESSAGEDETAIL_SENTTEXTSTYLE;

//SessionDetail
+ (NSString *)SESSIONDETAIL_BACKGROUNDCOLOR;
+ (NSString *)SESSIONDETAIL_BUTTONCOLOR;
+ (NSString *)SESSIONDETAIL_BUTTONTEXTCOLOR;
+ (NSString *)SESSIONDETAIL_BUTTONTEXTSHADOWCOLOR;
+ (NSString *)SESSIONDETAIL_BUTTONTEXTSHADOWOFFSET;
+ (NSString *)SESSIONDETAIL_BUTTONTEXTSIZE;
+ (NSString *)SESSIONDETAIL_BUTTONTEXTSTYLE;
+ (NSString *)SESSIONDETAIL_LABELCOLOR;
+ (NSString *)SESSIONDETAIL_LABELSHADOWCOLOR;
+ (NSString *)SESSIONDETAIL_LABELSHADOWOFFSET;
+ (NSString *)SESSIONDETAIL_LABELSIZE;
+ (NSString *)SESSIONDETAIL_LABELSTYLE;
+ (NSString *)SESSIONDETAIL_BUTTONICON;
+ (NSString *)SESSIONDETAIL_TEXTCOLOR;
+ (NSString *)SESSIONDETAIL_TEXTSHADOWCOLOR;
+ (NSString *)SESSIONDETAIL_TEXTSHADOWOFFSET;
+ (NSString *)SESSIONDETAIL_TEXTSIZE;
+ (NSString *)SESSIONDETAIL_TEXTSTYLE;
+ (NSString *)SESSIONDETAIL_TITLECOLOR;
+ (NSString *)SESSIONDETAIL_TITLESHADOWCOLOR;
+ (NSString *)SESSIONDETAIL_TITLESHADOWOFFSET;
+ (NSString *)SESSIONDETAIL_TITLESIZE;
+ (NSString *)SESSIONDETAIL_TITLESTYLE;

//StaticArticle
+ (NSString *)STATICARTICLE_BACKGROUNDCOLOR;

//SwipeView
+ (NSString *)SWIPEVIEW_BACKGROUNDCOLOR;
+ (NSString *)SWIPEVIEW_BACKGROUNDIMAGE;
+ (NSString *)SWIPEVIEW_SELECTEDPAGECOLOR;
+ (NSString *)SWIPEVIEW_UNSELECTEDPAGECOLOR;

//UpcomingSessions
+ (NSString *)UPCOMINGSESSIONS_BACKGROUNDCOLOR;
+ (NSString *)UPCOMINGSESSIONS_TITLEUNDERLINECOLOR;
+ (NSString *)UPCOMINGSESSIONS_TEXTCOLOR;
+ (NSString *)UPCOMINGSESSIONS_TEXTSHADOWCOLOR;
+ (NSString *)UPCOMINGSESSIONS_TEXTSHADOWOFFSET;
+ (NSString *)UPCOMINGSESSIONS_TEXTSIZE;
+ (NSString *)UPCOMINGSESSIONS_TEXTSTYLE;
+ (NSString *)UPCOMINGSESSIONS_TITLECOLOR;
+ (NSString *)UPCOMINGSESSIONS_TITLESHADOWCOLOR;
+ (NSString *)UPCOMINGSESSIONS_TITLESHADOWOFFSET;
+ (NSString *)UPCOMINGSESSIONS_TITLESIZE;
+ (NSString *)UPCOMINGSESSIONS_TITLESTYLE;

//VenueDetail
+ (NSString *)VENUEDETAIL_BACKGROUNDCOLOR;
+ (NSString *)VENUEDETAIL_BACKGROUNDIMAGE;
+ (NSString *)VENUEDETAIL_BUTTONCOLOR;
+ (NSString *)VENUEDETAIL_BUTTONICON;
+ (NSString *)VENUEDETAIL_BUTTONTEXTCOLOR;
+ (NSString *)VENUEDETAIL_BUTTONTEXTSHADOWCOLOR;
+ (NSString *)VENUEDETAIL_BUTTONTEXTSHADOWOFFSET;
+ (NSString *)VENUEDETAIL_BUTTONTEXTSIZE;
+ (NSString *)VENUEDETAIL_BUTTONTEXTSTYLE;
+ (NSString *)VENUEDETAIL_LABELCOLOR;
+ (NSString *)VENUEDETAIL_LABELSHADOWCOLOR;
+ (NSString *)VENUEDETAIL_LABELSHADOWOFFSET;
+ (NSString *)VENUEDETAIL_LABELSIZE;
+ (NSString *)VENUEDETAIL_LABELSTYLE;
+ (NSString *)VENUEDETAIL_TEXTCOLOR;
+ (NSString *)VENUEDETAIL_TEXTSHADOWCOLOR;
+ (NSString *)VENUEDETAIL_TEXTSHADOWOFFSET;
+ (NSString *)VENUEDETAIL_TEXTSIZE;
+ (NSString *)VENUEDETAIL_TEXTSTYLE;
+ (NSString *)VENUEDETAIL_TITLECOLOR;
+ (NSString *)VENUEDETAIL_TITLESHADOWCOLOR;
+ (NSString *)VENUEDETAIL_TITLESHADOWOFFSET;
+ (NSString *)VENUEDETAIL_TITLESIZE;
+ (NSString *)VENUEDETAIL_TITLESTYLE;
@end
