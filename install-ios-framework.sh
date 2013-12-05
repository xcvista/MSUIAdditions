#!/bin/sh

#  install-ios-framework.sh
#  MSUIAdditions
#
#  Created by Maxthon Chan on 12/5/13.
#  Copyright (c) 2013 muski. All rights reserved.

mkdir -p Frameworks
cd Frameworks

XCODEROOT=$(xcode-select -p)

git clone https://github.com/kstenerud/iOS-Universal-Framework.git
cd iOS-Universal-Framework/Real\ Framework
./install.sh << "EOF"

y
EOF

if [ ! -f $XCODEROOT/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Specifications/UFW-iOSStaticFramework.xcspec ];
exit 1
else
exit 0
fi
