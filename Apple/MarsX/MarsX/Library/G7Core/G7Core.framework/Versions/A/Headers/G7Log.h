//
//	RKLog -- RestKit, embedded, Gao7Core/G7Log
//
//
//  Created by Blake Watters on 6/10/11.
//  Copyright (c) 2009-2012 RestKit. All rights reserved.
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

/**
 Gao7Core Logging is based on the LibComponentLogging framework
 
 @see lcl_config_components_G7.h
 @see lcl_config_logger_G7.h
 */
#import "lcl_G7.h"

/**
 * Protocol which classes can implement to determine how Gao7Core log messages actually get handled.
 * There is a single "current" logging class installed, which all log messages will flow
 * through.
 */
@protocol G7Logging

+ (void)logWithComponent:(_G7lcl_component_t)component
				   level:(_G7lcl_level_t)level
					path:(const char *)file
					line:(uint32_t)line
				function:(const char *)function
				  format:(NSString *)format, ... NS_FORMAT_FUNCTION(6, 7);

@end

/**
 * Functions to get and set the current G7Logging class.
 */
Class <G7Logging> G7GetLoggingClass(void);
void G7SetLoggingClass(Class <G7Logging> loggingClass);


/**
 G7LogComponent defines the active component within any given portion of Gao7Core
 
 By default, messages will log to the base 'Gao7Core' log component. All other components
 used by Gao7Core are nested under this parent, so this effectively sets the default log
 level for the entire library.
 
 The component can be undef'd and redefined to change the active logging component.
 */
#define G7LogComponent G7lcl_cGao7Core

/**
 The logging macros. These macros will log to the currently active logging component
 at the log level identified in the name of the macro.
 
 For example, in the `Gao7CoreUI` class we would redefine the G7LogComponent:
 
 #undef G7LogComponent
 #define G7LogComponent G7lcl_cGao7CoreUI
 
 The G7lcl_c prefix is the LibComponentLogging data structure identifying the logging component
 we want to target within this portion of the codebase. See lcl_config_component_G7.h for reference.
 
 Having defined the logging component, invoking the logger via:
 
 G7LogInfo(@"This is my log message!");
 
 Would result in a log message similar to:
 
 INFO Gao7Core.UI:G7Log.m:42 This is my log message!
 
 The message will only be logged if the log level for the active component is equal to or higher
 than the level the message was logged at (in this case, Info).
 */
#define G7LogCritical(...)                                                              \
G7lcl_log(G7LogComponent, G7lcl_vCritical, @"" __VA_ARGS__)

#define G7LogError(...)                                                                 \
G7lcl_log(G7LogComponent, G7lcl_vError, @"" __VA_ARGS__)

#define G7LogWarning(...)                                                               \
G7lcl_log(G7LogComponent, G7lcl_vWarning, @"" __VA_ARGS__)

#define G7LogInfo(...)                                                                  \
G7lcl_log(G7LogComponent, G7lcl_vInfo, @"" __VA_ARGS__)

#define G7LogDebug(...)                                                                 \
G7lcl_log(G7LogComponent, G7lcl_vDebug, @"" __VA_ARGS__)

#define G7LogTrace(...)                                                                 \
G7lcl_log(G7LogComponent, G7lcl_vTrace, @"" __VA_ARGS__)

#undef	INFO
#define INFO( ... )

#undef	PERF
#define PERF( ... )	

#undef	WARN
#define WARN( ... )

#undef	ERROR
#define ERROR( ... )

#undef	PRINT
#define PRINT( ... )

#undef	VAR_DUMP
#define VAR_DUMP( __obj )

#undef	OBJ_DUMP
#define OBJ_DUMP( __obj )


/**
 Log Level Aliases
 
 These aliases simply map the log levels defined within LibComponentLogger to something more friendly
 */
#define G7LogLevelOff       G7lcl_vOff
#define G7LogLevelCritical  G7lcl_vCritical
#define G7LogLevelError     G7lcl_vError
#define G7LogLevelWarning   G7lcl_vWarning
#define G7LogLevelInfo      G7lcl_vInfo
#define G7LogLevelDebug     G7lcl_vDebug
#define G7LogLevelTrace     G7lcl_vTrace

/**
 Alias the LibComponentLogger logging configuration method. Also ensures logging
 is initialized for the framework.
 
 Expects the name of the component and a log level.
 
 Examples:
 
 // Log debugging messages from the Core component
 G7LogConfigureByName("Gao7/Core", G7LogLevelDebug);
 
 // Log only critical messages from the UI component
 G7LogConfigureByName("Gao7/UI", G7LogLevelCritical);
 */
#define G7LogConfigureByName(name, level)                                               \
G7lcl_configure_by_name(name, level);

/**
 Alias for configuring the LibComponentLogger logging component for the App. This
 enables the end-user of Gao7Core to leverage G7Log() to log messages inside of
 their apps.
 */
#define G7LogSetAppLoggingLevel(level)                                                  \
G7lcl_configure_by_name("App", level);

/**
 Temporarily changes the logging level for the specified component and executes the block. Any logging
 statements executed within the body of the block against the specified component will log at the new
 logging level. After the block has executed, the logging level is restored to its previous state.
 */
#define G7LogToComponentWithLevelWhileExecutingBlock(_component, _level, _block)        \
    do {                                                                                \
        int _currentLevel = _G7lcl_component_level[_component];                           \
        G7lcl_configure_by_component(_component, _level);                                 \
        @try {                                                                          \
            _block();                                                                   \
        }                                                                               \
        @catch (NSException *exception) {                                               \
            @throw;                                                                     \
        }                                                                               \
        @finally {                                                                      \
            G7lcl_configure_by_component(_component, _currentLevel);                      \
        }                                                                               \
    } while (false);

/**
 Temporarily turns off logging for the given logging component during execution of the block.
 After the block has finished execution, the logging level is restored to its previous state.
 */
#define G7LogSilenceComponentWhileExecutingBlock(component, _block)                      \
    G7LogToComponentWithLevelWhileExecutingBlock(component, G7LogLevelOff, _block)

/**
 Temporarily changes the logging level for the configured G7LogComponent and executes the block. Any logging
 statements executed within the body of the block for the current logging component will log at the new
 logging level. After the block has finished execution, the logging level is restored to its previous state.
 */
#define G7LogWithLevelWhileExecutingBlock(_level, _block)                               \
    G7LogToComponentWithLevelWhileExecutingBlock(G7LogComponent, _level, _block)


/**
 Temporarily turns off logging for current logging component during execution of the block.
 After the block has finished execution, the logging level is restored to its previous state.
 */
#define G7LogSilenceWhileExecutingBlock(_block)                                        \
    G7LogToComponentWithLevelWhileExecutingBlock(G7LogComponent, G7LogLevelOff, _block)


/**
 Set the Default Log Level

 Based on the presence of the DEBUG flag, we default the logging for the Gao7Core parent component
 to Info or Warning.

 You can override this setting by defining G7LogLevelDefault as a pre-processor macro.
 */
#ifndef G7LogLevelDefault
    #ifdef DEBUG
        #define G7LogLevelDefault G7LogLevelInfo
    #else
        #define G7LogLevelDefault G7LogLevelWarning
    #endif
#endif

/**
 Configure Gao7Core logging from environment variables.
 (Use Option + Command + R to set Environment Variables prior to run.)

 For example to configure the equivalent of setting the following in code:
 G7LogConfigureByName("Gao7Core/UI", G7LogLevelTrace);

 Define an environment variable named 'G7LogLevel.Gao7Core.UI' and set its value to "Trace"

 See lcl_config_components_G7.h for configurable RestKit logging components.

 Valid values are the following:
    Default  or 0
    Critical or 1
    Error    or 2
    Warning  or 3
    Info     or 4
    Debug    or 5
    Trace    or 6
 */
void G7LogConfigureFromEnvironment(void);

/**
 Logs extensive information about an NSError generated as the results
 of a failed key-value validation error.
 */
void G7LogValidationError(NSError *error);

#ifdef _COREDATADEFINES_H
/**
 Logs extensive information an NSError generated as the result of a
 failed Core Data interaction, such as the execution of a fetch request
 or the saving of a managed object context.

 The error will be logged to the RestKit/CoreData component with an
 error level of G7LogLevelError regardless of the current logging context
 at invocation time.
 */
void G7LogCoreDataError(NSError *error);
#endif

/**
 Logs the value of an NSUInteger as a binary string. Useful when
 examining integers containing bitmasked values.
 */
void G7LogIntegerAsBinary(NSUInteger);
