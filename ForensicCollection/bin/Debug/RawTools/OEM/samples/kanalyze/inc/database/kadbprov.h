/*++

Copyright (c) 1999 Microsoft Corporation

Module Name:

    kadbprov.h

Abstract:

    Header file for Kanalyze Database Provider DLL

Author:

    Takahiro Kawamura(v-takawa) 23-Aug-1999

Revision History:

--*/

#ifndef _KADBPROV_H_
#define _KADBPROV_H_


#ifdef __cplusplus
extern "C" {
#endif


//
// This function is called to initialize the kanalyze database.
// It will be used initialize OLE DB and COM libraries.
//
BOOL
KaDbInitialize(
    VOID
    );

//
// This function is called when no additional database calls are required.
// The function  closes all connection, closes OLE DB and COM libraries
// and frees system resources.
//
BOOL
KaDbCleanup(
    IN VOID
    );

#define KADB_CONNECTION_TRANACTION_ACTIVE   0x0001

//
// This function is used to establish a database connection with a named
// data source. A connection handle is required for all subsequent
// KaDBxxxx functions.
//
HANDLE
KaDbOpenConnection(
    IN  LPCWSTR FileDSN,
    IN  LPCWSTR UID,
    IN  LPCWSTR Password
    );

//
// This function is used to close a database connection that was
// previous established by invoking KaDbOpenConnection.
//
BOOL
KaDbCloseConnection(
    IN  HANDLE DbConnection
    );

//
// This function is used to start a database transaction and requires
// a database connection handle.
//
BOOL
KaDbStartTransaction(
    IN  HANDLE DbConnection
    );

//
// This function is used to "un-due" or rollback a set of operations
// that have been performed under a database transaction. The caller
// must of called KaDbStartTransaction prior to invoking this function.
//
BOOL
KaDbRollBackTransaction(
    IN  HANDLE DbConnection
    );

//
// This function is used complete a set of operations that have been
// performed under a database transaction. The caller must of called
// KaDbStartTransaction prior to invoking this function.
//
BOOL
KaDbCommitTransaction(
    IN  HANDLE DbConnection
    );

// This callback routine enumerate the records. The invoked callback
// must return TRUE to obtain the next subsequent record.
//
typedef
BOOL
(CALLBACK *PKADB_ENUM_DATA_CALLBACK)(
    IN  ULONG32 RecordCount,
    IN  LONG32  RecordID,
    IN  PVOID   Data,
    IN  ULONG32 Flags,
    IN  PVOID   CallBackParm
    );

//
// CrashClass Table
//

typedef struct _KADB_CRASH_CLASS {
    LONG32      SolutionID;
    LONG32      AnalysisID;
    LPSTR       StopCode;
    LPSTR       StopCodeParameters[4];
    USHORT      NTBuild;
    LPSTR       Platform;
    LONG32      CanonicalizationLevel;
    LPSTR       KeyWords[4];
    LONG32      InstanceCount;
    SYSTEMTIME  FirstOccurrence;
    SYSTEMTIME  LastOccurrence;
} KADB_CRASH_CLASS, *PKADB_CRASH_CLASS;

//
// This function is used to query the CrashClass table for a matching
// crash. A callback routine is provided to enumerate CrashClass
// records found within the rowset. The invoked called back must
// return TRUE to obtain the next subsequent record within the rowset.
//
BOOL
KaDbGetCrashClass(
    IN  HANDLE      DbConnection,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK CallBack,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to add a CrashClass record to the database.
//
BOOL
KaDbAddCrashClass(
    IN  HANDLE      DbConnection,
    IN  PKADB_CRASH_CLASS CrashClass,
    OUT PLONG32     ClassID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

#define KADB_UP_CRASH_CLASS_SOLUTION_ID         0x00001
#define KADB_UP_CRASH_CLASS_ANALYSIS_ID         0x00002
#define KADB_UP_CRASH_CLASS_INSTANCE_COUNT      0x04000
#define KADB_UP_CRASH_CLASS_FIRST_OCCURRENCE    0x08000
#define KADB_UP_CRASH_CLASS_LAST_OCCURRENCE     0x10000

//
// This function is used to update a CrashClass record. A matching
// CrashClass record must have been previous located prior to invoking
// this function (See KaDBGetCrashClass ).
//
BOOL
KaDbUpdateCrashClass(
    IN  HANDLE      DbConnection,
    IN  UINT64      UpdateFlags,
    IN  LONG32      ClassID,
    IN  PKADB_CRASH_CLASS CrashClass,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// CrashInstance Table
//

typedef struct _KADB_CRASH_INSTANCE {
    LONG32      ClassID;
    LONG32      HWProfileRecID;
    LONG32      OSProfileRecID;
    LPSTR       StopCodeParameters[4];
    USHORT      KanalyzeMajorVersion;
    USHORT      KanalyzeMinorVersion;
    SYSTEMTIME  DateTime;
} KADB_CRASH_INSTANCE, *PKADB_CRASH_INSTANCE;

//
// This function is used to query the CrashInstance table for a matching
// instance. A callback routine is provided to enumerate CrashInstance
// records found within the rowset.  The invoked called back must return
// TRUE to obtain the next subsequent record within the rowset.
//
BOOL
KaDbGetCrashInstance(
    IN  HANDLE      DbConnection,
    IN  LONG32      ClassID,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to add a CrashInstance record to the database.
//
BOOL
KaDbAddCrashInstance(
    IN  HANDLE      DbConnection,
    IN  PKADB_CRASH_INSTANCE CrashInstance,
    OUT PLONG32     InstanceID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// This structure represents the result of Joined Query between
// the CrashClass table and CrashInstance table.
//
typedef struct _KADB_CRASH_CLASS_CRASH_INSTANCE {
    KADB_CRASH_CLASS    CrashClass;

    struct {
        LONG32      InstanceID;
        LONG32      HWProfileRecID;
        LONG32      OSProfileRecID;
        LPSTR       StopCodeParameters[4];
        USHORT      KanalyzeMajorVersion;
        USHORT      KanalyzeMinorVersion;
        SYSTEMTIME  DateTime;
    } CrashInstance;
} KADB_CRASH_CLASS_CRASH_INSTANCE, *PKADB_CRASH_CLASS_CRASH_INSTANCE;

//
// This function is used to query the CrashClass and CrashInstance
// tables to obtain a list of crash classes that are associated with
// a specific crash instance and/or to acquire specific information
// regarding a crash class that is associated with a crash instance.
//
BOOL
KaDbGetCrashClassCrashInstance(
    IN  HANDLE      DbConnection,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );


//
// Solution Table
//

typedef struct _KADB_SOLUTION {
    LPWSTR      Abstract;
    LPWSTR      SolutionDescription;
    LPWSTR      KeyWords;
    SYSTEMTIME  LastUpdated;
} KADB_SOLUTION, *PKADB_SOLUTION;

//
// This function is used to query the Solution table for a matching
// solution. A callback routine is provided to enumerate Solution records
// found within the rowset.  The invoked called back must return TRUE to
// obtain the next subsequent record within the rowset.
//
BOOL
KaDbGetSolution(
    IN  HANDLE      DbConnection,
    IN  LONG32      SolutionID,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to add a Solution record to the database.
//
BOOL
KaDbAddSolution(
    IN  HANDLE      DbConnection,
    IN  PKADB_SOLUTION Solution,
    OUT PLONG32     SolutionID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

#define KADB_UP_SOLUTION_ABSTRACT                   0x0001
#define KADB_UP_SOLUTION_SOLUTION_DESC              0x0002
#define KADB_UP_SOLUTION_KEYWORDS                   0x0004
#define KADB_UP_SOLUTION_LAST_UPDATED               0x0008

//
// This function is used to update a Solution record. A matching
// Solution record must have been previous located prior to invoking
// this function (See KaDBGetSolution ).
//
BOOL
KaDbUpdateSolution(
    IN  HANDLE      DbConnection,
    IN  UINT64      UpdateFlags,
    IN  LONG32      SolutionID,
    IN  PKADB_SOLUTION Solution,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// Analysis Table
//

typedef struct _KADB_ANALYSIS {
    LPWSTR  Abstract;
    LPWSTR  ProblemDescription;
    LPWSTR  KeyWords;
    LPSTR   Status;
} KADB_ANALYSIS, *PKADB_ANALYSIS;

// This function is used to query the Analysis table for a matching
// analysis. A callback routine is provided to enumerate Analysis records
// found within the rowset.  The invoked called back must return TRUE to
// obtain the next subsequent record within the rowset.
//
BOOL
KaDbGetAnalysis(
    IN  HANDLE      DbConnection,
    IN  LONG32      AnalysisID,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to create an analysis record and to associate
// the analysis record with a CrashClass record. This funciton requires
// that the caller has identified a CrashClass record.
//
BOOL
KaDbAddAnalysis(
    IN  HANDLE      DbConnection,
    IN  PKADB_ANALYSIS Analysis,
    OUT PLONG32     AnalysisID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

#define KADB_UP_ANALYSIS_ABSTRACT       0x0001 // Updates abstract field
#define KADB_UP_ANALYSIS_PROBLEM_DESC   0x0002 // Updates problem desc field
#define KADB_UP_ANALYSIS_KEYWORDS       0x0004 // Updates keyword field
#define KADB_UP_ANALYSIS_STATUS         0x0008 // Updates status field

//
// This function is the generalize update function used to update an
// analysis record. It requires the user to have previously identified
// an Analysis record.
//
BOOL
KaDbUpdateAnalysis(
    IN  HANDLE      DbConnection,
    IN  UINT64      UpdateFlags,
    IN  LONG32      AnalysisID,
    IN  PKADB_ANALYSIS Analysis,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// HWProfile Table
//

typedef struct _KADB_HW_PROFILE {
    LPSTR   Architecture;
    LPSTR   ProcessorType;
    LPSTR   ProcessorSpec;
    LPSTR   ProcessorVendor;
    BYTE    ProcessorCount;
    ULONG32 OccurrenceCount;
} KADB_HW_PROFILE, *PKADB_HW_PROFILE;

//
// This function is used to query the HWProfile table for a matching
// analysis. A callback routine is provided to enumerate HWProfile records
// found within the rowset.  The invoked called back must return TRUE to
// obtain the next subsequent record within the rowset.
//
BOOL
KaDbGetHWProfile(
    IN  HANDLE      DbConnection,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to add a HWProfile record to the database.
//
BOOL
KaDbAddHWProfile(
    IN  HANDLE      DbConnection,
    IN  PKADB_HW_PROFILE HWProfile,
    OUT PLONG32     HWProfileRecID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// This function is used to update the occurrence count of HW Profile record.
//
BOOL
KaDbUpdateHWProfileOccurrenceCount(
    IN  HANDLE      DbConnection,
    IN  LONG32      HWProfileRecID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// OSProfile Table
//

#define  KADB_OSP_FLAG_CHECKED_BUILD    0x00000001
#define  KADB_OSP_FLAG_SMP_KERNEL       0x00000002
#define  KADB_OSP_FLAG_PAE_KERNEL       0x00000004

typedef struct _KADB_OS_PROFILE {
    ULONG32 Flags;
    USHORT  Build;
    SHORT   ServicePackLevel;
    LPSTR   ProductType;
    LPWSTR  QfeData;
    ULONG32  OccurrenceCount;
} KADB_OS_PROFILE, *PKADB_OS_PROFILE;

//
// This function is used to query the OSProfile table for a matching
// analysis. A callback routine is provided to enumerate OSProfile records
// found within the rowset.  The invoked called back must return TRUE to
// obtain the next subsequent record within the rowset.
//
BOOL
KaDbGetOSProfile(
    IN  HANDLE      DbConnection,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to add a OSProfile record to the database.
//
BOOL
KaDbAddOSProfile(
    IN  HANDLE  DbConnection,
    IN  PKADB_OS_PROFILE OSProfile,
    OUT PLONG32     OSProfileRecID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// This function is used to update the occurrence count of OS Profile record.
//
BOOL
KaDbUpdateOSProfileOccurrenceCount(
    IN  HANDLE      DbConnection,
    IN  LONG32      OSProfileRecID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// HintData Table
//

typedef struct _KADB_HINT_DATA {
    LPWSTR  Data;
} KADB_HINT_DATA, *PKADB_HINT_DATA;

BOOL
KaDbGetHintData(
    IN  HANDLE      DbConnection,
    IN  LONG32      SolutionID,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

BOOL
KaDbAddHintData(
    IN  HANDLE      DbConnection,
    IN  LONG32      SolutionID,
    IN  PKADB_HINT_DATA HintData,
    OUT PLONG32     DataID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

#define KADB_UP_HINT_SOLUTIONID 0x0001
#define KADB_UP_HINT_DATA       0x0002

BOOL
KaDbUpdateHintData(
    IN  HANDLE      DbConnection,
    IN  UINT64      UpdateFlags,
    IN  LONG32      DataID,
    IN  LONG32      SolutionID,
    IN  PKADB_HINT_DATA pHintData,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// ProgressText Table
//

typedef struct _KADB_PROGRESS_TEXT {
    SYSTEMTIME  DateTime;
    LPWSTR      Author;
    LPWSTR      Annotation;
} KADB_PROGRESS_TEXT, *PKADB_PROGRESS_TEXT;

//
// This function is used to query for ProgressText records given an
// AnalysisID.  A callback routine is provided to enumerate ProgressData
// records found within the rowset.
// The query is limited to ProgressData records that are associated with a
// specific Analysis record.
//
BOOL
KaDbGetProgressText(
    IN  HANDLE      DbConnection,
    IN  LONG32      AnalysisID,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to create a ProgressText record and to associate
// that ProgressText with an analysis record.
//
BOOL
KaDbAddProgressText(
    IN  HANDLE      DbConnection,
    IN  LONG32      AnalysisID,
    IN  PKADB_PROGRESS_TEXT ProgressText,
    OUT PLONG32     ProgressTextID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// KernelModuleData Table
//

typedef struct _KADB_KERNEL_MODULE_DATA {
    LPWSTR      BaseName;
    LONG32      Size;
    LPSTR       CheckSum;
    SYSTEMTIME  DateTime;
    SHORT       SubsystemMajorVersion;
    SHORT       SubsystemMinorVersion;
} KADB_KERNEL_MODULE_DATA, *PKADB_KERNEL_MODULE_DATA;

//
// This function is used to query the KernelModuleData table for matching
// records. A callback routine is provided to enumerate KernelModuleData
// records found within the returned rowset.  The invoked callback routine
// must return TRUE to obtain the next subsequent record within the rowset.
//
BOOL
KaDbGetKernelModuleData(
    IN  HANDLE      DbConnection,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to add a new KernelModuleData record to the database.
//
BOOL
KaDbAddKernelModuleData(
    IN  HANDLE      DbConnection,
    IN  PKADB_KERNEL_MODULE_DATA KernelModuleData,
    OUT PLONG32     KernelModuleID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// KernelModule Table
//

typedef struct _KADB_KERNEL_MODULE {
    LPSTR  LoadAddress;
    KADB_KERNEL_MODULE_DATA KernelModuleData;
} KADB_KERNEL_MODULE, *PKADB_KERNEL_MODULE;

//
// This function is used to query the KernelModule and KernelModuleData
// tables to obtain a list of kernel modules that are associated with
// a specific crash instance and/or to acquire specific information
// regarding a kernel module that is associated with a crash instance.
//
BOOL
KaDbGetKernelModule(
    IN  HANDLE      DbConnection,
    IN  LONG32      ClassID,
    IN  LONG32      InstanceID,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to create a new KernelModule record within
// the database. It requires that a KernelModuleData record be first
// identified (or added) as well as the identification of a crash instance
// and CrashClass record.
//
BOOL
KaDbAddKernelModule(
    IN  HANDLE      DbConnection,
    IN  LONG32      ClassID,
    IN  LONG32      InstanceID,
    IN  LONG32      KernelModuleID,
    IN  PKADB_KERNEL_MODULE KernelModule,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );


//
// KanalyzeModuleData Table
//

typedef struct _KADB_KANALYZE_MODULE_DATA {
    LPWSTR  BaseName;
    LPSTR   Type;
    LPWSTR  AlternateName;
    USHORT  MajorVersion;
    USHORT  MinorVersion;
    LPWSTR  Description;
} KADB_KANALYZE_MODULE_DATA, *PKADB_KANALYZE_MODULE_DATA;

//
// This function is used to query the KanalyzeModuleData table for a
// matching crash. A callback routine is provided to enumerate
// KanalyzeModuleData records found within the returned rowset.  The
// invoked callback routine must return TRUE to obtain the next subsequent
// record within the rowset.
//
BOOL
KaDbGetKanalyzeModuleData(
    IN  HANDLE      DbConnection,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to add a new KernelModuleData record to the database.
//
BOOL
KaDbAddKanalyzeModuleData(
    IN  HANDLE      DbConnection,
    IN  PKADB_KANALYZE_MODULE_DATA KanalyzeModuleData,
    OUT PLONG32     KanalyzeModuleID,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// KanalyzeModule Table
//

//
// This function is used to query the KernelModule and KernelModuleData
// tables to obtain a list of kernel modules that are associated with
// a specific crash instance and/or to acquire specific information
// regarding a kernel module that is associated with a crash instance.
//
BOOL
KaDbGetKanalyzeModule(
    IN  HANDLE      DbConnection,
    IN  LONG32      ClassID,
    IN  LONG32      InstanceID,
    IN  LPCWSTR     pwszMatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to add a new KanalyzeModule record to the database.
//
BOOL
KaDbAddKanalyzeModule(
    IN  HANDLE      DbConnection,
    IN  LONG32      ClassID,
    IN  LONG32      InstanceID,
    IN  LONG32      KanalyzeModuleID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// AttachmentData Table
//

typedef struct _KADB_ATTACHMENT_DATA {
    LPWSTR      Location;
    LONG32      Size;
    LPWSTR      Description;
    SYSTEMTIME  DateTime;
} KADB_ATTACHMENT_DATA, *PKADB_ATTACHMENT_DATA;

//
// This function is used to query the AttachmentData table for a matching
// crash. A callback routine is provided to enumerate AttachmentData
// records found within the rowset.  The invoked callback must return
// TRUE to obtain the next subsequent record within the rowset.
//
BOOL
KaDbGetAttachmentData(
    IN  HANDLE      DbConnection,
    IN  LONG32      ClassID,
    IN  LONG32      InstanceID,
    IN  LPCWSTR pwszMatchString,
    IN  PKADB_ENUM_DATA_CALLBACK CallBack,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is called as part of adding a crash instance and is used
// to add Attachment records. Prior to invoking this call, the caller must
// have identified a CrashClass and CrashInstance record.
//
BOOL
KaDbAddAttachmentData(
    IN  HANDLE      DbConnection,
    IN  LONG32      ClassID,
    IN  LONG32      InstanceID,
    IN  PKADB_ATTACHMENT_DATA AttachmentData,
    OUT PLONG32     ItemID,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// Variable Table
//

typedef struct _KADB_VARIABLE_CRASH_DATA {
    LPWSTR  BlobName;
    LPWSTR  BlobWriterID;
    ULONG32 DataLength;
    PUCHAR  Data;        // Blob data follows structure. 
} KADB_VARIABLE_CRASH_DATA, *PKADB_VARIABLE_CRASH_DATA;

//
// This function is used to query the VariableCrashData table for
// a matching crash. A callback routine is provided to enumerate
// VariableCrashData records found within the rowset.  The invoked
// callback must return TRUE to obtain the next subsequent record within
// the rowset.
//
BOOL
KaDbGetVariableCrashData(
    IN  HANDLE      DbConnection,
    IN  LONG32      ClassID,
    IN  LONG32      InstanceID,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK CallBack,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// This function is used to add variable crash data to a crash instance
// record.  Prior to invoking this call, the caller must have identified
// a CrashClass and CrashInstance record.
//
BOOL
KaDbAddVariableCrashData(
    IN  HANDLE      DbConnection,
    IN  LONG32      ClassID,
    IN  LONG32      InstanceID,
    IN  PKADB_VARIABLE_CRASH_DATA VariableCrashData,
    IN  PVOID       Reserved,
    IN  UINT_PTR    Reserved2
    );

//
// ProcessorType
//

typedef struct _KADB_PROCESSOR_TYPE {
   LONG32      VendorID;
   LPSTR       Type;
   USHORT      Family;
   USHORT      Model;
   USHORT      Step;
} KADB_PROCESSOR_TYPE, *PKADB_PROCESSOR_TYPE;

//
// ProcessorVendor
//

typedef struct _KADB_PROCESSOR_VENDOR {
   LPSTR    VendorName;
} KADB_PROCESSOR_VENDOR, *PKADB_PROCESSOR_VENDOR;

// This structure represents the result of Joined Query between
// the ProcessorType table and ProcessorVendor table.
//
typedef struct _KADB_PROCESSOR_TYPE_PROCESSOR_VENDOR {
    struct _KADB_PROCESSOR_TYPE    ProcessorType;
    struct _KADB_PROCESSOR_VENDOR  ProcessorVendor;   
} KADB_PROCESSOR_TYPE_PROCESSOR_VENDOR, *PKADB_PROCESSOR_TYPE_PROCESSOR_VENDOR;


// This function is used to query the ProcessorType and ProcessorVendor
// tables to obtain a list of processor information.
//

BOOL
KaDbGetProcessorTypeProcessorVendor(
    IN  HANDLE      DbConnection,
    IN  LPCWSTR     MatchString,
    IN  PKADB_ENUM_DATA_CALLBACK Callback,
    IN  PVOID       CallBackParm,
    IN  UINT_PTR    Reserved
    );

//
// Error data
//
typedef struct _KADB_ERROR {
    ULONG32 HResult;
    LPCWSTR Description;
    LPCWSTR SQLInfo;
    LPCWSTR Source;
} KADB_ERROR, *PKADB_ERROR;

BOOL
KaDbGetLastError(
    IN PKADB_ENUM_DATA_CALLBACK Callback
    );

#ifdef __cplusplus
}
#endif

#endif // _KADBPROV_H_
