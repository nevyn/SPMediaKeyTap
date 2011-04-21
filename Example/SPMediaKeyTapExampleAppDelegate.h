#import <Cocoa/Cocoa.h>
#import "../SPMediaKeyTap.h"

@interface MediaKeyExampleApp : NSApplication
@end

@interface SPMediaKeyTapExampleAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	SPMediaKeyTap *keyTap;
	IBOutlet NSTextField *debugLabel;
}

@property (assign) IBOutlet NSWindow *window;

@end
