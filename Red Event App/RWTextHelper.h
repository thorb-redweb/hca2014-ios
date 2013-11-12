//
//  RWTextHelper.h
//  Red Event App
//
//  Created by Thorbjørn Steen on 10/8/13.
//  Copyright (c) 2013 redWEB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWXMLStore;

@interface RWTextHelper : NSObject

-(id)initWithPageName:(NSString *)pagename xmlStore:(RWXMLStore *)xmlStore;

-(void)setText:(UILabel *)label textName:(NSString *)textName defaultText:(NSString *)defaultText;

-(void)setButtonText:(UIButton *)button textName:(NSString *)textName defaultText:(NSString *)defaultText;

-(void)tryText:(UILabel *)label textName:(NSString *)textName;

@end
