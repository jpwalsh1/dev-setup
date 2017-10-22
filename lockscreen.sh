#!/usr/bin/env bash

# Do our work in the temporary directory that gets cleaned on boot
cd ~/scripts/

# Create the source file
cat > main.m <<END_OF_FILE

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

int main () {
    NSBundle *bundle = [NSBundle bundleWithPath:@"/Applications/Utilities/Keychain Access.app/Contents/Resources/Keychain.menu"];
    Class principalClass = [bundle principalClass];
    id instance = [[principalClass alloc] init];
    [instance performSelector:@selector(_lockScreenMenuHit:) withObject:nil];
    return 0;
}

END_OF_FILE

# Compile the source file
clang -framework Foundation main.m -o lockscreen
rm main.m
