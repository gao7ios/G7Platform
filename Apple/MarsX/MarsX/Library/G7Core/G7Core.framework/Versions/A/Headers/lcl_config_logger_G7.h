//
//  lcl_config_logger_G7.h
//  Gao7Core
//
//  Created by WangMingfu on 15/12/22.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

//
// The lcl_config_logger_G7.h file is used to define the logging back-end which
// is used by the lcl_log() logging macro.
//
// For integration with the logging macro, a back-end simply defines the
// _lcl_logger macro which has the following signature:
//
//   #define _lcl_logger(_component, _level, _format, ...) <logging action>
//

//
// Integration with LibComponentLogging Core.
//

// ARC/non-ARC autorelease pool
#define _G7lcl_logger_autoreleasepool_arc 0
#if defined(__has_feature)
#   if __has_feature(objc_arc)
#   undef  _G7lcl_logger_autoreleasepool_arc
#   define _G7lcl_logger_autoreleasepool_arc 1
#   endif
#endif

#if _G7lcl_logger_autoreleasepool_arc
	#define _G7lcl_logger_autoreleasepool_begin	@autoreleasepool {
	#define _G7lcl_logger_autoreleasepool_end	}
#else
	#define _G7lcl_logger_autoreleasepool_begin	NSAutoreleasePool *_G7lcl_logger_autoreleasepool = [[NSAutoreleasePool alloc] init];
	#define _G7lcl_logger_autoreleasepool_end		[_G7lcl_logger_autoreleasepool release];
#endif


#ifndef _G7LCL_NO_IGNORE_WARNINGS
#   ifdef __clang__
    // Ignore some warnings about variadic macros when using '-Weverything'.
#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Wunknown-pragmas"
#   pragma clang diagnostic ignored "-Wvariadic-macros"
#   pragma clang diagnostic ignored "-Wpedantic"
#   endif
#endif


#define _G7lcl_logger(_component, _level, _format, ...) {                        \
    _G7lcl_logger_autoreleasepool_begin                                          \
    [G7GetLoggingClass() logWithComponent:_component                             \
                                    level:_level                                 \
                                     path:__FILE__                               \
                                     line:__LINE__                               \
                                 function:__PRETTY_FUNCTION__                    \
                                   format:_format, ## __VA_ARGS__];              \
    _G7lcl_logger_autoreleasepool_end                                            \
}

#ifndef _G7LCL_NO_IGNORE_WARNINGS
#   ifdef __clang__
#   pragma clang diagnostic pop
#   endif
#endif

