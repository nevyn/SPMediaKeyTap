#import "SPMediaKeyTapExampleAppDelegate.h"

@implementation MediaKeyExampleApp
- (void)sendEvent:(NSEvent *)theEvent
{
	// If event tap is not installed, handle events that reach the app instead
	BOOL shouldHandleMediaKeyEventLocally = ![SPMediaKeyTap usesGlobalMediaKeyTap];

	if(shouldHandleMediaKeyEventLocally && [theEvent type] == NSSystemDefined && [theEvent subtype] == SPSystemDefinedEventMediaKeys) {
		[(id)[self delegate] mediaKeyTap:nil receivedMediaKeyEvent:theEvent];
	}
	[super sendEvent:theEvent];
}
@end




@implementation SPMediaKeyTapExampleAppDelegate
@synthesize window;
+(void)initialize;
{
	if([self class] != [SPMediaKeyTapExampleAppDelegate class]) return;
	
	// Register defaults for the whitelist of apps that want to use media keys
	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
		[SPMediaKeyTap defaultMediaKeyUserBundleIdentifiers], kMediaKeyUsingBundleIdentifiersDefaultsKey,
	nil]];
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	keyTap = [[SPMediaKeyTap alloc] initWithDelegate:self];
	if([SPMediaKeyTap usesGlobalMediaKeyTap])
		[keyTap startWatchingMediaKeys];
	else
		NSLog(@"Media key monitoring disabled");

}

-(void)mediaKeyTap:(SPMediaKeyTap*)keyTap receivedMediaKeyEvent:(NSEvent*)event;
{
	NSAssert([event type] == NSSystemDefined && [event subtype] == SPSystemDefinedEventMediaKeys, @"Unexpected NSEvent in mediaKeyTap:receivedMediaKeyEvent:");
	// here be dragons...
	int keyCode = (([event data1] & 0xFFFF0000) >> 16);
	int keyFlags = ([event data1] & 0x0000FFFF);
	BOOL keyIsPressed = (((keyFlags & 0xFF00) >> 8)) == 0xA;
	int keyRepeat = (keyFlags & 0x1);
	
	if (keyIsPressed) {
		NSString *debugString = [NSString stringWithFormat:@"%@", keyRepeat?@", repeated.":@"."];
		switch (keyCode) {
			case NX_KEYTYPE_PLAY:
				debugString = [@"Play/pause pressed" stringByAppendingString:debugString];
				break;
				
			case NX_KEYTYPE_FAST:
				debugString = [@"Ffwd pressed" stringByAppendingString:debugString];
				break;
				
			case NX_KEYTYPE_REWIND:
				debugString = [@"Rewind pressed" stringByAppendingString:debugString];
				break;
			default:
				debugString = [NSString stringWithFormat:@"Key %d pressed%@", keyCode, debugString];
				break;
			// More cases defined in hidsystem/ev_keymap.h
		}
		[debugLabel setStringValue:debugString];
	}
}

@end
