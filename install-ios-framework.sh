#!/bin/sh

#  install-ios-framework.sh
#  MSUIAdditions
#
#  Created by Maxthon Chan on 12/5/13.
#  Copyright (c) 2013 muski. All rights reserved.

mkdir -p Frameworks
cd Frameworks

git clone https://github.com/kstenerud/iOS-Universal-Framework.git
cd iOS-Universal-Framework/Real\ Framework
./install.sh << "EOF"

y
EOF
