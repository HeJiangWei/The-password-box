//
//  Dekojw0815GalleryItemView.m
//  deko
//
//  Created by Johan Halin on 5.12.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import "Dekojw0815GalleryItemView.h"

@interface Dekojw0815GalleryItemView ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIActivityIndicatorView *spinner;
@end

@implementation Dekojw0815GalleryItemView

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor clearColor];
		
		_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		_imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		[self addSubview:_imageView];
		
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		_spinner.autoresizingMask = _imageView.autoresizingMask;
		_spinner.hidden = YES;
		[self addSubview:_spinner];
	}
	
	return self;
}

#pragma mark - Property setters

- (void)setThumbnail:(UIImage *)thumbnail
{
	self.imageView.image = thumbnail;
	self.imageView.frame = CGRectMake(floor(CGRectGetMidX(self.bounds) - (thumbnail.size.width / 2.0)),
									  floor(CGRectGetMidY(self.bounds) - (thumbnail.size.height / 2.0)),
									  thumbnail.size.width,
									  thumbnail.size.height);
}

- (void)setLoading:(BOOL)loading
{
	if (loading)
	{
		[self.spinner startAnimating];
		self.spinner.hidden = NO;
	}
	else
	{
		[self.spinner stopAnimating];
		self.spinner.hidden = YES;
	}
	
	self.spinner.frame = CGRectMake(floor(CGRectGetMidX(self.bounds) - (self.spinner.bounds.size.width / 2.0)),
									floor(CGRectGetMidY(self.bounds) - (self.spinner.bounds.size.height / 2.0)),
									self.spinner.bounds.size.width,
									self.spinner.bounds.size.height);
	[self bringSubviewToFront:self.spinner];
}

@end
