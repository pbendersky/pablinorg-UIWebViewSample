//
//  QDNViewController.m
//  WebViewSample
//
//  Created by Pablo Bendersky on 8/31/13.
//  Copyright (c) 2013 Pablo Bendersky. All rights reserved.
//

#import "QDNViewController.h"

@interface QDNViewController ()

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;

- (IBAction)decreaseTextSize:(id)sender;
- (IBAction)increaseTextSize:(id)sender;
- (void)resizeTextAdding:(NSInteger)textSizeIncrement;

@end

@implementation QDNViewController

- (void)viewWillAppear:(BOOL)animated {
    NSURL *localFileURL = [[NSBundle mainBundle] URLForResource:@"content"
                                                  withExtension:@"html"];
    [self.webView loadHTMLString:
     [NSString stringWithContentsOfURL:localFileURL
                              encoding:NSUTF8StringEncoding
                                 error:NULL]
                         baseURL:nil];
}

- (IBAction)decreaseTextSize:(id)sender {
    [self resizeTextAdding:-1];
}

- (IBAction)increaseTextSize:(id)sender {
    [self resizeTextAdding:1];
}

- (void)resizeTextAdding:(NSInteger)textSizeIncrement {
    NSString *jsString = [NSString stringWithFormat:@"resizeText(%d)", textSizeIncrement];

    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
}

#pragma mark - UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([request.URL.scheme caseInsensitiveCompare:@"nativeAction"] == NSOrderedSame) {
        [UIView animateWithDuration:0.3 animations:^{
            self.toolBar.alpha = (1 - self.toolBar.alpha);
        }];
    }

    return YES;
}

@end
