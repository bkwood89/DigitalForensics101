/*++

Copyright (c) 1999 Microsoft Corporation

Module Name:

    syswrap.h

Abstract:

    Public header file for system info/driver verifier wrapper module.

Revision History:

--*/

//***************************
//
// Driver verifier
//
//***************************


//
// These are the feature bits for the driver verifier.
//
typedef enum {
    DvFeatureSpecialPool = 1,
    DvFeatureIrqlChecking = 2,
    DvFeatureAllocationFaultInjection = 4,
    DvFeaturePoolTracking = 8,
    DvFeatureIoVerification = 16
} DriverVerifierFeatures;

//
// This structure represents the verifier features for a particular driver.
// It is used in SysQueryDriverVerifierSettings and
// SysSetDriverVerifierSettings operations.
//
typedef struct _SX_DRIVER_VERIFIER_SETTING {
    DriverVerifierFeatures Features;
    WCHAR Driver[MAX_PATH];
} SX_DRIVER_VERIFIER_SETTING, *PSX_DRIVER_VERIFIER_SETTING;

//
// Global statistics available when the driver verifier is on.
//
typedef struct _SX_DRIVER_VERIFIER_GLOBAL_STATISTICS {
    DWORD StructureSize;
    DWORD RaiseIrqls;
    DWORD AcquireSpinLocks;
    DWORD UntrackedPool;
    DWORD SynchronizeExecutions;
    DWORD AllocationsAttempted;
    DWORD AllocationsSucceeded;
    DWORD AllocationsSucceededSpecialPool;
    DWORD AllocationsWithNoTag;
    DWORD AllocationsFailed;
    DWORD AllocationsFailedDeliberately;
    DWORD TrimRequests;
    DWORD Trims;
} SX_DRIVER_VERIFIER_GLOBAL_STATISTICS, *PSX_DRIVER_VERIFIER_GLOBAL_STATISTICS;

//
// Per-driver statistics available for a driver when the driver verifier is on
// and the driver is being verified.
//
typedef struct _SX_DRIVER_VERIFIER_PERDRIVER_STATISTICS {
    DWORD StructureSize;
    DWORD Loads;
    DWORD Unloads;
    DWORD CurrentPagedPoolAllocations;
    DWORD CurrentNonPagedPoolAllocations;
    DWORD PeakPagedPoolAllocations;
    DWORD PeakNonPagedPoolAllocations;
    SIZE_T PagedPoolUsageInBytes;
    SIZE_T NonPagedPoolUsageInBytes;
    SIZE_T PeakPagedPoolUsageInBytes;
    SIZE_T PeakNonPagedPoolUsageInBytes;
} SX_DRIVER_VERIFIER_PERDRIVER_STATISTICS, *PSX_DRIVER_VERIFIER_PERDRIVER_STATISTICS;


//
// Flags used for SysQueryDriverVerifierSettings and
// SysSetDriverVerifierSettings.
//
// On Windows 2000, dynamic changes are not fully supported by the
// driver verifier. So for now we support setting only the state
// stored in the registry (i.e., effective at next reboot); Attempting
// to use SX_DVFLAG_CURRENT_SETTING with SysSetDriverVerifierSettings
// will fail.
//
#define SX_DVFLAG_PERSISTENT_SETTING   0
#define SX_DVFLAG_CURRENT_SETTING      0x00000001


//
// Routine to query version of this dll.
//
VOID
APIENTRY
SysQueryDllVersion(
    OUT WORD *Major,
    OUT WORD *Minor
    );


//
// Routine to query driver verifier settings, either those currently
// in operation or those stored in the registry (i.e., effective at
// next reboot), depending on the Flags.
//
BOOL
APIENTRY
SysQueryDriverVerifierSettings(
    OUT PSX_DRIVER_VERIFIER_SETTING Settings,
    IN DWORD BufferLength,
    OUT LPDWORD SettingCount,
    IN DWORD Flags
    );


//
// Routine to set settings. The settings passed to this routine completely
// overwrite any existing settings; this routine does not add or remove
// individual drivers from verification.
//
// If SettingCount is 0 then Settings is ignored and all drivers are removed
// from verification.
//
// If the zeroth setting is for a module named * then SettingCount must be 1,
// and the system is configured to verify all drivers.
//
// On Windows 2000, the verifier level cannot generally be controlled
// per-driver. Thus the Features fields of all given Settings must be
// identical or the routine will fail.
//
BOOL
APIENTRY
SysSetDriverVerifierSettings(
    IN PSX_DRIVER_VERIFIER_SETTING Settings,
    IN DWORD SettingCount,
    IN DWORD Flags,
    OUT BOOL *RebootRequired
    );


//
// Routine to query global stats for drivers currently being verified.
// The caller must set the StructureSize field in the structure before
// calling this routine.
//
BOOL
APIENTRY
SysGetDriverVerifierGlobalStatistics(
    IN OUT PSX_DRIVER_VERIFIER_GLOBAL_STATISTICS Statistics
    );


//
// Routine to query per-driver stats for drivers currently being verified.
// The caller must set the StructureSize field in the structure before
// calling this routine.
//
// If DriverName is not specified, then stats are returned for each driver
// being verified.
//
BOOL
APIENTRY
SysGetDriverVerifierPerDriverStatistics(
    IN LPCWSTR DriverName,  OPTIONAL
    OUT PSX_DRIVER_VERIFIER_PERDRIVER_STATISTICS Statistics,
    IN DWORD BufferLength,
    OUT LPDWORD DriverCount
    );


//***************************
//
// Process info
//
//***************************

typedef struct _SX_PROCESS_STATISTICS {
    DWORD StructureSize;
    DWORD NextEntryOffset;

    DWORD64 CreateTime;
    DWORD64 UserTime;
    DWORD64 KernelTime;

    DWORD64 ReadOperationCount;     // always 0 on NT4
    DWORD64 WriteOperationCount;    // always 0 on NT4
    DWORD64 OtherOperationCount;    // always 0 on NT4
    DWORD64 ReadTransferCount;      // always 0 on NT4
    DWORD64 WriteTransferCount;     // always 0 on NT4
    DWORD64 OtherTransferCount;     // always 0 on NT4

    ULONG_PTR UniqueProcessId;
    ULONG_PTR InheritedFromUniqueProcessId;

    SIZE_T PeakVirtualSize;
    SIZE_T VirtualSize;

    SIZE_T QuotaPeakPagedPoolUsage;
    SIZE_T QuotaPagedPoolUsage;
    SIZE_T QuotaPeakNonPagedPoolUsage;
    SIZE_T QuotaNonPagedPoolUsage;
    SIZE_T PagefileUsage;
    SIZE_T PeakPagefileUsage;
    SIZE_T PrivatePageCount;

    LPWSTR ImageName;

    DWORD NumberOfThreads;
    DWORD SessionId;
    LONG BasePriority;
    DWORD HandleCount;
    DWORD PageFaultCount;
    DWORD PeakWorkingSetSize;
    DWORD WorkingSetSize;

} SX_PROCESS_STATISTICS, *PSX_PROCESS_STATISTICS;

//
// Routine to query process information, either by image name or pid,
// or all processes.
//
BOOL
APIENTRY
SysGetProcessStatistics(
    IN LPCWSTR ProcessImageName, OPTIONAL
    IN ULONG_PTR ProcessId, OPTIONAL
    OUT PSX_PROCESS_STATISTICS Statistics,
    IN DWORD BufferLength,
    OUT LPDWORD ProcessCount,
    OUT LPDWORD BytesReturned
    );


//***************************
//
// Handles and objects
//
//***************************

//
// Known handle attributes. These can be combined bit-wise.
// Other values are possible but these are the known ones.
//
typedef enum {
    HaAttributeInherit = 2,
    HaAttributePermanent = 16,
    HaAttributeExclusive = 32,
    HaAttributeCaseInsensitive = 64,
    HaAttributeOpenIf = 128
} HandleAttributes;

//
// Structure to describe a handle (or more exactly, an entry in a
// handle table). The ObjectTypeIndex indexes an array of SX_OBJECT_TYPE_INFO
// structures, and can be -1 to indicate that there is no associated
// object type info structure. This is used with SysGetHandlesInfoForProcess.
//
typedef struct _SX_HANDLE_INFO {
    DWORD StructureSize;
    ULONG_PTR HandleValue;
    ULONG_PTR ProcessId;
    DWORD GrantedAccess;
    HandleAttributes Attributes;
    LONG ObjectTypeIndex;
} SX_HANDLE_INFO, *PSX_HANDLE_INFO;

//
// Structure to describe an object type. Note that the system does not
// place any practical limit on the length of the name, but we cap it
// here to allow for convenient manipulation of these structures in
// array form.
//
#define SX_MAX_OBJECT_TYPE_NAME 64

typedef struct _SX_OBJECT_TYPE_INFO {
    DWORD StructureSize;
    DWORD ObjectCount;
    DWORD HandleCount;
    DWORD InvalidAttributes;
    DWORD ValidAccessMask;
    GENERIC_MAPPING GenericMapping;
    DWORD Flags;
    WCHAR ObjectTypeName[SX_MAX_OBJECT_TYPE_NAME];
} SX_OBJECT_TYPE_INFO, *PSX_OBJECT_TYPE_INFO;

#define SX_OTFLAG_SECURITY_REQUIRED 0x00000001
#define SX_OTFLAG_WAITABLE          0x00000002
#define SX_OTFLAG_PAGED_POOL        0x00000004  // else in nonpaged


//
// Routine to query the handle table entries for a particular process,
// which is specified by id. Retrieval of the type names is optional
// because the routine runs significantly faster when type names are
// not retrieved.
//
BOOL
APIENTRY
SysGetHandlesInfoForProcess(
    IN ULONG_PTR ProcessId,
    IN OUT PSX_HANDLE_INFO HandleInfo,
    IN DWORD HandleInfoBufferLength,
    OUT LPDWORD HandleCount,
    IN OUT PSX_OBJECT_TYPE_INFO ObjectTypeInfo, OPTIONAL
    IN DWORD ObjectTypeInfoBufferLength,
    OUT LPDWORD ObjectTypeCount
    );

//
// Routine to query the handle table entries for a particular object type.
//
BOOL
APIENTRY
SysGetHandlesInfoForObjectType(
    IN LPCWSTR TypeName,
    IN OUT PSX_HANDLE_INFO HandleInfo,
    IN DWORD HandleInfoBufferLength,
    OUT LPDWORD HandleCount,
    OUT PSX_OBJECT_TYPE_INFO ObjectTypeInfo OPTIONAL
    );

//
// Routine to query information about a particular object type or all
// object types.
//
BOOL
APIENTRY
SysGetObjectTypeInfo(
    IN LPCWSTR TypeName, OPTIONAL
    OUT PSX_OBJECT_TYPE_INFO ObjectTypeInfo,
    IN DWORD BufferLength,
    OUT LPDWORD ObjectTypeCount
    );


//***************************
//
// GlobalFlags
//
//***************************

//
// Flags used for SysQueryGlobalFlags and SysSetGlobalFlags.
//
#define SX_GFLAG_PERSISTENT_SETTING 0
#define SX_GFLAG_CURRENT_SETTING    0x00000001

//
// Enumerated type describing the GlobalFlags bits.
// Some flags are not used on some OS versions, meaning that
// those flags will never come back set from SysQueryGlobalFlags,
// and trying to set then in SysSetGlobalFlags will quietly
// have no effect.
//
typedef enum {
    GFlgStopOnException         = 0x00000001,   // nt4, w2k
    GFlgShowLdrSnaps            = 0x00000002,   // nt4, w2k
    GFlgDebugInitialCommand     = 0x00000004,   // nt4, w2k
    GFlgStopOnHungGui           = 0x00000008,   // nt4, w2k
    GFlgPoolEnableTailCheck     = 0x00000100,   // nt4
    GFlgPoolEnableFreeCheck     = 0x00000200,   // nt4
    GFlgPoolEnableTagging       = 0x00000400,   // nt4, w2k
    GFlgKernelStackTraceDb      = 0x00002000,   // nt4, w2k
    GFlgMaintainObjectTypeList  = 0x00004000,   // nt4, w2k
    GFlgIgnoreDebugPriv         = 0x00010000,   // nt4
    GFlgEnableCsrDebug          = 0x00020000,   // nt4, w2k
    GFlgEnableKDebugSymbolLoad  = 0x00040000,   // nt4, w2k
    GFlgDisablePageKernelStacks = 0x00080000,   // nt4, w2k
    GFlgEnableCloseExceptions   = 0x00400000,   // nt4, w2k
    GFlgEnableExceptionLogging  = 0x00800000,   // nt4, w2k
    GFlgEnableHandleTypeTagging = 0x01000000,   // nt4, w2k
    GFlgDebugInitialCommandEx   = 0x04000000,   // nt4, w2k
    GFlgDisableDbgPrint         = 0x08000000    // w2k
} GlobalFlagsBits;

#define SX_GFLAGS_VALID_BITS    0x0dcf670f

//
// We allow changing the state of only certain of the bits above
// through SysSetGlobalFlags. This mask indicates which ones.
// Attempting to change the state of any other bits will not fail
// but will silently have no effect.
//
#define SX_GFLAGS_WRITEABLE_MASK 0x01804700

//
// These are the bits whose state we allow changing on the fly
// (ie, calling SysSetGlobalFlags with SX_GFLAG_CURRENT_SETTING).
// Other writeable flags can only be set with SX_GFLAG_PERSISTENT_SETTING).
//
#define SX_GFLAGS_DYNAMIC_MASK  (SX_GFLAGS_WRITEABLE_MASK & 0x09c5070b)

//
// Routine to query the GlobalFlags.
//
BOOL
APIENTRY
SysQueryGlobalFlags(
    OUT PDWORD64 GlobalFlags,
    IN LPVOID Reserved,
    IN DWORD Flags
    );

//
// Routine to set the GlobalFlags.
//
BOOL
APIENTRY
SysSetGlobalFlags(
    IN DWORD64 GlobalFlags,
    IN LPVOID Reserved,
    IN DWORD Flags
    );
