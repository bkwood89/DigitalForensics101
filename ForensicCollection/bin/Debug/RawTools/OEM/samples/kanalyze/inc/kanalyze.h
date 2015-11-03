/*++

Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    kanalyze.h

Abstract:

    Header file for Kernel Memory Space Analyzer.

Author:


Revision History:


--*/

#ifndef _KANALYZE_
#define _KANALYZE_

#ifdef __cplusplus
extern "C" {
#endif

#include <sigidlib.h>



typedef PVOID HKAPLUGIN;
typedef UINT KA_ITEM_ID, *PKA_ITEM_ID;  //phase2
typedef UINT HKATYPE, *PHKATYPE;        //phase2

#define INVALID_TYPE_HANDLE  ((HKATYPE)0)

#define MAX_TYPE_NAME        128        //phase2
#define MAX_TYPE_DESC        128        //phase2
#define MAX_PLUG_IN_NAME     16         //phase2
#define MAX_CONTAINER_TYPES  16         //phase2
#define MAX_CLASS_NAME       128        //phase3

//////////////////////////////////////////
// Kanalyze PlugIn Interface Definitions
//////////////////////////////////////////

typedef
UINT_PTR
(CALLBACK *PKANALYZE_INTERFACE_PROC)(
    IN HKAPLUGIN PlugInHandle,
    IN UINT32 OperationCode,
    IN OUT UINT_PTR Param1,
    IN OUT PVOID Param2
    );

//
// interface operations
//
#define KA_INITIALIZE                   0x00
#define KA_REGISTER_TYPES               0x01
#define KA_START_LOCATE_ITEMS           0x02
#define KA_PROCESS_ITEM                 0x03
#define KA_NOTIFY_ITEM                  0x04
#define KA_PROCESS_RESULT               0x05
#define KA_TERMINATE                    0x08
#define KA_FORMAT_DATA_ITEM_DESCRIPTION 0x10

#define KA_PERFORM_ANALYSIS             0x20    //phase3
#define KA_DB_CONTROL                   0x30    //phase3
#define KA_DB_BEGIN                     0x30    //phase3 BUGBUG remove later
#define KA_DB_UPDATE                    0x40    //phase3
#define KA_DB_CONNECT                   0x50    //phase3

#define KA_DB_BUILD_QUERY               0xfe    //phase3
#define KA_DB_PROCESS_CLASS             0xff    //phase3

#define KA_PRIVATE                      0x8000

//
// KA_REGISTER_TYPES
//
typedef enum {
    SupportAppendContainerTypes = 1,//phase2
    SupportDemandNotification = 2,  //phase2
    SupportSecondary = 5,
    SupportFull = 10
} KanalyzeSupportLevel;

//TypeCharacteristics
#define KA_TC_LOCATE_ALL_ITEMS      1
#define KA_TC_DONT_CHECK_OVERLAP    2
#define KA_TC_ROOT_ITEM             4
#define KA_TC_ALLOW_MULTIPLE_ITEM   8

typedef
UINT32
(CALLBACK *PKANALYZE_METHOD_PROC)(
    IN HKAPLUGIN PlugInHandle,
    IN KA_ITEM_ID ItemId,
    IN ULONG32 MethodCode,
    IN va_list *Arguments
    );

typedef
UINT32
(CALLBACK *PKANALYZE_REGISTER_TYPES_PROC)(
    IN HKAPLUGIN PlugInHandle,
    IN LPCWSTR TypeName,
    IN LPCWSTR Description,
    IN ULONG32 ContainerTypeCount,
    IN HKATYPE *AllowedContainerTypes,
    IN ULONG32 TypeCharacteristics,
    IN KanalyzeSupportLevel SupportLevel,
    IN PKANALYZE_METHOD_PROC MethodInterface,
    OUT PHKATYPE TypeHandle
    );

//
// KA_START_LOCATE_ITEMS, KA_PROCESS_ITEM, KA_NOTIFY_ITEM, KA_PERFORM_ANALYSIS
//
typedef struct _KANALYZE_DATA_ITEM {
    HKATYPE TypeHandle;
    UINT_PTR Address;
    SIZE_T Size;
    UINT_PTR TypeSpecificParam;
    PVOID TypeSpecificData;
    SIZE_T TypeSpecificDataSize;    // if 0, erase any existing data
} KANALYZE_DATA_ITEM, *PKANALYZE_DATA_ITEM;

typedef
UINT32
(CALLBACK *PKANALYZE_LOCATE_PROC)(
    IN HKAPLUGIN PlugInHandle,
    IN KA_ITEM_ID SourceDataItemId,  OPTIONAL
    IN PKANALYZE_DATA_ITEM DataItem,
    IN UINT32 Flags,
    OUT PKA_ITEM_ID DataItemId
    );

//
// If this flag is specified and the data item already exists,
// then any existing type-specific data (TypeSpecificParam,
// TypeSpecificData) is left alone and not overwritten.
//
#define KA_FLG_IGNORE_TYPE_SPECIFIC_DATA    0x00000001

//
// KA_DB_BUILD_QUERY ( Phase3 )
//
typedef enum {
    StopCode,    // DWORD
    StopParam1,  // LPCSTR
    StopParam2,  // LPCSTR
    StopParam3,  // LPCSTR
    StopParam4,  // LPCSTR
    NTBuild,     // DWORD
    Platform,    // LPCSTR
    Keyword1,    // LPCSTR
    Keyword2,    // LPCSTR
    Keyword3,    // LPCSTR
    Keyword4     // LPCSTR
} QueryFieldType;

typedef enum {
    KaEqual,
    KaNotEqual,
    KaGreaterThan,
    KaGreaterThanOrEqual,
    KaLessThan,
    KaLessThanOrEqual,
    KaContains     // vaild only on strings
} QueryOperator;

typedef enum { // phase 3
    CanonLevelNone     = 0,
    CanonLevelInstance = 1,
    CanonLevelLow      = 4,
    CanonLevelMedium   = 7,
    CanonLevelFull     = 10
} CanonicalLevel;

typedef struct _KANALYZE_QUERY_CLAUSE {
    QueryFieldType FieldType;
    QueryOperator Operator;
    ULONG_PTR Value;
} KANALYZE_QUERY_CLAUSE, *PKANALYZE_QUERY_CLAUSE;

typedef struct _KANALYZE_QUERY_CLAUSES {
    DWORD Count;
    KANALYZE_QUERY_CLAUSE Clauses[ANYSIZE_ARRAY];
} KANALYZE_QUERY_CLAUSES, *PKANALYZE_QUERY_CLAUSES;

typedef
UINT32
(CALLBACK *PKANALYZE_ADD_QUERY_CLAUSES_PROC)(
    IN HKAPLUGIN PlugInHandle,
    IN PKANALYZE_QUERY_CLAUSES Clauses,
    PVOID Reserved   // must be NULL
    );

//
// KA_DB_PROCESS_CLASS ( Phase3 )
//

#define KA_CRASHCLASS_VERSION   1
#define KA_CRASHCLASS_CANONICAL 1

typedef struct _KANALYZE_CRASH_CLASS_DATA {
    DWORD StructureVersion;
    DWORD Flags;
    DWORD ClassID;
    DWORD SolutionID;
    DWORD AnalysisID;
    DWORD NTBuild;
    DWORD Platform;
    DWORD InstanceCount;
    DWORD StopCode;
    CanonicalLevel CanonicalizationLevel;
    LPCSTR StopCodeParameters[4];
    LPCSTR KeyWords[4];
    SYSTEMTIME FirstOccurance;
    SYSTEMTIME LastOccurance;
} KANALYZE_CRASH_CLASS_DATA, *PKANALYZE_CRASH_CLASS_DATA;

typedef enum {
    MatchNot,
    MatchWeak,
    MatchFair,
    MatchGood,
    MatchAbsolute
} MatchConfidenceLevel;

typedef
UINT32
(CALLBACK *PKANALYZE_REPORT_MATCH_PROC)(
    IN HKAPLUGIN PlugInHandle,
    IN PKANALYZE_CRASH_CLASS_DATA ClassData,
    IN LPCWSTR SolutionTextOverride OPTIONAL,
    IN MatchConfidenceLevel MatchLevel,
    UINT_PTR Reserved  // must be 0
    );

//
// KA_DB_CONNECT
//
#define DBF_CONNECT             1
#define DBF_DISCONNECT          2


//
// KA_DB_CONTROL
//
#define DBC_DO_PREQUERY         1
#define DBC_DO_FULLQUERY        2


//
// KA_DB_UPDATE
//
typedef struct _KA_DATABASE_UPDATE_PARAMS {
    UINT32 ActionsAndFlags;
    KA_ITEM_ID CrashClass;
    struct UpdateResult {
        ULONG CrashClassID;    // recieve new Crash Class ID
        ULONG CrashInstanceID;    // recieve new Crash Instance ID
    };
} KA_DATABASE_UPDATE_PARAMS, *PKA_DATABASE_UPDATE_PARAMS;

#define KA_DB_CREATE_CLASS      0x00000001
#define KA_DB_CREATE_INSTANCE   0x00000002




//
// KA_TERMINATE
//
typedef enum {
    OutcomeFailure,
    OutcomeSuccessAnomalies,
    OutcomeSuccessNoAnomalies
} KanalyzeFinalOutcome;

//
// KA_FORMAT_DATA_ITEM_DESCRIPTION
//
typedef struct _KANALYZE_DATA_ITEM_STRING_REQUEST {
    LPCWSTR RequestingPlugInName;
    KA_ITEM_ID DataItemId;
    SIZE_T MessageBufferSize;
    LPWSTR MessageBuffer;
} KANALYZE_DATA_ITEM_STRING_REQUEST, *PKANALYZE_DATA_ITEM_STRING_REQUEST;




//////////////////////////////////////////////////
// Kanalyze Helper/Callback Routine Definitions
//////////////////////////////////////////////////
#define     KA_CHECKED_BUILD        1
#define     KA_TRIAGE_DUMP          2 // minidump

typedef struct _KANALYZE_CRASH_INFO {
    UINT32 SizeOfStruct;
    ULONG64 Flags;
    SIZE_T BugcheckCode;
    SIZE_T BugcheckParameters[4];
    ULONG32 BuildNumber;
    ULONG32 MachineImageType;
    ULONG32 ProcessorCount;
    ULONG32 CurrentProcessor;
} KANALYZE_CRASH_INFO, *PKANALYZE_CRASH_INFO;

typedef
UINT32
(CALLBACK *KANALYZE_GET_CRASH_INFO_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    OUT PKANALYZE_CRASH_INFO CrashInfo
    );

typedef
UINT32
(CALLBACK *KANALYZE_GET_SYMBOL_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN SIZE_T Address,
    OUT LPWSTR SymbolName,
    IN ULONG32 SymbolBufferSize,
    OUT SSIZE_T *Offset
    );

typedef
SIZE_T
(CALLBACK *KANALYZE_SYMBOL_TO_ADDRESS_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN LPCWSTR SymbolName
    );


typedef enum {
    BasicMessage,
    ExpandedMessage,
    DetailedMessage
} KanalyzeMessageDetailLevel;

typedef
BOOL
(CALLBACK *KANALYZE_CHECK_VERBOSITY_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN KanalyzeMessageDetailLevel DetailLevel,
    BOOL Reserved1,  //must be FALSE
    PVOID Reserved2  //must be NULL
    );


#define KAPARAM_DEFAULT_BINARY_PATH ((LPCWSTR)6)
#define KAPARAM_BINARY_SPEC_COUNT   ((LPCWSTR)7)
#define KAPARAM_BINARY_SPEC_NAME    ((LPCWSTR)8)
#define KAPARAM_BINARY_SPEC_PATH    ((LPCWSTR)9)
#define KAPARAM_DEFAULT_SYMBOL_PATH ((LPCWSTR)10)
#define KAPARAM_SYMBOL_SPEC_PATH    ((LPCWSTR)12)
#define KAPARAM_SIGNATURE_ID_FILE_PATH ((LPCWSTR)14)

typedef
INT32
(CALLBACK *KANALYZE_GET_PARAMETER_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN LPCWSTR ParameterName,
    IN UINT_PTR AdditionalInfo,
    OUT PVOID Buffer,
    IN UINT32 BufferSize
    );

typedef enum {
    LogFatalErrors,         // logged if logging enabled, printed to stderr
    LogErrors,              // logged if logging enabled, printed to stderr
    LogWarnings,            // logged if logging enabled
    LogInformation,         // logged if logging enabled
    LogDetailedInformation  // logged if logging enabled
} KanalyzeLogLevel;

typedef
UINT32
(CALLBACK *KANALYZE_WRITE_TO_LOG_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN KanalyzeLogLevel LogLevel,
    IN BOOL Reserved,
    IN LPCWSTR FormatString,        OPTIONAL
    IN UINT32 MessageId,            OPTIONAL
    IN va_list *arglist             OPTIONAL
    );

typedef
UINT32
(CALLBACK *KANALYZE_CALL_PLUGIN_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN LPCWSTR PlugInName,
    IN UINT32 PrivateOperationCode,
    IN OUT UINT_PTR Param1,
    IN OUT UINT_PTR Param2,
    OUT PBOOL ReachedPlugIn OPTIONAL
    );

typedef
BOOL
(CALLBACK *KANALYZE_CHECK_BREAK_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN UINT_PTR Reserved
    );

typedef
UINT32
(CALLBACK *KANALYZE_READ_MEMORY_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN PVOID Reserved,
    IN SIZE_T Address,
    OUT PVOID Buffer,
    IN ULONG32 ByteCount,
    OUT PULONG32 BytesRead
    );

typedef
UINT32
(CALLBACK *KANALYZE_WRITE_MEMORY_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN PVOID Reserved,  //must be NULL
    IN SIZE_T Address,
    IN CONST VOID *Buffer,
    IN ULONG32 ByteCount,
    OUT PULONG32 BytesWritten
    );

typedef
UINT32
(CALLBACK *KANALYZE_GET_CONTEXT_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN UINT_PTR Reserved,  //must be 0
    IN UINT32 Processor,
    OUT PCONTEXT Context
    );

typedef
BOOL
(CALLBACK *KANALYZE_READ_CONTROL_SPACE_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN PVOID     Reserved,
    IN USHORT    Processor,
    IN SIZE_T    TargetBaseAddress,
    OUT PVOID    UserInterfaceBuffer,
    IN ULONG32   ByteCount,
    OUT PULONG32 BytesRead
    );

typedef struct _KA_DATA_ITEM_INFO {
    HKATYPE TypeHandle;
    UINT_PTR Address;
    SIZE_T Size;
    UINT_PTR TypeSpecificParam;
    SIZE_T TypeSpecificDataSize;     // if 0, none
    WCHAR ReportedPlugInName[MAX_PLUG_IN_NAME];
} KA_DATA_ITEM_INFO, *PKA_DATA_ITEM_INFO;

typedef
UINT32
(CALLBACK *KANALYZE_QUERY_DATA_ITEM_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN KA_ITEM_ID DataItemId,
    IN UINT_PTR Unused,         //must be 0
    OUT PKA_DATA_ITEM_INFO DataItemInfo
    );

typedef
UINT32
(CALLBACK *PKANALYZE_ENUM_STORED_ITEM_CALLBACK)(
    IN HKAPLUGIN PlugInHandle,
    IN KA_ITEM_ID DataITemId,
    IN OUT PVOID Context
    );

//KA_ENUM_STORED_ITEM_SPECIFICATION Flags member's definition
#define KA_ESI_FLAG_USE_PLUGIN_HANDLE          1
#define KA_ESI_FLAG_USE_TYPE_HANDLE            2
#define KA_ESI_FLAG_ENUM_ALL_OVERLAPPED_ITEMS  4
#define KA_ESI_FLAG_SEARCH_TYPE_SPECIFIC_PARAM 8

typedef struct _KA_ENUM_STORED_ITEM_SPECIFICATION {
    ULONG32 Flags;           //KA_ESI_FLAG_XXX
    LPCWSTR ReportedPlugIn;
    LPCWSTR TypeSpecification;
    UINT_PTR StartAddress;
    UINT_PTR EndAddress;
    UINT_PTR TypeSpecificParam;
} KA_ENUM_STORED_ITEM_SPECIFICATION, *PKA_ENUM_STORED_ITEM_SPECIFICATION;

typedef
UINT32
(CALLBACK *KANALYZE_ENUM_STORED_ITEM_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN PKA_ENUM_STORED_ITEM_SPECIFICATION DataItemSpecification,
    IN UINT_PTR Spare1,                //must be 0
    IN UINT_PTR Spare2,                //must be 0
    IN PKANALYZE_ENUM_STORED_ITEM_CALLBACK Callback,
    IN OUT PVOID Context            //passed to callback routine as is
    );

typedef
HKATYPE
(CALLBACK *KANALYZE_GET_TYPE_HANDLE_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN LPCWSTR TypeName
    );

typedef struct _KA_TYPE_INFO {
    ULONG32 TypeCharacteristics;
    WCHAR TypeName[MAX_TYPE_NAME];
    WCHAR Description[MAX_TYPE_DESC];
    WCHAR SupportPlugInName[MAX_PLUG_IN_NAME];
    ULONG32 ContainerTypeCount;
    HKATYPE AllowedContainerType[MAX_CONTAINER_TYPES];
} KA_TYPE_INFO, *PKA_TYPE_INFO;

typedef
UINT32
(CALLBACK *KANALYZE_QUERY_TYPE_INFO_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN HKATYPE TypeHandle,
    IN UINT_PTR Unused,  //must be 0
    OUT PKA_TYPE_INFO TypeInfo
    );

typedef
UINT32
(CALLBACK *PKANALYZE_ENUM_TYPE_INFO_CALLBACK)(
    IN HKAPLUGIN PlugInHandle,
    IN HKATYPE TypeHandle,
    IN OUT PVOID Context
    );

typedef
UINT32
(CALLBACK *KANALYZE_ENUM_TYPE_INFO_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN LPCWSTR TypeSpecification,
    IN UINT_PTR Spare1,  //must be 0
    IN UINT_PTR Spare2,  //must be 0
    IN PKANALYZE_ENUM_TYPE_INFO_CALLBACK Callback,
    IN OUT PVOID Context
    );

typedef struct _KA_LINK_INFO {
    LPCWSTR ReportedPlugInName;
    KA_ITEM_ID SourceDataItemId;  //phase2
    KA_ITEM_ID TargetDataItemId;  //phase2
} KA_LINK_INFO, *PKA_LINK_INFO;

typedef
UINT32
(CALLBACK *PKANALYZE_ENUM_LINK_INFO_CALLBACK)(
    IN HKAPLUGIN PlugInHandle,
    IN CONST KA_LINK_INFO *LinkInfo,
    IN OUT PVOID Context
    );

typedef
UINT32
(CALLBACK *KANALYZE_ENUM_LINK_INFO_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN KA_ITEM_ID DataItemId,  //if 0, enumerate all links
    IN UINT_PTR Spare1,  //must be 0
    IN UINT_PTR Spare2,  //must be 0
    IN PKANALYZE_ENUM_LINK_INFO_CALLBACK Callback,
    IN OUT PVOID Context
    );

typedef
UINT32
(CALLBACK *KANALYZE_RETRIEVE_TYPE_SPECIFIC_DATA_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN KA_ITEM_ID DataItemId,
    IN SIZE_T TypeSpecificDataBufferSize,
    OUT PVOID TypeSpecificDataBuffer,
    OUT PSIZE_T TypeSpecificDataSize
    );

typedef
UINT32
(CALLBACK *KANALYZE_GET_DATA_ITEM_DESCRIPTION)(
    IN HKAPLUGIN PlugInHandle,
    IN KA_ITEM_ID DataItemId,
    IN SIZE_T MessageBufferSize,
    IN LPWSTR MessageBuffer,
    OUT PSIZE_T CaractersWritten  OPTIONAL
    );


typedef
UINT32
(CALLBACK *KANALYZE_CALL_METHOD_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN KA_ITEM_ID ItemId,
    IN ULONG32 MethodCode,
    ...                     // arguments depend on MethodCode
    );


typedef
UINT32
(CALLBACK *KANALYZE_WRITE_PHYSICAL_MEMORY_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN PVOID Reserved,
    IN SIZE_T PhysicalAddress,
    IN CONST VOID *Buffer,
    IN ULONG32 ByteCount,
    OUT PULONG32 BytesWritten
    );


typedef
UINT32
(CALLBACK *KANALYZE_READ_PHYSICAL_MEMORY_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN PVOID Reserved,
    IN SIZE_T PhysicalAddress,
    OUT PVOID Buffer,
    IN ULONG32 ByteCount,
    OUT PULONG32 BytesRead
    );

typedef
UINT32
(CALLBACK *KANALYZE_GET_HELPER_TABLE_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN LPCWSTR PublicHelperTableName,
    OUT PVOID *PublicHelperTable,
    UINT_PTR Reserved
    );

typedef
UINT32
(CALLBACK *KANALYZE_BROADCAST_MESSAGE_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN LPCWSTR ClassName,
    IN ULONG32 MessageCode,
    IN UINT_PTR Param1,
    IN PVOID Param2,
    UINT_PTR Reserved
    );


//////////////////////////////////////
// Table of Helper Callback Routines
//////////////////////////////////////

typedef struct _KANALYZE_EXTENSION_APIS {
    ULONG32 StructureSize;
    KANALYZE_GET_CRASH_INFO_ROUTINE GetCrashInfoRoutine;
    KANALYZE_GET_SYMBOL_ROUTINE GetSymbolRoutine;
    KANALYZE_SYMBOL_TO_ADDRESS_ROUTINE SymbolToAddressRoutine;
    KANALYZE_GET_PARAMETER_ROUTINE GetParameterRoutine;
    KANALYZE_WRITE_TO_LOG_ROUTINE WriteToLogRoutine;
    KANALYZE_CHECK_VERBOSITY_ROUTINE CheckVerbosityRoutine;
    KANALYZE_CALL_PLUGIN_ROUTINE CallPlugInRoutine;
    KANALYZE_CHECK_BREAK_ROUTINE CheckBreakRoutine;
    KANALYZE_READ_MEMORY_ROUTINE ReadMemoryRoutine;
    KANALYZE_WRITE_MEMORY_ROUTINE WriteMemoryRoutine;
    KANALYZE_GET_CONTEXT_ROUTINE GetContextRoutine;
    KANALYZE_READ_CONTROL_SPACE_ROUTINE ReadControlSpaceRoutine;
    KANALYZE_GET_TYPE_HANDLE_ROUTINE GetTypeHandleRoutine;             //phase2
    KANALYZE_QUERY_TYPE_INFO_ROUTINE QueryTypeInfoRoutine;             //phase2
    KANALYZE_ENUM_TYPE_INFO_ROUTINE EnumTypeInfoRoutine;               //phase2
    KANALYZE_QUERY_DATA_ITEM_ROUTINE QueryDataItemRoutine;             //phase2
    KANALYZE_ENUM_STORED_ITEM_ROUTINE EnumStoredItemRoutine;           //phase2
    KANALYZE_ENUM_LINK_INFO_ROUTINE EnumLinkInfoRoutine;               //phase2
    KANALYZE_RETRIEVE_TYPE_SPECIFIC_DATA_ROUTINE RetrieveTypeSpecificDataRoutine;//phase2
    KANALYZE_GET_DATA_ITEM_DESCRIPTION GetDataItemDescriptionRoutine;  //phase2
    KANALYZE_CALL_METHOD_ROUTINE CallMethodRoutine;                    //phase2
    KANALYZE_WRITE_PHYSICAL_MEMORY_ROUTINE WritePhysicalMemoryRoutine; //phase3
    KANALYZE_READ_PHYSICAL_MEMORY_ROUTINE ReadPhysicalMemoryRoutine;   //phase3
    KANALYZE_GET_HELPER_TABLE_ROUTINE GetHelperTableRoutine;           //phase3
    KANALYZE_BROADCAST_MESSAGE_ROUTINE BroadcastMessageRoutine;                       //phase3
} KANALYZE_EXTENSION_APIS, *PKANALYZE_EXTENSION_APIS;


////////////////////////////////
// PlugIn Registration Routine
////////////////////////////////

#define KANALYZE_INTERFACE_VERSION   3

#define MAX_HELPER_TABLE_NAME  64
#define MAX_HELPER_TABLES      16

typedef struct _KANALYZE_HELPER_TABLE_ENTRY {
    WCHAR HelperTableName[MAX_HELPER_TABLE_NAME];
    PVOID pHelperTable;
} KANALYZE_HELPER_TABLE_ENTRY, *PKANALYZE_HELPER_TABLE_ENTRY;

typedef struct _KANALYZE_HELPER_TABLES {
    ULONG32 NumberOfHelperTableEntries;
    KANALYZE_HELPER_TABLE_ENTRY HelperTableEntry[MAX_HELPER_TABLES];
} KANALYZE_HELPER_TABLES, *PKANALYZE_HELPER_TABLES;

typedef
HKAPLUGIN
(CALLBACK *KANALYZE_REGISTER_PLUGIN_PROC)(
    IN UINT Version,
    IN LPCWSTR Identifier,
    IN PKANALYZE_INTERFACE_PROC InterfaceRoutine,
    OUT PKANALYZE_EXTENSION_APIS HelperRoutineTable,
    IN PKANALYZE_HELPER_TABLES PrivateHelperTables, OPTIONAL
    UINT_PTR Reserved
    );


////////////////////////////
// Common Export Routine
////////////////////////////

typedef
VOID
(CALLBACK *PKANALYZE_REGISTER_PLUG_INS)(
    IN KANALYZE_REGISTER_PLUGIN_PROC RegistrationRoutine,
    IN ULONG32 CrashPlatform,
    IN ULONG32 CrashBuildNumber,
    PVOID Reserved1,
    UINT_PTR Reserved2
    );

#define REGISTER_PLUG_INS_NAME   "KanalyzeRegisterPlugIns"
#define LREGISTER_PLUG_INS_NAME  L"KanalyzeRegisterPlugIns"

#ifdef KA_EXTAPI

extern KANALYZE_EXTENSION_APIS KanalyzeExtensionApis;

#define KxGetCrashInfo     (KanalyzeExtensionApis.GetCrashInfoRoutine)
#define KxGetSymbol        (KanalyzeExtensionApis.GetSymbolRoutine)
#define KxSymbolToAddress  (KanalyzeExtensionApis.SymbolToAddressRoutine)
#define KxGetParameter     (KanalyzeExtensionApis.GetParameterRoutine)
#define KxWriteToLog       (KanalyzeExtensionApis.WriteToLogRoutine)
#define KxCheckVerbosity   (KanalyzeExtensionApis.CheckVerbosityRoutine)
#define KxCallPlugIn       (KanalyzeExtensionApis.CallPlugInRoutine)
#define KxCheckBreak       (KanalyzeExtensionApis.CheckBreakRoutine)
#define KxReadMemory       (KanalyzeExtensionApis.ReadMemoryRoutine)
#define KxWriteMemory      (KanalyzeExtensionApis.WriteMemoryRoutine)
#define KxGetContext       (KanalyzeExtensionApis.GetContextRoutine)
#define KxReadControlSpace (KanalyzeExtensionApis.ReadControlSpaceRoutine)
#define KxGetTypeHandle    (KanalyzeExtensionApis.GetTypeHandleRoutine)
#define KxQueryTypeInfo    (KanalyzeExtensionApis.QueryTypeInfoRoutine)
#define KxEnumTypeInfo     (KanalyzeExtensionApis.EnumTypeInfoRoutine)
#define KxQueryDataItem    (KanalyzeExtensionApis.QueryDataItemRoutine)
#define KxEnumStoredItem   (KanalyzeExtensionApis.EnumStoredItemRoutine)
#define KxEnumLinkInfo     (KanalyzeExtensionApis.EnumLinkInfoRoutine)
#define KxRetrieveTypeSpecificData (KanalyzeExtensionApis.RetrieveTypeSpecificDataRoutine)
#define KxGetDataItemDescription (KanalyzeExtensionApis.GetDataItemDescriptionRoutine)
#define KxCallMethod       (KanalyzeExtensionApis.CallMethodRoutine)
#define KxWritePhysicalMemory (KanalyzeExtensionApis.WritePhysicalMemoryRoutine)
#define KxReadPhysicalMemory  (KanalyzeExtensionApis.ReadPhysicalMemoryRoutine)
#define KxGetHelperTable   (KanalyzeExtensionApis.GetHelperTableRoutine)
#define KxBroadcastMessage (KanalyzeExtensionApis.BroadcastMessageRoutine)

#endif //KA_EXTAPI


//////////////////////////////////////
// Information for Overlap Checking
//////////////////////////////////////

//
// Anomaly type of AnomalyDescriptor\Overlap
// They are set at TypeSpecificParam.
//
#define KA_OVERLAP_ANOMALY_INVALID_CONTAINER    0x01
#define KA_OVERLAP_ANOMALY_INVALID_NESTING      0x02



//
// Public helper/callback routines for "Signature Id File"
//
typedef
DWORD
(CALLBACK *PSIGIDFIL_QUERY_KANALYZE_ENVIRONMENT)(
    IN PVOID Reserved,
    OUT PSIGIDFILE_KANALYZE_ENVIRONMENT Environment,
    IN DWORD BufferSize,
    OUT LPDWORD DataSize,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_SET_CANONICAL_DATA)(
    IN PVOID Reserved,
    IN PSIGIDFILE_CANONICAL_DATA CanonicalData,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_GET_CANONICAL_DATA)(
    IN PVOID Reserved,
    OUT PSIGIDFILE_CANONICAL_DATA Data,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_GET_CRASH_INSTANCE_DATA)(
    IN PVOID Reserved,
    OUT PSIGIDFILE_CRASH_INSTANCE_DATA Data,
    IN DWORD BufferSize,
    OUT LPDWORD DataSize,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_ADD_DATA_BLOB)(
    IN PVOID Reserved,
    IN LPCWSTR BlobWriterId,
    IN LPCWSTR BlobName,
    IN PVOID Data,
    IN DWORD DataSize,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_DELETE_DATA_BLOB)(
    IN PVOID Reserved,
    IN LPCWSTR BlobName,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_QUERY_DATA_BLOB_DATA)(
    IN PVOID Reserved,
    IN LPCWSTR BlobName,
    OUT PVOID Data,
    IN DWORD BufferSize,
    OUT LPDWORD DataSize,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_GET_DATA_BLOB_LIST)(
    IN PVOID Reserved,
    IN LPCWSTR BlobWriterIdPattern,
    IN LPCWSTR BlobNamePattern,
    OUT PSIGIDFILE_DATABLOB Blobs,
    IN DWORD BufferSize,
    OUT LPDWORD DataSize,
    OUT LPDWORD BlobCount,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_ATTACH_ATTACHMENT)(
    IN PVOID Reserved,
    IN LPCWSTR Tag,
    IN PSIGIDFILE_ATTACHMENT_INFO Attachment,
    OUT LPDWORD Instance,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_DETACH_ATTACHMENT)(
    IN PVOID Reserved,
    IN LPCWSTR Tag,
    IN DWORD Instance,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_GET_ATTACHMENT_TAG_INSTANCE_COUNT)(
    IN PVOID Reserved,
    IN LPCWSTR Tag,
    OUT LPDWORD InstanceCount,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_GET_ATTACHMENT)(
    IN PVOID Reserved,
    IN LPCWSTR Tag,
    IN DWORD Instance,
    OUT PSIGIDFILE_ATTACHMENT_INFO Attachment,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_WRITE_ANALYSIS_TEXT)(
    IN PVOID Reserved,
    IN LPCWSTR Abstract,
    IN LPCWSTR ProblemDescription,
    IN LPCWSTR Keywords,
    IN LPCSTR Status
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_GET_ANALYSIS_TEXT)(
    IN PVOID Reserved,
    IN OUT LPDWORD AbstractLength,
    OUT LPWSTR Abstract,
    IN OUT LPDWORD ProblemDescriptionLength,
    OUT LPWSTR ProblemDescription,
    IN OUT LPDWORD KeywordsLength,
    OUT LPWSTR Keywords,
    IN OUT LPDWORD StatusLength,
    OUT LPSTR Status
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_SET_EXTERNAL_LOCATORS)(
    IN PVOID Reserved,
    IN LPCWSTR Customer,
    IN LPCSTR ServiceRecord,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef
DWORD
(CALLBACK *PSIGIDFIL_GET_EXTERNAL_LOCATORS)(
    IN PVOID Reserved,
    IN OUT LPDWORD CustomerLength,
    OUT LPWSTR Customer,
    IN OUT LPDWORD ServiceRecordLength,
    OUT LPSTR ServiceRecord,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

typedef struct _SIGIDFIL_PUBLIC_HELPER_TABLE {
    SIZE_T size;
    PVOID Unused1;
    PVOID Unused2;
    PVOID Unised3;
    PSIGIDFIL_QUERY_KANALYZE_ENVIRONMENT SigIDFilQueryKanalyzeEnvironment;
    PSIGIDFIL_SET_CANONICAL_DATA SigIDFilSetCanonicalData;
    PSIGIDFIL_GET_CANONICAL_DATA SigIDFilGetCanonicalData;
    PSIGIDFIL_GET_CRASH_INSTANCE_DATA SigIDFilGetCrashInstanceData;
    PSIGIDFIL_ADD_DATA_BLOB SigIDFilAddDataBlob;
    PSIGIDFIL_DELETE_DATA_BLOB SigIDFilDeleteDataBlob;
    PSIGIDFIL_QUERY_DATA_BLOB_DATA SigIDFilQueryDataBlobData;
    PSIGIDFIL_GET_DATA_BLOB_LIST SigIDFilGetDataBlobList;
    PSIGIDFIL_ATTACH_ATTACHMENT SigIDFilAttachAttachment;
    PSIGIDFIL_DETACH_ATTACHMENT SigIDFilDetachAttachment;
    PSIGIDFIL_GET_ATTACHMENT_TAG_INSTANCE_COUNT SigIDFilGetAttachmentTagInstanceCount;
    PSIGIDFIL_GET_ATTACHMENT SigIDFilGetAttachment;
    PSIGIDFIL_WRITE_ANALYSIS_TEXT SigIDFilWriteAnalysisText;
    PSIGIDFIL_GET_ANALYSIS_TEXT SigIDFilGetAnalysisText;
    PSIGIDFIL_SET_EXTERNAL_LOCATORS SigIDFilSetExternalLocators;
    PSIGIDFIL_GET_EXTERNAL_LOCATORS SigIDFilGetExternalLocators;
} SIGIDFIL_PRIVATE_HELPER_TABLE, *PSIGIDFIL_PRIVATE_HELPER_TABLE;




//
// Public helper/callback routines for "UiStream"
//
typedef
INT
(CALLBACK *PUISTREAM_OUTPUT_STRING_ROUTINE)(
    IN  HKAPLUGIN PlugInHandle,
    IN  LPCWSTR String
    );


typedef
INT
(CALLBACK *PUISTREAM_INPUT_STRING_ROUTINE)(
    IN HKAPLUGIN PlugInHandle,
    IN LPCWSTR RequestString,
    IN UINT StringBufferLen,
    OUT LPWSTR StringBuffer
    );


typedef struct _UISTREAM_PUBLIC_HELPER_TABLE {
    SIZE_T size;
    PUISTREAM_OUTPUT_STRING_ROUTINE UiOutputStringRoutine;
    PUISTREAM_INPUT_STRING_ROUTINE UiInputStringRoutine;
} UISTREAM_PRIVATE_HELPER_TABLE, *PUISTREAM_PRIVATE_HELPER_TABLE;


//
// Exe interface
//

typedef PVOID HKANALYZE;

typedef
UINT_PTR
(CALLBACK *PKANALYZE_OUTPUTSTREAM_HANDLER)(
    IN LPCWSTR String
    );

typedef
UINT_PTR
(CALLBACK *PKANALYZE_INPUTREQUEST_HANDLER)(
    IN LPCWSTR RequestString,
    IN UINT StringBufferLen,
    OUT LPWSTR StringBuffer
    );

typedef
UINT_PTR
(CALLBACK *PKANALYZE_CANCELINQUIRY_HANDLER)(
    OUT PBOOL Cancel
    );


typedef struct _KA_INITIALIZE_PARAMS {
    ULONG SizeOfStruct;
    PKANALYZE_REGISTER_PLUG_INS fnPlugInRegistration;
    PKANALYZE_OUTPUTSTREAM_HANDLER fnOutputStream;
    PKANALYZE_INPUTREQUEST_HANDLER fnInputRequest;
    PKANALYZE_CANCELINQUIRY_HANDLER fnCancelInquiry;
} KA_INITIALIZE_PARAMS, *PKA_INITIALIZE_PARAMS;


HKANALYZE
WINAPI
KanalyzeDllInitialize(
    IN LPCWSTR ParameterFileName OPTIONAL,
    IN PKA_INITIALIZE_PARAMS InitParams OPTIONAL
    );


BOOL
WINAPI
KanalyzeSetParameter(
    IN HKANALYZE hKanalyze,
    IN ULONG Flags,
    IN LPCWSTR Parameter,
    IN LPCWSTR SubKey,
    IN PVOID Data
    );

#define KAE_FLAG_DATA_INTEGER    0x00000000
#define KAE_FLAG_DATA_STRING     0x00000001
#define KAE_FLAG_DATA_TYPE_MASK  0x000000ff
#define KAE_FLAG_FORCE_UPDATE    0x10000000
#define KAE_FLAG_REMOVE_ENTRY    0x20000000
#define KAE_FLAG_GET_PARAMETER_BY_ORDER    0x00010000


BOOL
WINAPI
KanalyzeGetParameter(
    IN HKANALYZE hKanalyze,
    IN ULONG Flags,
    IN LPCWSTR Parameter,
    IN LPCWSTR SubKey,
    OUT PVOID Data,
    PVOID Reserved       //must be NULL
    );

//
// pszParameter field of KanalyzeGetParameter
//
#define KAE_PARAM_GET_NUMBER_OF_ENTRIES   (LPCWSTR)1


BOOL
WINAPI
KanalyzeLoadDumpFile(
    IN HKANALYZE hKanalyze,
    OUT LPWSTR FailureDescription,
    IN DWORD BufferLength
    );

BOOL
WINAPI
KanalyzeUnloadDumpFile(
    IN HKANALYZE hKanalyze
    );

BOOL
WINAPI
KanalyzeLoadSymbols(
    IN HKANALYZE hKanalyze,
    OUT LPWSTR FailureDescription,
    IN DWORD BufferLength
    );

BOOL
WINAPI
KanalyzeUnloadSymbols(
    IN HKANALYZE hKanalyze
    );

BOOL
WINAPI
KanalyzeLoadPlugIns(
    IN HKANALYZE hKanalyze
    );

BOOL
WINAPI
KanalyzeLocateItemsAndAnalyze(
    IN HKANALYZE hKanalyze
    );

BOOL
WINAPI
KanalyzeConnectDatabase(
    IN HKANALYZE hKanalyze,
    OUT PBOOL Connected
    );

BOOL
WINAPI
KanalyzeDisconnectDatabase(
    IN HKANALYZE hKanalyze
    );

BOOL
WINAPI
KanalyzeSearchDatabase(
    IN HKANALYZE hKanalyze,
    IN UINT_PTR Control
    );

BOOL
WINAPI
KanalyzeProcessResults(
    IN HKANALYZE hKanalyze
    );

BOOL
WINAPI
KanalyzeUpdateDatabase(
    IN HKANALYZE hKanalyze,
    IN PKA_DATABASE_UPDATE_PARAMS DbUpdateParams
    );

BOOL
WINAPI
KanalyzeTerminate(
    IN HKANALYZE hKanalyze
    );



#ifdef __cplusplus
}
#endif

#endif // _KANALYZE_

