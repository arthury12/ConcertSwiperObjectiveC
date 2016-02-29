//
//  customArtistModel.m
//  concertSwiper
//
//  Created by Arthur Yu on 2/25/16.
//  Copyright © 2016 Arthur Yu. All rights reserved.
//

#import "customArtistModel.h"
#import <Foundation/Foundation.h>

@interface customArtistModel ()

@end

@implementation customArtistModel

typedef struct {
    NSInteger *artistId;
    __unsafe_unretained NSString *artistImageUrl;
    __unsafe_unretained NSString *artistLinkId;
    __unsafe_unretained NSString *artistName;
    __unsafe_unretained NSString *largeArtistImageUrl;
    NSInteger *score;
    __unsafe_unretained NSString *strategy;
} artistModel;


@end