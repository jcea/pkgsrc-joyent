$NetBSD$

Build with newer DTrace.

--- cmake/plugin.cmake.orig	2015-01-12 10:31:35.000000000 +0000
+++ cmake/plugin.cmake
@@ -21,6 +21,7 @@ INCLUDE(${MYSQL_CMAKE_SCRIPT_DIR}/cmake_
 # [STORAGE_ENGINE]
 # [MANDATORY|DEFAULT]
 # [STATIC_ONLY|DYNAMIC_ONLY]
+# [DTRACE_INSTRUMENTED]
 # [MODULE_OUTPUT_NAME module_name]
 # [STATIC_OUTPUT_NAME static_name]
 # [RECOMPILE_FOR_EMBEDDED]
@@ -47,7 +48,7 @@ ENDMACRO()
 MACRO(MYSQL_ADD_PLUGIN)
   MYSQL_PARSE_ARGUMENTS(ARG
     "LINK_LIBRARIES;DEPENDENCIES;MODULE_OUTPUT_NAME;STATIC_OUTPUT_NAME"
-    "STORAGE_ENGINE;STATIC_ONLY;MODULE_ONLY;MANDATORY;DEFAULT;DISABLED;RECOMPILE_FOR_EMBEDDED"
+    "STORAGE_ENGINE;STATIC_ONLY;MODULE_ONLY;MANDATORY;DEFAULT;DISABLED;RECOMPILE_FOR_EMBEDDED;DTRACE_INSTRUMENTED"
     ${ARGN}
   )
   
@@ -116,7 +117,9 @@ MACRO(MYSQL_ADD_PLUGIN)
   IF (WITH_${plugin} AND NOT ARG_MODULE_ONLY)
     ADD_LIBRARY(${target} STATIC ${SOURCES})
     SET_TARGET_PROPERTIES(${target} PROPERTIES COMPILE_DEFINITONS "MYSQL_SERVER")
-    DTRACE_INSTRUMENT(${target})
+    IF (ARG_DTRACE_INSTRUMENTED)
+      DTRACE_INSTRUMENT(${target})
+    ENDIF()
     ADD_DEPENDENCIES(${target} GenError ${ARG_DEPENDENCIES})
     IF(WITH_EMBEDDED_SERVER)
       # Embedded library should contain PIC code and be linkable
@@ -124,7 +127,9 @@ MACRO(MYSQL_ADD_PLUGIN)
       IF(ARG_RECOMPILE_FOR_EMBEDDED OR NOT _SKIP_PIC)
         # Recompile some plugins for embedded
         ADD_CONVENIENCE_LIBRARY(${target}_embedded ${SOURCES})
-        DTRACE_INSTRUMENT(${target}_embedded)   
+        IF (ARG_DTRACE_INSTRUMENTED)
+          DTRACE_INSTRUMENT(${target}_embedded)
+        ENDIF()
         IF(ARG_RECOMPILE_FOR_EMBEDDED)
           SET_TARGET_PROPERTIES(${target}_embedded 
             PROPERTIES COMPILE_DEFINITIONS "MYSQL_SERVER;EMBEDDED_LIBRARY")
@@ -170,7 +175,9 @@ MACRO(MYSQL_ADD_PLUGIN)
 
     ADD_VERSION_INFO(${target} MODULE SOURCES)
     ADD_LIBRARY(${target} MODULE ${SOURCES}) 
-    DTRACE_INSTRUMENT(${target})
+    IF (ARG_DTRACE_INSTRUMENTED)
+      DTRACE_INSTRUMENT(${target})
+    ENDIF()
     SET_TARGET_PROPERTIES (${target} PROPERTIES PREFIX ""
       COMPILE_DEFINITIONS "MYSQL_DYNAMIC_PLUGIN")
     TARGET_LINK_LIBRARIES (${target} mysqlservices)
