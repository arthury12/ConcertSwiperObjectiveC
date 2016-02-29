//
//  swipeVC.m
//  concertSwiper
//
//  Created by Arthur Yu on 2/23/16.
//  Copyright © 2016 Arthur Yu. All rights reserved.
//

#import "swipeVC.h"

@interface swipeVC ()
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) NSURL *url;
//@property (nonatomic, strong) NSMutableArray *arrayOfArtistDict;
//@property (nonatomic, strong) NSInteger *artistArrayIndex;
@property (nonatomic, strong) NSURL *TMTicketURL;
@property (nonatomic, strong) IBOutlet UIImageView *artistImage;
@property (nonatomic, strong) IBOutlet UILabel *artistTitle;

@end

static NSInteger artistArrayIndex;
static NSMutableArray *arrayOfArtistDict;
static NSMutableArray *storedEvents;

@implementation swipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayOfArtistDict = [[NSMutableArray alloc] init];
    storedEvents  = [[NSMutableArray alloc] init];
    artistArrayIndex = 0;
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wasDragged:)];
    //[self artistTitle];
    [self parseJSON];
    [self.artistImage addGestureRecognizer:gesture];
    self.artistImage.userInteractionEnabled = YES;
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)goToTMLink:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:self.TMTicketURL];
}

- (void) wasDragged: (UIPanGestureRecognizer *) gesture {
    CGPoint translation = CGPointMake([gesture translationInView:(self.view)].x, [gesture translationInView:(self.view)].y); //future coordinates
    UIView *image = gesture.view;
    
    image.center = CGPointMake(self.view.bounds.size.width/2 + translation.x, self.view.bounds.size.height/2 + translation.y);
    //Number of pixel from center current pic is in
    double xFromCenter = image.center.x - self.view.bounds.size.width/2;
    //Farther from x the smaller it gets, but at most 1.
    double scale = 0;
    if (1/abs(xFromCenter) > 1) {
        scale = 1;
    } else {
        scale = 1/abs(xFromCenter);
    }
    CGAffineTransform rotation = CGAffineTransformMakeRotation(xFromCenter / 200);
    CGAffineTransform stretch = CGAffineTransformScale(rotation, scale, scale);
    image.transform = stretch;
    
    if (gesture.state == UIGestureRecognizerStateEnded && arrayOfArtistDict.count > 0) {
        if (image.center.x < 100) {
            if (artistArrayIndex < arrayOfArtistDict.count) {
                artistArrayIndex++;
                [self loadImageAndTitle: arrayOfArtistDict];
            }
        } else if (image.center.x > self.view.bounds.size.width - 100) {
            if (artistArrayIndex + 1 < arrayOfArtistDict.count) {
                [storedEvents addObject:(arrayOfArtistDict[artistArrayIndex])];
                 NSLog(@"%@", arrayOfArtistDict[artistArrayIndex]);
                 artistArrayIndex++;
                 [self loadImageAndTitle:arrayOfArtistDict[artistArrayIndex]];
            }
        }
                 
        rotation = CGAffineTransformMakeRotation(0);
        stretch = CGAffineTransformScale(rotation, 1, 1);
        image.transform = stretch;
        image.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    }
                            
}

- (void) parseJSON {
    self.urlStr = [NSString stringWithFormat:@"http://app.map.jash1.syseng.tmcs:8080/api/mapping/hp?domain=US&marketId=27"];
    self.url = [NSURL URLWithString:self.urlStr];
    
    NSMutableArray *artistModelArray = [[NSMutableArray alloc] init];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:self.urlStr] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ((error == nil) && (response != nil)) {
            NSError *JSONerror = nil;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSDictionary *recommendations = [jsonDict valueForKey:@"recommendations"];
            NSDictionary *top = [recommendations valueForKey:@"top"];
            NSArray *recommendedArtists = [top valueForKey:@"recommendedArtists"];
            NSMutableDictionary *artistDict = [[NSMutableDictionary alloc] init];
            for (NSObject *artistObj in recommendedArtists) {
                NSMutableDictionary *artistObjDict = artistObj;
                NSMutableDictionary *artistDict = [artistObjDict valueForKey:@"artist"];
                if (artistDict != nil) {
                    [artistModelArray addObject:artistDict];
                }
                [arrayOfArtistDict addObject:artistDict];
            }
            NSLog(@"%@", artistModelArray);
        }
        else {
            [self displayNetworkNotAvaliable];
        }
        if ([arrayOfArtistDict count] > 0){
            [self loadImageAndTitle: arrayOfArtistDict[artistArrayIndex]];
        }
    }] resume ];
}

- (void) loadImageAndTitle:(NSDictionary *)artistDict {
    //load image, title, URL
    [self.artistTitle setText:[artistDict valueForKey:@"artistName"]];
    self.TMTicketURL = [NSURL URLWithString:[artistDict valueForKey:@"artistLinkId"]];
    NSLog(@"artist title is %@", self.artistTitle.text);
    NSURL *url = [NSURL URLWithString:[artistDict valueForKey:@"largeArtistImageUrl"]];
    NSURLSession *imageSession = [NSURLSession sharedSession];
    NSURLSessionTask *imageSessionTask = [imageSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            self.artistImage.image = [UIImage imageWithData:data];
        }	
    }];
    [imageSessionTask resume];
    //[self.view setNeedsDisplay];
}

- (void) displayNetworkNotAvaliable {
    NSString *sadFace =  @"http://images.moneysavingexpert.com/images/sadface.jpg";
    NSURL *sadFaceURL = [NSURL URLWithString:sadFace];
    NSURLSessionTask *imageSessionTask = [[NSURLSession sharedSession] dataTaskWithURL:sadFaceURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            self.artistImage.image = [UIImage imageWithData:data];
        }
    }];
    [imageSessionTask resume];
    self.artistTitle.text = @"No artist avaliable 😭";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end