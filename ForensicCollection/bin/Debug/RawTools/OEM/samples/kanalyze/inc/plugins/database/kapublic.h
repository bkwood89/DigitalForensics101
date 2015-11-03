/*++

Copyright (c) 1999 Microsoft Corporation

Module Name:

    kapublic.h

Abstract:

    This includes definitions of private helper routines
    for database plug-in

Author:

     Koji Shimazaki (v-kojshi)

Revision History:

--*/

////////////////////////////////////////////////////////////////////////////////////////////////
//
// Query plug-in method interfaces.
//
// Item Type                            Method
// ----------------------------------------------------------------------
// Analysis\DbMatching                  M_QUERY_GET_MATCH_RESULT
// Analysis\DbPreMatching               M_QUERY_GET_PREQUERY_MATCH_RESULT
//
//
// Query plug-in private interfaces.
// ---------------------------------
// P_QUERY_SET_PROCESSOR_TYPE_A
// P_QUERY_SET_PROCESSOR_TYPE_W
// P_QUERY_GET_PROCESSOR_TYPE_A
// P_QUERY_GET_PROCESSOR_TYPE_W
// P_QUERY_SET_PROCESSOR_VENDOR_A
// P_QUERY_SET_PROCESSOR_VENDOR_W
// P_QUERY_GET_PROCESSOR_VENDOR_A
// P_QUERY_GET_PROCESSOR_VENDOR_W
//
// Note:
//   When you use method/private interface, please include .\kanalyze\database\kadbprov.h
//
//
// Known issues database access routines.
// ----------------------------------------------------------------------
// DpInitialize                         DpCleanup
// DpOpenConnection                     DpCloseConnection
// DpStartTransaction                   DpRollBackTransaction
// DpCommitTransaction                  DpGetCrashClass
// DpAddCrashClass                      DpUpdateCrashClass
// DpGetCrashInstance                   DpAddCrashInstance
// DpGetSolution                        DpAddSolution
// DpUpdateSolution                     DpGetAnalysis
// DpAddAnalysis                        DpUpdateAnalysis
// DpGetHWProfile                       DpAddHWProfile
// DpUpdateHWProfileOccurrenceCount     DpGetOSProfile
// DpAddOSProfile                       DpUpdateOSProfileOccurrenceCount
// DpGetHintData                        DpAddHintData
// DpUpdateHintData                     DpGetProgressText
// DpAddProgressText                    DpGetKernelModuleData
// DpAddKernelModuleData                DpGetKernelModule
// DpAddKernelModule                    DpGetKanalyzeModuleData
// DpAddKanalyzeModuleData              DpGetKanalyzeModule
// DpAddKanalyzeModule                  DpGetAttachmentData
// DpAddAttachmentData                  DpGetVariableCrashData
// DpAddVariableCrashData               DpGetLastError
// DpBuildHWProfileMatchString          DpBuildOSProfileMatchStr
// DpBuildKernelModuleDataMatchStr      DpBuildKanalyzeModuleDataMatchStr
// DpGetCrashClassCrashInstance         DpGetProcessorTypeProcessorVendor
//
//
// Utility macros.
// ---------------------------------------------------------------
// KADB_GET_PLATFORM_A                  KADB_GET_PLATFORM_W
// KADB_SET_PLATFORM_A                  KADB_SET_PLATFORM_W
// KADB_GET_OS_TYPE_A                   KADB_GET_OS_TYPE_W
// KADB_SET_OS_TYPE_A                   KADB_SET_OS_TYPE_W
// KADB_GET_KANALYZE_TYPE_A             KADB_GET_KANALYZE_TYPE_W
// KADB_SET_KANALYZE_TYPE_A             KADB_SET_KANALYZE_TYPE_W
// KADB_SET_PROCESSOR_TYPE_A            KADB_SET_PROCESSOR_TYPE_W
// KADB_GET_PROCESSOR_TYPE_A            KADB_GET_PROCESSOR_TYPE_W
// KADB_SET_PROCESSOR_VENDOR_A          KADB_SET_PROCESSOR_VENDOR_W
// KADB_GET_PROCESSOR_VENDOR_A          KADB_GET_PROCESSOR_VENDOR_W
//
//
////////////////////////////////////////////////////////////////////////////////////////////////

// Plug-in names.
#define PLUGIN_HINT L"HINT"
#define PLUGIN_DATABASE L"DATABASE"
#define PLUGIN_QUERY L"QUERY"


// Private helper routines name.
#define DATABASE_HELPER_NAME L"Database"

//
// Helper interfaces.
//
#define M_QUERY_FULL_BASE 0x00010000
#define M_QUERY_GET_MATCH_RESULT (M_QUERY_FULL_BASE+1)
//UINT_32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//  IN HKAPLUGIN,
//  IN KA_ITEM_ID,
//  IN ULONG32,
//  OUT PQUERY_MATCH_RESULT
//  )

#define M_QUERY_PRE_BASE 0x00020000
#define M_QUERY_GET_PREQUERY_MATCH_RESULT (M_QUERY_PRE_BASE+1)
//UINT_32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//  IN HKAPLUGIN,
//  IN KA_ITEM_ID,
//  IN ULONG32,
//  OUT PQUERY_MATCH_RESULT
//  )

typedef struct _QUERY_MATCH_RESULT {
    HKAPLUGIN ReportedPluginHandle;
    MatchConfidenceLevel MatchLevel;
    KANALYZE_CRASH_CLASS_DATA CrashData;
    KADB_SOLUTION SolutionData;
    LPWSTR SolutionTextOverride;
    KADB_ANALYSIS AnalysisData;
} QUERY_MATCH_RESULT, *PQUERY_MATCH_RESULT;


//
// Private interfaces.
//

// Structure definitions.
typedef struct _QUERY_PTYPE_INFO_A {
    LONG32 VendorID;
    USHORT Family;
    USHORT Model;
    USHORT Step;
    LPSTR Type;
} QUERY_PTYPE_INFO_A, *PQUERY_PTYPE_INFO_A;

typedef struct _QUERY_PTYPE_INFO_W {
    LONG32 VendorID;
    USHORT Family;
    USHORT Model;
    USHORT Step;
    LPWSTR Type;
} QUERY_PTYPE_INFO_W, *PQUERY_PTYPE_INFO_W;

typedef struct _QUERY_PVENDOR_INFO_A {
    LONG32 VendorID;
    LPSTR VendorName;
} QUERY_PVENDOR_INFO_A, *PQUERY_PVENDOR_INFO_A;

typedef struct _QUERY_PVENDOR_INFO_W {
    LONG32 VendorID;
    LPWSTR VendorName;
} QUERY_PVENDOR_INFO_W, *PQUERY_PVENDOR_INFO_W;


#define P_QUERY_SET_PROCESSOR_TYPE_A    (KA_PRIVATE+1)
/*
UINT32
(CALLBACK *KANALYZE_CALL_PLUGIN_ROUTINE)(
    IN HKAPLUGIN  hPlugIn,
    IN LPCWSTR    PlugInName,
    IN UINT32     PrivateOperationCode,
    IN UINT_PTR   Unused,
    IN OUT PQUERY_PTYPE_INFO_A ProcessorTypeInfoA,
    OUT PBOOL    isReached
    );

Description:

    This private interface is used to set processor type 
    from processor vendor, family, model, and step.

Arguments:

    ProcessorTypeInfoA - specify the information to query.
                         The following values will be used to query, then return processor type.
                         Note that the buffer allocation/free is caller's matter.
        IN
            ProcessorTypeInfoA.VendorID - specify the vendor id.
            ProcessorTypeInfoA.Family - specify the processor family.
            ProcessorTypeInfoA.Model - specify the processor model.
            ProcessorTypeInfoA.Step - specify the processor step. If this is -1, this will be ignored.
            ProcessorTypeInfoA.Type - specify the buffer address. Caller should allocate/free this buffer.

        OUT
            ProcessorTypeInfoA.Type - filled with processor type string.
*/

#define P_QUERY_SET_PROCESSOR_TYPE_W    (KA_PRIVATE+2)
/*
UINT32
(CALLBACK *KANALYZE_CALL_PLUGIN_ROUTINE)(
    IN HKAPLUGIN  hPlugIn,
    IN LPCWSTR    PlugInName,
    IN UINT32     PrivateOperationCode,
    IN UINT_PTR   Unused,
    IN OUT PQUERY_PTYPE_INFO_W ProcessorTypeInfoW,
    OUT PBOOL    isReached
    );

Description:

    This private interface is used to set processor type 
    from processor vendor, family, model, and step.

Arguments:

    ProcessorTypeInfoA - specify the information to query.
                         The following values will be used to query, then return processor type.
                         Note that the buffer allocation/free is caller's matter.
        IN
            ProcessorTypeInfoA.VendorID - specify the vendor id.
            ProcessorTypeInfoA.Family - specify the processor family.
            ProcessorTypeInfoA.Model - specify the processor model.
            ProcessorTypeInfoA.Step - specify the processor step. If this is -1, this will be ignored.
            ProcessorTypeInfoA.Type - specify the buffer address. Caller should allocate/free this buffer.

        OUT
            ProcessorTypeInfoA.Type - filled with processor type string.
*/


#define P_QUERY_GET_PROCESSOR_TYPE_A    (KA_PRIVATE+3)
/*
UINT32
(CALLBACK *KANALYZE_CALL_PLUGIN_ROUTINE)(
    IN HKAPLUGIN  hPlugIn,
    IN LPCWSTR    PlugInName,
    IN UINT32     PrivateOperationCode,
    IN UINT_PTR   Unused,
    IN OUT PQUERY_PTYPE_INFO_A ProcessorTypeInfoA,
    OUT PBOOL    isReached
    );

Description:

    This private interface is used to set processor family from processor type.

Arguments:

    ProcessorTypeInfoA - specify the information to query.
                         The following values will be used to query, then return processor family.
        IN
            ProcessorTypeInfoA.Type - specify the processor type.

         OUT
            ProcessorTypeInfoA.Family - processor family.
*/


#define P_QUERY_GET_PROCESSOR_TYPE_W    (KA_PRIVATE+4)
/*
UINT32
(CALLBACK *KANALYZE_CALL_PLUGIN_ROUTINE)(
    IN HKAPLUGIN  hPlugIn,
    IN LPCWSTR    PlugInName,
    IN UINT32     PrivateOperationCode,
    IN UINT_PTR   Unused,
    IN OUT PQUERY_PTYPE_INFO_W ProcessorTypeInfoW,
    OUT PBOOL    isReached
    );

Description:

    This private interface is used to set processor family from processor type.

Arguments:

    ProcessorTypeInfoW - specify the information to query.
                         The following values will be used to query, then return processor family.
        IN
            ProcessorTypeInfoW.Type - specify the processor type.

        OUT
            ProcessorTypeInfoW.Family - processor family.
*/


#define P_QUERY_SET_PROCESSOR_VENDOR_A  (KA_PRIVATE+5)
/*
UINT32
(CALLBACK *KANALYZE_CALL_PLUGIN_ROUTINE)(
    IN HKAPLUGIN  hPlugIn,
    IN LPCWSTR    PlugInName,
    IN UINT32     PrivateOperationCode,
    IN UINT_PTR   Unused,
    IN OUT PQUERY_PVENDOR_INFO_A ProcessorVendorInfoA,
    OUT PBOOL    isReached
    );

Description:

    This private interface is used to set vendor name from vendor id.

Arguments:

    ProcessorVendorInfoA - specify the information to query.
                           The following values will be used to query, then return vendor name.
                           Note that the buffer allocation/free is caller's matter.
        IN
            ProcessorVendorInfoA.VendorID - specify the vendor id.
            ProcessorVendorInfoA.VendorName - specify the buffer address.
                                              caller should alloc/free this buffer.

        OUT
            ProcessorVendorInfoA.VendorName - filled with vendor name.
*/


#define P_QUERY_SET_PROCESSOR_VENDOR_W  (KA_PRIVATE+6)
/*
UINT32
(CALLBACK *KANALYZE_CALL_PLUGIN_ROUTINE)(
    IN HKAPLUGIN  hPlugIn,
    IN LPCWSTR    PlugInName,
    IN UINT32     PrivateOperationCode,
    IN UINT_PTR   Unused,
    IN OUT PQUERY_PVENDOR_INFO_W ProcessorVendorInfoW,
    OUT PBOOL    isReached
    );

Description:

    This private interface is used to set vendor name from vendor id.

Arguments:

    ProcessorVendorInfoW - specify the information to query.
                           The following values will be used to query, then return vendor name.
                           Note that the buffer allocation/free is caller's matter.
        IN
            ProcessorVendorInfoW.VendorID - specify the vendor id.
            ProcessorVendorInfoW.VendorName - specify the buffer address.
                                              caller should alloc/free this buffer.

        OUT
            ProcessorVendorInfoW.VendorName - filled with vendor name.
*/


#define P_QUERY_GET_PROCESSOR_VENDOR_A  (KA_PRIVATE+7)
/*
UINT32
(CALLBACK *KANALYZE_CALL_PLUGIN_ROUTINE)(
    IN HKAPLUGIN  hPlugIn,
    IN LPCWSTR    PlugInName,
    IN UINT32     PrivateOperationCode,
    IN UINT_PTR   Unused,
    IN OUT PQUERY_PVENDOR_INFO_A ProcessorVendorInfoA,
    OUT PBOOL    isReached
    );

Description:

    This private interface is used to set vendor id from vendor name.

Arguments:

    ProcessorVendorInfoA - specify the information to query.
                           The following values will be used to query, then return vendor id.
        IN
            ProcessorVendorInfoA.VendorName - specify the vendor name.

        OUT
            ProcessorVendorInfoA.VendorID - vendor id.

*/


#define P_QUERY_GET_PROCESSOR_VENDOR_W  (KA_PRIVATE+8)
/*
UINT32
(CALLBACK *KANALYZE_CALL_PLUGIN_ROUTINE)(
    IN HKAPLUGIN  hPlugIn,
    IN LPCWSTR    PlugInName,
    IN UINT32     PrivateOperationCode,
    IN UINT_PTR   Unused,
    IN OUT PQUERY_PVENDOR_INFO_W ProcessorVendorInfoW,
    OUT PBOOL    isReached
    );

Description:

    This private interface is used to set vendor id from vendor name.

Arguments:

    ProcessorVendorInfoW - specify the information to query.
                           The following values will be used to query, then return vendor id.
        IN
            ProcessorVendorInfoW.VendorName - specify the vendor name.

        OUT
            ProcessorVendorInfoW.VendorID - vendor id.

*/


/////////////////////////////////////////////////////////////////
//
// Definitions of database plug-in private helper routines.
// These functions are wrapper function of database provider DLL.
//
/////////////////////////////////////////////////////////////////
typedef
BOOL
(CALLBACK *PDATABASE_INITIALIZE)(
    VOID
    );

typedef
BOOL
(CALLBACK *PDATABASE_CLEANUP)(
    IN VOID
    );

typedef
BOOL
(CALLBACK *PDATABASE_OPEN_CONNECTION)(
    IN LPCWSTR FileDSN,
    IN LPCWSTR UID,
    IN LPCWSTR Password
    );

typedef
BOOL
(CALLBACK *PDATABASE_CLOSE_CONNECTION)(
    VOID
    );

typedef
BOOL
(CALLBACK *PDATABASE_START_TRANSACTION)(
    VOID
    );

typedef
BOOL
(CALLBACK *PDATABASE_ROLLBACK_TRANSACTION)(
    VOID
    );

typedef
BOOL
(CALLBACK *PDATABASE_COMMIT_TRANSACTION)(
    VOID
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_CRASH_CLASS)(
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK CallBack,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_CRASH_CLASS)(
    IN  PKADB_CRASH_CLASS CrashClass,
    OUT PLONG32     ClassID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_UPDATE_CRASH_CLASS)(
    IN UINT64       UpdateFlags,
    IN LONG32       ClassID,
    IN PKADB_CRASH_CLASS CrashClass,
    IN PVOID        Reserved,
    IN UINT_PTR     Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_CRASH_INSTANCE)(
    IN LONG32   CrashID,
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK CallBack,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_CRASH_INSTANCE)(
    IN  PKADB_CRASH_INSTANCE CrashInstance,
    OUT PLONG32     InstanceID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_SOLUTION)(
    IN LONG32   SolutionID,
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK CallBack,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_SOLUTION)(
    IN  PKADB_SOLUTION Solution,
    OUT PLONG32     SolutionID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_UPDATE_SOLUTION)(
    IN UINT64   UpdateFlags,
    IN LONG32   SolutionID,
    IN PKADB_SOLUTION Solution,
    IN PVOID    Reserved,
    IN UINT_PTR Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_ANALYSIS)(
    IN LONG32   AnalysisID,
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK Callback,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_ANALYSIS)(
    IN  PKADB_ANALYSIS Analysis,
    OUT PLONG32     AnalysisID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_UPDATE_ANALYSIS)(
    IN UINT64   UpdateFlags,
    IN LONG32   AnalysisID,
    IN PKADB_ANALYSIS AnalysisData,
    IN PVOID    Reserved,
    IN UINT_PTR Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_HWPROFILE)(
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK CallBack,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_HWPROFILE)(
    IN  PKADB_HW_PROFILE HwProfile,
    OUT PLONG32     HWProfileRecID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_UPDATE_HWPROFILE_OCCURRENCECOUNT)(
    IN LONG32   HWProfileRecID,
    IN PVOID    Reserved,
    IN UINT_PTR Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_OSPROFILE)(
    IN LPCWSTR  MatchSTR,
    IN PKADB_ENUM_DATA_CALLBACK CallBack,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_OSPROFILE)(
    IN PKADB_OS_PROFILE OSProfile,
    OUT PLONG32 OSProfileRecID,
    IN PVOID    Reserved,
    IN UINT_PTR Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_UPDATE_OSPROFILE_OCCURRENCECOUNT)(
    IN LONG32   OSProfileRecID,
    IN PVOID    Reserved,
    IN UINT_PTR Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_HINTDATA)(
    IN LONG32   SolutionID,
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK Callback,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_HINTDATA)(
    IN  LONG32      SolutionID,
    IN  PKADB_HINT_DATA HintData,
    OUT PLONG32     DataID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_UPDATE_HINTDATA)(
    IN  UINT64      UpdateFlags,
    IN  LONG32      DataID,
    IN  LONG32      SolutionID,
    IN  PKADB_HINT_DATA pHintData,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_PROGRESSTEXT)(
    IN LONG32   AnalysisID,
    IN PKADB_ENUM_DATA_CALLBACK Callback,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_PROGRESSTEXT)(
    IN  LONG32      AnalysisID,
    IN  PKADB_PROGRESS_TEXT ProgressText,
    OUT PLONG32     ProgressTextID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_KERNELMODULEDATA)(
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK CallBack,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_KERNELMODULEDATA)(
    IN  PKADB_KERNEL_MODULE_DATA KernelModuleData,
    OUT PLONG32     KernelModuleID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_KERNEL_MODULE)(
    IN LONG32   ClassID,
    IN LONG32   InstanceID,
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK Callback,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_KERNELMODULE)(
    IN LONG32   ClassID,
    IN LONG32   InstanceID,
    IN LONG32   KernelModuleID,
    IN PKADB_KERNEL_MODULE KernelModule,
    IN PVOID    Reserved,
    IN UINT_PTR Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_KANALYZEMODULEDATA)(
    IN LPCWSTR  MatchStr,
    IN PKADB_ENUM_DATA_CALLBACK CallBack,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_KANALYZEMODULEDATA)(
    IN  PKADB_KANALYZE_MODULE_DATA KanalyzeModuleData,
    OUT PLONG32     KanalyzeModuleID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_KANALYZE_MODULE)(
    IN LONG32   ClassID,
    IN LONG32   InstanceID,
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK Callback,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_KANALYZEMODULE)(
    IN LONG32   ClassID,
    IN LONG32   InstanceID,
    IN LONG32   KanalyzeModuleID,
    IN PVOID Reserved,
    IN UINT_PTR Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_ATTACHMENTDATA)(
    IN LONG32   ClassID,
    IN LONG32   InstanceID,
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK CallBack,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_ATTACHMENTDATA)(
    IN  LONG32      ClassID,
    IN  LONG32      InstanceID,
    IN  PKADB_ATTACHMENT_DATA AttachmentData,
    OUT PLONG32     ItemID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_VARIABLECRASHDATA)(
    IN LONG32   ClassID,
    IN LONG32   InstanceID,
    IN LPCWSTR  MatchString,
    IN PKADB_ENUM_DATA_CALLBACK CallBack,
    IN PVOID    CallbackParam,
    IN UINT_PTR Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_ADD_VARIABLECRASHDATA)(
    IN LONG32   ClassID,
    IN LONG32   InstanceID,
    IN PKADB_VARIABLE_CRASH_DATA VariableCrashData,
    IN PVOID    Reserved,
    IN UINT_PTR Reserved2
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_CRASHCLASS_CRASHINSTANCE)(
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_PROCESSOR_TYPE_PROCESSOR_VENDOR)(
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

typedef
BOOL
(CALLBACK *PDATABASE_GET_LAST_ERROR)(
    IN PKADB_ENUM_DATA_CALLBACK Callback
    );

typedef
LPWSTR
(CALLBACK *PDATABASE_BUILD_HWPROFILE_MATCHSTRING)(
    IN PKADB_HW_PROFILE HWProfile
    );

typedef
LPWSTR
(CALLBACK *PDATABASE_BUILD_OSPROFILE_MATCHSTR)(
    IN PKADB_OS_PROFILE OSProfile
    );

typedef
LPWSTR
(CALLBACK *PDATABASE_BUILD_KERNELMODULEDATA_MATCHSTR)(
    IN PKADB_KERNEL_MODULE_DATA KernelModuleData
    );

typedef
LPWSTR
(CALLBACK *PDATABASE_BUILD_KANALYZEMODULEDATA_MATCHSTR)(
    IN PKADB_KANALYZE_MODULE_DATA KanalyzeModuleData
    );

typedef struct _DATABASE_PROVIDER_APIS {
    SIZE_T size;
    PDATABASE_INITIALIZE                        DpInitialize;
    PDATABASE_CLEANUP                           DpCleanup;
    PDATABASE_OPEN_CONNECTION                   DpOpenConnection;
    PDATABASE_CLOSE_CONNECTION                  DpCloseConnection;
    PDATABASE_START_TRANSACTION                 DpStartTransaction;
    PDATABASE_ROLLBACK_TRANSACTION              DpRollBackTransaction;
    PDATABASE_COMMIT_TRANSACTION                DpCommitTransaction;
    PDATABASE_GET_CRASH_CLASS                   DpGetCrashClass;
    PDATABASE_ADD_CRASH_CLASS                   DpAddCrashClass;
    PDATABASE_UPDATE_CRASH_CLASS                DpUpdateCrashClass;
    PDATABASE_GET_CRASH_INSTANCE                DpGetCrashInstance;
    PDATABASE_ADD_CRASH_INSTANCE                DpAddCrashInstance;
    PDATABASE_GET_SOLUTION                      DpGetSolution;
    PDATABASE_ADD_SOLUTION                      DpAddSolution;
    PDATABASE_UPDATE_SOLUTION                   DpUpdateSolution;
    PDATABASE_GET_ANALYSIS                      DpGetAnalysis;
    PDATABASE_ADD_ANALYSIS                      DpAddAnalysis;
    PDATABASE_UPDATE_ANALYSIS                   DpUpdateAnalysis;
    PDATABASE_GET_HWPROFILE                     DpGetHWProfile;
    PDATABASE_ADD_HWPROFILE                     DpAddHWProfile;
    PDATABASE_UPDATE_HWPROFILE_OCCURRENCECOUNT  DpUpdateHWProfileOccurrenceCount;
    PDATABASE_GET_OSPROFILE                     DpGetOSProfile;
    PDATABASE_ADD_OSPROFILE                     DpAddOSProfile;
    PDATABASE_UPDATE_OSPROFILE_OCCURRENCECOUNT  DpUpdateOSProfileOccurrenceCount;
    PDATABASE_GET_HINTDATA                      DpGetHintData;
    PDATABASE_ADD_HINTDATA                      DpAddHintData;
    PDATABASE_UPDATE_HINTDATA                   DpUpdateHintData;
    PDATABASE_GET_PROGRESSTEXT                  DpGetProgressText;
    PDATABASE_ADD_PROGRESSTEXT                  DpAddProgressText;
    PDATABASE_GET_KERNELMODULEDATA              DpGetKernelModuleData;
    PDATABASE_ADD_KERNELMODULEDATA              DpAddKernelModuleData;
    PDATABASE_GET_KERNEL_MODULE                 DpGetKernelModule;
    PDATABASE_ADD_KERNELMODULE                  DpAddKernelModule;
    PDATABASE_GET_KANALYZEMODULEDATA            DpGetKanalyzeModuleData;
    PDATABASE_ADD_KANALYZEMODULEDATA            DpAddKanalyzeModuleData;
    PDATABASE_GET_KANALYZE_MODULE               DpGetKanalyzeModule;
    PDATABASE_ADD_KANALYZEMODULE                DpAddKanalyzeModule;
    PDATABASE_GET_ATTACHMENTDATA                DpGetAttachmentData;
    PDATABASE_ADD_ATTACHMENTDATA                DpAddAttachmentData;
    PDATABASE_GET_VARIABLECRASHDATA             DpGetVariableCrashData;
    PDATABASE_ADD_VARIABLECRASHDATA             DpAddVariableCrashData;
    PDATABASE_GET_LAST_ERROR                    DpGetLastError;
    PDATABASE_BUILD_HWPROFILE_MATCHSTRING       DpBuildHWProfileMatchString;
    PDATABASE_BUILD_OSPROFILE_MATCHSTR          DpBuildOSProfileMatchStr;
    PDATABASE_BUILD_KERNELMODULEDATA_MATCHSTR   DpBuildKernelModuleDataMatchStr;
    PDATABASE_BUILD_KANALYZEMODULEDATA_MATCHSTR DpBuildKanalyzeModuleDataMatchStr;
    PDATABASE_GET_CRASHCLASS_CRASHINSTANCE      DpGetCrashClassCrashInstance;
    PDATABASE_GET_PROCESSOR_TYPE_PROCESSOR_VENDOR DpGetProcessorTypeProcessorVendor;
} DATABASE_PROVIDER_APIS, *PDATABASE_PROVIDER_APIS;


#ifdef DB_APIS

extern PDATABASE_PROVIDER_APIS DatabaseProviderApis;       // database private helper routine table

#define DbInitialize                        (DatabaseProviderApis->DpInitialize)
#define DbCleanup                           (DatabaseProviderApis->DpCleanup)
#define DbOpenConnection                    (DatabaseProviderApis->DpOpenConnection)
#define DbCloseConnection                   (DatabaseProviderApis->DpCloseConnection)
#define DbStartTransaction                  (DatabaseProviderApis->DpStartTransaction)
#define DbRollBackTransaction               (DatabaseProviderApis->DpRollBackTransaction)
#define DbCommitTransaction                 (DatabaseProviderApis->DpCommitTransaction)
#define DbGetCrashClass                     (DatabaseProviderApis->DpGetCrashClass)
#define DbAddCrashClass                     (DatabaseProviderApis->DpAddCrashClass)
#define DbUpdateCrashClass                  (DatabaseProviderApis->DpUpdateCrashClass)
#define DbGetCrashInstance                  (DatabaseProviderApis->DpGetCrashInstance)
#define DbAddCrashInstance                  (DatabaseProviderApis->DpAddCrashInstance)
#define DbGetSolution                       (DatabaseProviderApis->DpGetSolution)
#define DbAddSolution                       (DatabaseProviderApis->DpAddSolution)
#define DbUpdateSolution                    (DatabaseProviderApis->DpUpdateSolution)
#define DbGetAnalysis                       (DatabaseProviderApis->DpGetAnalysis)
#define DbAddAnalysis                       (DatabaseProviderApis->DpAddAnalysis)
#define DbUpdateAnalysis                    (DatabaseProviderApis->DpUpdateAnalysis)
#define DbGetHWProfile                      (DatabaseProviderApis->DpGetHWProfile)
#define DbAddHWProfile                      (DatabaseProviderApis->DpAddHWProfile)
#define DbUpdateHWProfileOccurrenceCount    (DatabaseProviderApis->DpUpdateHWProfileOccurrenceCount)
#define DbGetOSProfile                      (DatabaseProviderApis->DpGetOSProfile)
#define DbAddOSProfile                      (DatabaseProviderApis->DpAddOSProfile)
#define DbUpdateOSProfileOccurrenceCount    (DatabaseProviderApis->DpUpdateOSProfileOccurrenceCount)
#define DbGetHintData                       (DatabaseProviderApis->DpGetHintData)
#define DbAddHintData                       (DatabaseProviderApis->DpAddHintData)
#define DbUpdateHintData                    (DatabaseProviderApis->DpUpdateHintData)
#define DbGetProgressText                   (DatabaseProviderApis->DpGetProgressText)
#define DbAddProgressText                   (DatabaseProviderApis->DpAddProgressText)
#define DbGetKernelModuleData               (DatabaseProviderApis->DpGetKernelModuleData)
#define DbAddKernelModuleData               (DatabaseProviderApis->DpAddKernelModuleData)
#define DbGetKernelModule                   (DatabaseProviderApis->DpGetKernelModule)
#define DbAddKernelModule                   (DatabaseProviderApis->DpAddKernelModule)
#define DbGetKanalyzeModuleData             (DatabaseProviderApis->DpGetKanalyzeModuleData)
#define DbAddKanalyzeModuleData             (DatabaseProviderApis->DpAddKanalyzeModuleData)
#define DbGetKanalyzeModule                 (DatabaseProviderApis->DpGetKanalyzeModule)
#define DbAddKanalyzeModule                 (DatabaseProviderApis->DpAddKanalyzeModule)
#define DbGetAttachmentData                 (DatabaseProviderApis->DpGetAttachmentData)
#define DbAddAttachmentData                 (DatabaseProviderApis->DpAddAttachmentData)
#define DbGetVariableCrashData              (DatabaseProviderApis->DpGetVariableCrashData)
#define DbAddVariableCrashData              (DatabaseProviderApis->DpAddVariableCrashData)
#define DbGetLastError                      (DatabaseProviderApis->DpGetLastError)
#define DbBuildHWProfileMatchString         (DatabaseProviderApis->DpBuildHWProfileMatchString)
#define DbBuildOSProfileMatchStr            (DatabaseProviderApis->DpBuildOSProfileMatchStr)
#define DbBuildKernelModuleDataMatchStr     (DatabaseProviderApis->DpBuildKernelModuleDataMatchStr)
#define DbBuildKanalyzeModuleDataMatchStr   (DatabaseProviderApis->DpBuildKanalyzeModuleDataMatchStr)
#define DbGetCrashClassCrashInstance        (DatabaseProviderApis->DpGetCrashClassCrashInstance)
#define DbGetProcessorTypeProcessorVendor   (DatabaseProviderApis->DpGetProcessorTypeProcessorVendor)

#endif // DB_APIS


////////////////////////////////////////////////////////////////
//
// Macros for convert the value between database and sigid file.
//
////////////////////////////////////////////////////////////////

// Compare specified two strings.
#define STREQ(_str1, _str2)  (_strnicmp(_str1, _str2, strlen(_str2)) == 0)
#define WSTREQ(_str1, _str2) (_wcsnicmp(_str1, _str2, wcslen(_str2)) == 0)

//
// Architecture in HWProfile.
//
// Definitions for architecture name.
#define ARCHITECTURE_NAME_X86_A         "x86"
#define ARCHITECTURE_NAME_UNKNOWN_A     "unknown"
#define ARCHITECTURE_NAME_X86_W         L"x86"
#define ARCHITECTURE_NAME_UNKNOWN_W     L"unknown"

/*
VOID
KADB_GET_PLATFORM_A(
    IN LPCSTR _name,
    OUT DWORD _type
    );

Routine Description:

    This routine is used to convert platform name to platform type.

Arguments:

    _name - specify the platform name in LPCSTR.
    _type - return the platform type in DWORD.

Return Value:

    None.

*/
#define KADB_GET_PLATFORM_A(_name, _type)           \
    if (STREQ(_name, ARCHITECTURE_NAME_X86_A)) {    \
        _type = IMAGE_FILE_MACHINE_I386;            \
    } else                                          \
    {                                               \
        _type = IMAGE_FILE_MACHINE_UNKNOWN;         \
    }

/*
VOID
KADB_GET_PLATFORM_W(
    IN LPCWSTR _name,
    OUT DWORD _type
    );

Routine Description:

    This routine is used to convert platform name to platform type.

Arguments:

    _name - specify the platform name in LPCWSTR.
    _type - return the platform type in DWORD.

Return Value:

    None.

*/
#define KADB_GET_PLATFORM_W(_name, _type)           \
    if (WSTREQ(_name, ARCHITECTURE_NAME_X86_W)) {   \
        _type = IMAGE_FILE_MACHINE_I386;            \
    } else                                          \
    {                                               \
        _type = IMAGE_FILE_MACHINE_UNKNOWN;         \
    }

/*
VOID
KADB_SET_PLATFORM_A(
    IN DWORD _type,
    OUT LPSTR _name
    );

Routine Description:

    This routine is used to convert platform type to platform name.

Arguments:

    _type - specify the platform type in DWORD.
    _name - return the platform name in LPSTR.

Return Value:

    None.

*/
#define KADB_SET_PLATFORM_A(_type, _name)                   \
    switch (_type) {                                        \
        case IMAGE_FILE_MACHINE_I386:                       \
            strcpy(_name, ARCHITECTURE_NAME_X86_A);         \
            break;                                          \
        default:                                            \
            strcpy(_name, ARCHITECTURE_NAME_UNKNOWN_A);     \
            break;                                          \
    }

/*
VOID
KADB_SET_PLATFORM_W(
    IN DWORD _type,
    OUT LPWSTR _name
    );

Routine Description:

    This routine is used to convert platform type to platform name.

Arguments:

    _type - specify the platform type in DWORD.
    _name - return the platform name in LPWSTR.

Return Value:

    None.

*/
#define KADB_SET_PLATFORM_W(_type, _name)                   \
    switch (_type) {                                        \
        case IMAGE_FILE_MACHINE_I386:                       \
            wcscpy(_name, ARCHITECTURE_NAME_X86_W);         \
            break;                                          \
        default:                                            \
            wcscpy(_name, ARCHITECTURE_NAME_UNKNOWN_W);     \
            break;                                          \
    }

//
// ProductType in OSProfile.
//
// Definitions for os product name.
#define OS_PRODUCT_NAME_WORKSTATION_A     "wrkstation"
#define OS_PRODUCT_NAME_SERVER_UNSPEC_A   "SrvUnknown"
#define OS_PRODUCT_NAME_SERVER_A          "Server"
#define OS_PRODUCT_NAME_ADVSERVER_A       "AdvSrv"
#define OS_PRODUCT_NAME_DATACENTER_A      "DataCentr"
#define OS_PRODUCT_NAME_HYDRA_A           "Hydra"
#define OS_PRODUCT_NAME_SMALBIZ_A         "SmlBizSrv"
#define OS_PRODUCT_NAME_UNSPEC_A          "unknown"

#define OS_PRODUCT_NAME_WORKSTATION_W     L"wrkstation"
#define OS_PRODUCT_NAME_SERVER_UNSPEC_W   L"SrvUnknown"
#define OS_PRODUCT_NAME_SERVER_W          L"Server"
#define OS_PRODUCT_NAME_ADVSERVER_W       L"AdvSrv"
#define OS_PRODUCT_NAME_DATACENTER_W      L"DataCentr"
#define OS_PRODUCT_NAME_HYDRA_W           L"Hydra"
#define OS_PRODUCT_NAME_SMALBIZ_W         L"SmlBizSrv"
#define OS_PRODUCT_NAME_UNSPEC_W          L"unknown"

/*
VOID
KADB_GET_OS_TYPE_A(
    IN LPCSTR _name,
    OUT DWORD _type
    );

Routine Description:

    This routine is used to convert os product name to os product type.

Arguments:

    _name - specify the os product name in LPCSTR.
    _type - return the os product type in DWORD.

Return Value:

    None.

*/
#define KADB_GET_OS_TYPE_A(_name, _type)                    \
    if (STREQ(_name, OS_PRODUCT_NAME_WORKSTATION_A)) {      \
         _type = SIGIDFILE_PRODUCT_WORKSTATION;             \
    } else                                                  \
    if (STREQ(_name, OS_PRODUCT_NAME_SERVER_A)) {           \
        _type = SIGIDFILE_PRODUCT_SERVER;                   \
    } else                                                  \
    if (STREQ(_name, OS_PRODUCT_NAME_SERVER_UNSPEC_A)) {    \
        _type = SIGIDFILE_PRODUCT_SERVER_UNSPEC;            \
    } else                                                  \
    if (STREQ(_name, OS_PRODUCT_NAME_ADVSERVER_A)) {        \
        _type = SIGIDFILE_PRODUCT_ADVSERVER;                \
    } else                                                  \
    if (STREQ(_name, OS_PRODUCT_NAME_DATACENTER_A)) {       \
        _type = SIGIDFILE_PRODUCT_DATACENTER;               \
    } else                                                  \
    if (STREQ(_name, OS_PRODUCT_NAME_HYDRA_A)) {            \
        _type = SIGIDFILE_PRODUCT_HYDRA;                    \
    } else                                                  \
    if (STREQ(_name, OS_PRODUCT_NAME_SMALBIZ_A)) {          \
        _type = SIGIDFILE_PRODUCT_SMALLBIZ;                 \
    } else {                                                \
        _type = SIGIDFILE_PRODUCT_UNSPEC;                   \
    }

/*
VOID
KADB_GET_OS_TYPE_W(
    IN LPCWSTR _name,
    OUT DWORD _type
    );

Routine Description:

    This routine is used to convert os product name to os product type.

Arguments:

    _name - specify the os product name in LPCWSTR.
    _type - return the os product type in DWORD.

Return Value:

    None.

*/
#define KADB_GET_OS_TYPE_W(_name, _type)                    \
    if (WSTREQ(_name, OS_PRODUCT_NAME_WORKSTATION_W)) {     \
         _type = SIGIDFILE_PRODUCT_WORKSTATION;             \
    } else                                                  \
    if (WSTREQ(_name, OS_PRODUCT_NAME_SERVER_W)) {          \
        _type = SIGIDFILE_PRODUCT_SERVER;                   \
    } else                                                  \
    if (WSTREQ(_name, OS_PRODUCT_NAME_SERVER_UNSPEC_W)) {   \
        _type = SIGIDFILE_PRODUCT_SERVER_UNSPEC;            \
    } else                                                  \
    if (WSTREQ(_name, OS_PRODUCT_NAME_ADVSERVER_W)) {       \
        _type = SIGIDFILE_PRODUCT_ADVSERVER;                \
    } else                                                  \
    if (WSTREQ(_name, OS_PRODUCT_NAME_DATACENTER_W)) {      \
        _type = SIGIDFILE_PRODUCT_DATACENTER;               \
    } else                                                  \
    if (WSTREQ(_name, OS_PRODUCT_NAME_HYDRA_W)) {           \
        _type = SIGIDFILE_PRODUCT_HYDRA;                    \
    } else                                                  \
    if (WSTREQ(_name, OS_PRODUCT_NAME_SMALBIZ_W)) {         \
        _type = SIGIDFILE_PRODUCT_SMALLBIZ;                 \
    } else {                                                \
        _type = SIGIDFILE_PRODUCT_UNSPEC;                   \
    }

/*
VOID
KADB_SET_OS_TYPE_A(
    IN DWORD _type,
    OUT LPSTR _name
    );

Routine Description:

    This routine is used to convert os product type to os product name.

Arguments:

    _type - specify the os product type in DWORD.
    _name - return the os product name in LPSTR.

Return Value:

    None.

*/
#define KADB_SET_OS_TYPE_A(_type, _name)                    \
    switch (_type) {                                        \
        case SIGIDFILE_PRODUCT_WORKSTATION:                 \
            strcpy(_name, OS_PRODUCT_NAME_WORKSTATION_A);   \
            break;                                          \
        case SIGIDFILE_PRODUCT_SERVER:                      \
            strcpy(_name, OS_PRODUCT_NAME_SERVER_A);        \
            break;                                          \
        case SIGIDFILE_PRODUCT_SERVER_UNSPEC:               \
            strcpy(_name, OS_PRODUCT_NAME_SERVER_UNSPEC_A); \
            break;                                          \
        case SIGIDFILE_PRODUCT_ADVSERVER:                   \
            strcpy(_name, OS_PRODUCT_NAME_ADVSERVER_A);     \
            break;                                          \
        case SIGIDFILE_PRODUCT_DATACENTER:                  \
            strcpy(_name, OS_PRODUCT_NAME_DATACENTER_A);    \
            break;                                          \
        case SIGIDFILE_PRODUCT_HYDRA:                       \
            strcpy(_name, OS_PRODUCT_NAME_HYDRA_A);         \
            break;                                          \
        case SIGIDFILE_PRODUCT_SMALLBIZ:                    \
            strcpy(_name, OS_PRODUCT_NAME_SMALBIZ_A);       \
            break;                                          \
        default:                                            \
            strcpy(_name, OS_PRODUCT_NAME_UNSPEC_A);        \
            break;                                          \
    }

/*
VOID
KADB_SET_OS_TYPE_W(
    IN DWORD _type,
    OUT LPWSTR _name
    );

Routine Description:

    This routine is used to convert os product type to os product name.

Arguments:

    _type - specify the os product type in DWORD.
    _name - return the os product name in LPWSTR.

Return Value:

    None.

*/
#define KADB_SET_OS_TYPE_W(_type, _name)                    \
    switch (_type) {                                        \
        case SIGIDFILE_PRODUCT_WORKSTATION:                 \
            wcscpy(_name, OS_PRODUCT_NAME_WORKSTATION_W);   \
            break;                                          \
        case SIGIDFILE_PRODUCT_SERVER:                      \
            wcscpy(_name, OS_PRODUCT_NAME_SERVER_W);        \
            break;                                          \
        case SIGIDFILE_PRODUCT_SERVER_UNSPEC:               \
            wcscpy(_name, OS_PRODUCT_NAME_SERVER_UNSPEC_W); \
            break;                                          \
        case SIGIDFILE_PRODUCT_ADVSERVER:                   \
            wcscpy(_name, OS_PRODUCT_NAME_ADVSERVER_W);     \
            break;                                          \
        case SIGIDFILE_PRODUCT_DATACENTER:                  \
            wcscpy(_name, OS_PRODUCT_NAME_DATACENTER_W);    \
            break;                                          \
        case SIGIDFILE_PRODUCT_HYDRA:                       \
            wcscpy(_name, OS_PRODUCT_NAME_HYDRA_W);         \
            break;                                          \
        case SIGIDFILE_PRODUCT_SMALLBIZ:                    \
            wcscpy(_name, OS_PRODUCT_NAME_SMALBIZ_W);       \
            break;                                          \
        default:                                            \
            wcscpy(_name, OS_PRODUCT_NAME_UNSPEC_W);        \
            break;                                          \
    }


//
// Type in KanalyzeModuleData.
//
// Definitions for kanalyze type name.
#define KANALYZE_TYPE_NAME_MASTER_A     "Master"
#define KANALYZE_TYPE_NAME_PLUGIN_A     "Plugin"
#define KANALYZE_TYPE_NAME_DLL_A        "DLL"
#define KANALYZE_TYPE_NAME_OTHER_A      "Other"

#define KANALYZE_TYPE_NAME_MASTER_W     L"Master"
#define KANALYZE_TYPE_NAME_PLUGIN_W     L"Plugin"
#define KANALYZE_TYPE_NAME_DLL_W        L"DLL"
#define KANALYZE_TYPE_NAME_OTHER_W      L"Other"

/*
VOID
KADB_GET_KANALYZE_TYPE_A(
    IN LPCSTR _name,
    OUT DWORD _type
    );

Routine Description:

    This routine is used to convert kanalyze type name to kanalyze type.

Arguments:

    _name - specify the kanalyze type name in LPCSTR.
    _type - return the kanalyze type in DWORD.

Return Value:

    None.

*/
#define KADB_GET_KANALYZE_TYPE_A(_name, _type)          \
    if (STREQ(_name, KANALYZE_TYPE_NAME_MASTER_A)) {    \
         _type = SIGIDFILE_KANALYZE_MODULE_MASTER;      \
    } else                                              \
    if (STREQ(_name, KANALYZE_TYPE_NAME_PLUGIN_A)) {    \
        _type = SIGIDFILE_KANALYZE_MODULE_PLUGIN;       \
    } else                                              \
    if (STREQ(_name, KANALYZE_TYPE_NAME_DLL_A)) {       \
        _type = SIGIDFILE_KANALYZE_MODULE_DLL;          \
    } else {                                            \
        _type = SIGIDFILE_KANALYZE_MODULE_OTHER;        \
    }

/*
VOID
KADB_GET_KANALYZE_TYPE_W(
    IN LPCWSTR _name,
    OUT DWORD _type
    );

Routine Description:

    This routine is used to convert kanalyze type name to kanalyze type.

Arguments:

    _name - specify the kanalyze type name in LPCWSTR.
    _type - return the platform type in DWORD.

Return Value:

    None.

*/
#define KADB_GET_KANALYZE_TYPE_W(_name, _type)          \
    if (WSTREQ(_name, KANALYZE_TYPE_NAME_MASTER_W)) {   \
         _type = SIGIDFILE_KANALYZE_MODULE_MASTER;      \
    } else                                              \
    if (WSTREQ(_name, KANALYZE_TYPE_NAME_PLUGIN_W)) {   \
        _type = SIGIDFILE_KANALYZE_MODULE_PLUGIN;       \
    } else                                              \
    if (WSTREQ(_name, KANALYZE_TYPE_NAME_DLL_W)) {      \
        _type = SIGIDFILE_KANALYZE_MODULE_DLL;          \
    } else {                                            \
        _type = SIGIDFILE_KANALYZE_MODULE_OTHER;        \
    }

/*
VOID
KADB_SET_KANALYZE_TYPE_A(
    IN DWORD _type,
    OUT LPSTR _name
    );

Routine Description:

    This routine is used to convert kanalyze type to kanalyze type name.

Arguments:

    _type - specify the kanalyze type in DWORD.
    _name - return the kanalyze type name in LPSTR.

Return Value:

    None.

*/
#define KADB_SET_KANALYZE_TYPE_A(_type, _name)              \
    switch (_type) {                                        \
        case SIGIDFILE_KANALYZE_MODULE_MASTER:              \
            strcpy(_name, KANALYZE_TYPE_NAME_MASTER_A);     \
            break;                                          \
        case SIGIDFILE_KANALYZE_MODULE_PLUGIN:              \
            strcpy(_name, KANALYZE_TYPE_NAME_PLUGIN_A);     \
            break;                                          \
        case SIGIDFILE_KANALYZE_MODULE_DLL:                 \
            strcpy(_name, KANALYZE_TYPE_NAME_DLL_A);        \
            break;                                          \
        default:                                            \
            strcpy(_name, KANALYZE_TYPE_NAME_OTHER_A);      \
            break;                                          \
    }

/*
VOID
KADB_SET_KANALYZE_TYPE_W(
    IN DWORD _type,
    OUT LPWSTR _name
    );

Routine Description:

    This routine is used to convert kanalyze type to kanalyze type name.

Arguments:

    _type - specify the kanalyze type in DWORD.
    _name - return the kanalyze type name in LPWSTR.

Return Value:

    None.

*/
#define KADB_SET_KANALYZE_TYPE_W(_type, _name)              \
    switch (_type) {                                        \
        case SIGIDFILE_KANALYZE_MODULE_MASTER:              \
            wcscpy(_name, KANALYZE_TYPE_NAME_MASTER_W);     \
            break;                                          \
        case SIGIDFILE_KANALYZE_MODULE_PLUGIN:              \
            wcscpy(_name, KANALYZE_TYPE_NAME_PLUGIN_W);     \
            break;                                          \
        case SIGIDFILE_KANALYZE_MODULE_DLL:                 \
            wcscpy(_name, KANALYZE_TYPE_NAME_DLL_W);        \
            break;                                          \
        default:                                            \
            wcscpy(_name, KANALYZE_TYPE_NAME_OTHER_W);      \
            break;                                          \
    }


typedef struct _QUERY_PROCESSOR_INFO {
    QUERY_PTYPE_INFO_A ProcessorTypeInfoA;
    QUERY_PTYPE_INFO_W ProcessorTypeInfoW;
    QUERY_PVENDOR_INFO_A ProcessorVendorInfoA;
    QUERY_PVENDOR_INFO_W ProcessorVendorInfoW;
} QUERY_PROCESSOR_INFO, *PQUERY_PROCESSOR_INFO;

#ifdef KA_EXTAPI
#ifdef QUERY_PINFO
extern QUERY_PROCESSOR_INFO QueryProcessorInfo;

/*
VOID
KADB_SET_PROCESSOR_TYPE_A(
    IN HKAPLUGIN _hp,
    IN USHORT _vendor,
    IN USHORT _family,
    IN USHORT _model,
    IN USHORT _step,
    OUT LPSTR _type
    );

Routine Description:

    This routine is used to convert processor vendor/family/model/step to processor name.

Arguments:

    _hp - specify the caller's plug-in handle.
    _vendor - specify the processor vendor
    _family - specify the processor type
    _model - specify the processor model
    _step - specify the processor spec, if this is -1, then ignored.
    _type - return the processor type in LPSTR. Caller should alloc/free this buffer.

Return Value:

    None.

*/
#define KADB_SET_PROCESSOR_TYPE_A(_hp, _vendor, _family, _model, _step, _type)  \
{ \
    QueryProcessorInfo.ProcessorTypeInfoA.VendorID  = _vendor;      \
    QueryProcessorInfo.ProcessorTypeInfoA.Family    = _family;      \
    QueryProcessorInfo.ProcessorTypeInfoA.Model     = _model;       \
    QueryProcessorInfo.ProcessorTypeInfoA.Step      = _step;        \
    QueryProcessorInfo.ProcessorTypeInfoA.Type      = _type;        \
    KxCallPlugIn(_hp,                                               \
                 PLUGIN_QUERY,                                      \
                 P_QUERY_SET_PROCESSOR_TYPE_A,                      \
                 0,                                                 \
                 (UINT_PTR)&QueryProcessorInfo.ProcessorTypeInfoA,  \
                 NULL);                                             \
}


/*
VOID
KADB_SET_PROCESSOR_TYPE_A(
    IN HKAPLUGIN _hp,
    IN USHORT _vendor,
    IN USHORT _family,
    IN USHORT _model,
    IN USHORT _step,
    OUT LPWSTR _type
    );

Routine Description:

    This routine is used to convert processor vendor/family/model/step to processor name.

Arguments:

    _hp - specify the caller's plug-in handle.
    _vendor - specify the processor vendor
    _family - specify the processor type
    _model - specify the processor model
    _step - specify the processor spec, if this is -1, then ignored.
    _type - return the processor type in LPWSTR. Caller should alloc/free this buffer.

Return Value:

    None.

*/
#define KADB_SET_PROCESSOR_TYPE_W(_hp, _vendor, _family, _model, _step, _type)  \
{ \
    QueryProcessorInfo.ProcessorTypeInfoW.VendorID  = _vendor;      \
    QueryProcessorInfo.ProcessorTypeInfoW.Family    = _family;      \
    QueryProcessorInfo.ProcessorTypeInfoW.Model     = _model;       \
    QueryProcessorInfo.ProcessorTypeInfoW.Step      = _step;        \
    QueryProcessorInfo.ProcessorTypeInfoW.Type      = _type;        \
    KxCallPlugIn(_hp,                                               \
                 PLUGIN_QUERY,                                      \
                 P_QUERY_SET_PROCESSOR_TYPE_W,                      \
                 0,                                                 \
                 (UINT_PTR)&QueryProcessorInfo.ProcessorTypeInfoW,  \
                 NULL);                                             \
}


/*
VOID
KADB_GET_PROCESSOR_TYPE_A(
    IN HKAPLUGIN _hp,
    IN LPCSTR _type,
    OUT USHORT _family
    );

Routine Description:

    This routine is used to convert processor name to processor family.

Arguments:

    _hp - specify the caller's plug-in handle.
    _type - specify the processor name in LPCSTR.
    _family - return the processor family in DWORD.

Return Value:

    None.

*/
#define KADB_GET_PROCESSOR_TYPE_A(_hp, _type, _family)  \
{ \
    QueryProcessorInfo.ProcessorTypeInfoA.Type = _type;             \
    KxCallPlugIn(_hp,                                               \
                 PLUGIN_QUERY,                                      \
                 P_QUERY_GET_PROCESSOR_TYPE_A,                      \
                 0,                                                 \
                 (UINT_PTR)&QueryProcessorInfo.ProcessorTypeInfoA,  \
                 NULL);                                             \
    _family = QueryProcessorInfo.ProcessorTypeInfoA.Family;         \
}


/*
VOID
KADB_GET_PROCESSOR_TYPE_A(
    IN HKAPLUGIN _hp,
    IN LPCWSTR _type,
    OUT DWORD _family
    );

Routine Description:

    This routine is used to convert processor name to processor family.

Arguments:

    _hp - specify the caller's plug-in handle.
    _type - specify the processor name in LPCWSTR.
    _family - return the processor family in DWORD.

Return Value:

    None.

*/
#define KADB_GET_PROCESSOR_TYPE_W(_hp, _type, _family)  \
{ \
    QueryProcessorInfo.ProcessorTypeInfoW.Type = _type;             \
    KxCallPlugIn(_hp,                                               \
                 PLUGIN_QUERY,                                      \
                 P_QUERY_GET_PROCESSOR_TYPE_W,                      \
                 0,                                                 \
                 (UINT_PTR)&QueryProcessorInfo.ProcessorTypeInfoW,  \
                 NULL);                                             \
    _family = QueryProcessorInfo.ProcessorTypeInfoW.Family;         \
}


/*
VOID
KADB_SET_PROCESSOR_VENDOR_A(
    IN HKAPLUGIN _hp,
    IN DWORD _id,
    OUT LPSTR _name
    );

Routine Description:

    This routine is used to convert processor vendor type to processor vendor name.

Arguments:

    _hp - specify the caller's plug-in handle.
    _id - specify the processor vendor type in DWORD.
    _name - return the processor vendor name in LPSTR. Caller should alloc/free this buffer.

Return Value:

    None.

*/
#define KADB_SET_PROCESSOR_VENDOR_A(_hp, _id, _name)    \
{ \
    QueryProcessorInfo.ProcessorVendorInfoA.VendorID = _id;             \
    QueryProcessorInfo.ProcessorVendorInfoA.VendorName = _name;         \
    KxCallPlugIn(_hp,                                                   \
                 PLUGIN_QUERY,                                          \
                 P_QUERY_SET_PROCESSOR_VENDOR_A,                        \
                 0,                                                     \
                 (UINT_PTR)&QueryProcessorInfo.ProcessorVendorInfoA,    \
                 NULL);                                                 \
}


/*
VOID
KADB_SET_PROCESSOR_VENDOR_A(
    IN HKAPLUGIN _hp,
    IN DWORD _id,
    OUT LPWSTR _name
    );

Routine Description:

    This routine is used to convert processor vendor type to processor vendor name.

Arguments:

    _hp - specify the caller's plug-in handle.
    _id - specify the processor vendor type in DWORD.
    _name - return the processor vendor name in LPWSTR. Caller should alloc/free this buffer.

Return Value:

    None.

*/
#define KADB_SET_PROCESSOR_VENDOR_W(_hp, _id, _name)    \
{ \
    QueryProcessorInfo.ProcessorVendorInfoW.VendorID = _id;             \
    QueryProcessorInfo.ProcessorVendorInfoW.VendorName = _name;         \
    KxCallPlugIn(_hp,                                                   \
                 PLUGIN_QUERY,                                          \
                 P_QUERY_SET_PROCESSOR_VENDOR_W,                        \
                 0,                                                     \
                 (UINT_PTR)&QueryProcessorInfo.ProcessorVendorInfoW,    \
                 NULL);                                                 \
}


/*
VOID
KADB_GET_PROCESSOR_VENDOR_A(
    IN HKAPLUGIN _hp,
    IN LPCSTR _name,
    OUT DWORD _id
    );

Routine Description:

    This routine is used to convert processor vendor name to processor vendor type.

Arguments:

    _hp - specify the caller's plug-in handle.
    _name - specify the processor vendor name in LPCSTR.
    _id - return the processor vendor id in DWORD.

Return Value:

    None.

*/
#define KADB_GET_PROCESSOR_VENDOR_A(_hp, _name, _id)    \
{ \
    QueryProcessorInfo.ProcessorVendorInfoA.VendorName = _name;         \
    KxCallPlugIn(_hp,                                                   \
                 PLUGIN_QUERY,                                          \
                 P_QUERY_GET_PROCESSOR_VENDOR_A,                        \
                 0,                                                     \
                 (UINT_PTR)&QueryProcessorInfo.ProcessorVendorInfoA,    \
                 NULL);                                                 \
    _id = QueryProcessorInfo.ProcessorVendorInfoA.VendorID;             \
}


/*
VOID
KADB_GET_PROCESSOR_VENDOR_A(
    IN HKAPLUGIN _hp,
    IN LPCWSTR _name,
    OUT DWORD _id
    );

Routine Description:

    This routine is used to convert processor vendor name to processor vendor type.

Arguments:

    _hp - specify the caller's plug-in handle.
    _name - specify the processor vendor name in LPCWSTR.
    _id - return the processor vendor id in DWORD.

Return Value:

    None.

*/
#define KADB_GET_PROCESSOR_VENDOR_W(_hp, _name, _id)    \
{ \
    QueryProcessorInfo.ProcessorVendorInfoW.VendorName = _name;         \
    KxCallPlugIn(_hp,                                                   \
                 PLUGIN_QUERY,                                          \
                 P_QUERY_GET_PROCESSOR_VENDOR_W,                        \
                 0,                                                     \
                 (UINT_PTR)&QueryProcessorInfo.ProcessorVendorInfoW,    \
                 NULL);                                                 \
    _id = QueryProcessorInfo.ProcessorVendorInfoW.VendorID;             \
}

#endif // QUERY_PINFO
#endif // KA_EXAPI

