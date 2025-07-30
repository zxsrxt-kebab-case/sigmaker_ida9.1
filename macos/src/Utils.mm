#include "Utils.h"

#include <AppKit/NSPasteboard.h>
#include <Foundation/NSString.h>

bool SetClipboardText( std::string_view text ) {
	if( text.empty( ) ) {
		return false;
	}

    @autoreleasepool {

        NSPasteboard* pasteboard = [NSPasteboard generalPasteboard];

        [pasteboard clearContents];

        NSString* nsText = [NSString stringWithUTF8String:text.data()];

        return [pasteboard setString:nsText forType:NSPasteboardTypeString];
    }

    return true;
}

bool GetRegexMatches( std::string string, std::regex regex, std::vector<std::string>& matches ) {
	std::sregex_iterator iter( string.begin( ), string.end( ), regex );
	std::sregex_iterator end;

	matches.clear( );

	size_t i = 0;
	while( iter != end ) {
		matches.push_back( iter->str( ) );
		++iter;
	}
	return !matches.empty( );
}