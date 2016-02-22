//
//  lcl_config_components_G7.h
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
// The lcl_config_components_G7.h file is used to define the application's log
// components.
//
// Use the code
//
//   _G7lcl_component(<identifier>, <header>, <name>)
//
// for defining a log component, where
//
// - <identifier> is the unique name of a log component which is used in calls
//   to lcl_log etc. A symbol 'G7lcl_c<identifier>' is automatically created for
//   each log component.
//
// - <header> is a C string in UTF-8 which should be used by a logging back-end
//   when writing a log message for the log component. The header is a technical
//   key for identifying a log component's messages. It is recommended to use
//   a 'Reverse ICANN' naming scheme when the header contains grouping
//   information, e.g. 'example.main.component1'.
//
// - <name> is a C string in UTF-8 which contains the name of the log component
//   and its grouping information in a non-technical, human-readable way
//   which could be used by a user interface. Groups should be separated by the
//   path separator '/', e.g. 'Example/Main/Component 1'.
// 


//
// Gao7Core Logging Components
//

#define G7LCLComponentDefinitions \
_G7lcl_component(App,							"App",								"App") \
_G7lcl_component(Gao7Core,						"gao7core",							"Gao7Core") \
_G7lcl_component(Gao7CoreUI,					"gao7core.ui",						"Gao7Core/UI") \
_G7lcl_component(Gao7CoreTesting,				"gao7core.testing",					"Gao7Core/Testing") \
_G7lcl_component(Gao7Network,					"gao7network",						"Gao7Network") \
_G7lcl_component(Gao7BLL,						"gao7bll",							"Gao7BLL") \
_G7lcl_component(Gao7APK,						"gao7apk",							"Gao7APK") \
_G7lcl_component(Gao7ADK,						"gao7adk",							"Gao7ADK") \
_G7lcl_component(Gao7CDK,						"gao7cdk",							"Gao7CDK") \
_G7lcl_component(Gao7UDK,						"gao7udk",							"Gao7UDK") \
_G7lcl_component(Gao7Device,					"gao7device",						"Gao7Device") \
_G7lcl_component(Gao7Stats,						"gao7stats",						"Gao7Stats") \
