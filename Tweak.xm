#include <substrate.h>

%hook DATaskManager

-(id)userAgent {
  id defaultUserAgent = %orig;

  NSString *settingsPath = @"/var/mobile/Library/Preferences/com.derv82.exchangent.plist";
  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
  BOOL isEnabled = [[prefs objectForKey:@"enabled"] boolValue];
  NSString *customUserAgent = [prefs objectForKey:@"userAgent"];
  HBLogDebug(@"Exchangent customUserAgent: %@", customUserAgent);

  NSString *device = [prefs objectForKey:@"device"];
  HBLogDebug(@"Exchangent device: %@", device);

  NSString *iosVersion = [prefs objectForKey:@"iosVersion"];
  HBLogDebug(@"Exchangent iosVersion: %@", iosVersion);

  if (!isEnabled) {
    HBLogDebug(@"Exchangent disabled. Using default userAgent: %@", defaultUserAgent);
    return defaultUserAgent;
  }

  id newAgent = @"iPhone8C2/1307.36";
  HBLogDebug(@"Exchangent enabled. Using overridden userAgent: %@", newAgent);
  return newAgent;
}

%end
