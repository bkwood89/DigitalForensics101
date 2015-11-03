
typedef PVOID HSIGIDFILE;

#define SIGIDFILE_ALTNAME_MAX       50
#define SIGIDFILE_DESCRIPTION_MAX   256
#define SIGIDFILE_ROUTINENAME_MAX   256
#define SIGIDFILE_EXTERNAL_MAX      100

//
// These structures describe the kanalyze environment that created
// the signature id file.
//
typedef struct _SIGIDFILE_KANALYZE_MODULE {
    USHORT MajorVersion;
    USHORT MinorVersion;
    DWORD Type;
    WCHAR BaseName[MAX_PATH];
    WCHAR AlternateName[SIGIDFILE_ALTNAME_MAX];   // such as plug-in shortname
    WCHAR Description[SIGIDFILE_DESCRIPTION_MAX]; // OPTIONAL human-readable description
} SIGIDFILE_KANALYZE_MODULE, *PSIGIDFILE_KANALYZE_MODULE;

#define SIGIDFILE_KANALYZE_MODULE_MASTER    1   // exe, wrapper app, etc
#define SIGIDFILE_KANALYZE_MODULE_PLUGIN    2
#define SIGIDFILE_KANALYZE_MODULE_DLL       3   // non-plug-in DLL
#define SIGIDFILE_KANALYZE_MODULE_OTHER     4

typedef struct _SIGIDFILE_KANALYZE_ENVIRONMENT {
    USHORT MajorVersion;
    USHORT MinorVersion;
    DWORD ModuleCount;
    SIGIDFILE_KANALYZE_MODULE Modules[ANYSIZE_ARRAY];
} SIGIDFILE_KANALYZE_ENVIRONMENT, *PSIGIDFILE_KANALYZE_ENVIRONMENT;


//
// OS Module information.
//
typedef struct _SIGIDFILE_OS_MODULE {
    UINT64 LoadAddress;
    DWORD Size;
    DWORD Checksum;
    FILETIME DateTime;
    USHORT SubsystemMajorVersion;
    USHORT SubsystemMinorVersion;
    WCHAR BaseName[MAX_PATH];
} SIGIDFILE_OS_MODULE, *PSIGIDFILE_OS_MODULE;


//
// Canonical-form/crash class data.
//
typedef struct _SIGIDFILE_CANONICAL_DATA {
    DWORD StructVersion;
    DWORD CanonicalizationLevel;
    UCHAR StopParams[4][SIGIDFILE_DESCRIPTION_MAX];
    UCHAR Keywords[4][SIGIDFILE_DESCRIPTION_MAX];
} SIGIDFILE_CANONICAL_DATA, *PSIGIDFILE_CANONICAL_DATA;

#define SIGIDFILE_CANONICAL_STRUCT_VERSION  1

//
// Crash instance data.
//
typedef struct _SIGIDFILE_CRASH_INSTANCE_DATA {
    DWORD StructVersion;
    DWORD StopCode;
    UINT64 StopParams[4];
    DWORD Flags;
    DWORD OSBuild;
    DWORD OSServicePackLevel;   // if we can determine it
    DWORD OSBuildFlags;         // checked/free, etc (see below)
    DWORD ProductType;          // see below
    DWORD Architecture;         // x86, alpha, etc
    DWORD ProcessorType;        // 486, pentium, PII, PIII, etc
    DWORD ProcessorSpec;        // revision/stepping
    DWORD ProcessorVendor;
    BYTE ProcessorCount;
    FILETIME DateTime;
    DWORD ModuleCount;
    WCHAR QfeData[SIGIDFILE_DESCRIPTION_MAX];
    SIGIDFILE_OS_MODULE Modules[ANYSIZE_ARRAY];
} SIGIDFILE_CRASH_INSTANCE_DATA, *PSIGIDFILE_CRASH_INSTANCE_DATA;

#define SIGIDFILE_INSTANCE_STRUCT_VERSION   0x10001

#define SIGIDFILE_OS_CHECKED    0x00000001  // checked build (else free)
#define SIGIDFILE_OS_PAE        0x00000002  // PAE kernel
#define SIGIDFILE_OS_MP         0x00000004  // MP kernel
#define SIGIDFILE_OS_QFE        0x00000008  // if we can determine it

//
// It's unclear if we can determine all of these from a dump file.
//
#define SIGIDFILE_PRODUCT_UNSPEC        0       // unknown/unspecified
#define SIGIDFILE_PRODUCT_WORKSTATION   1       // workstation
#define SIGIDFILE_PRODUCT_SERVER_UNSPEC 2       // server, but we don't know which
#define SIGIDFILE_PRODUCT_SERVER        3       // server product (nt4, w2k)
#define SIGIDFILE_PRODUCT_ADVSERVER     4       // advanced server (w2k only)
#define SIGIDFILE_PRODUCT_DATACENTER    5       // datacenter server (w2k only)
#define SIGIDFILE_PRODUCT_HYDRA         6       // terminal server (NT4 only)
#define SIGIDFILE_PRODUCT_SMALLBIZ      7       // small business server


//
// This structure is used when retrieving a list of variable data
// (ie, blobs) which plug-ins have attached to the signature id file.
//
typedef struct _SIGIDFILE_DATABLOB {
    struct _SIGIDFILE_DATABLOB *Next;
    LPWSTR BlobWriterId;
    LPWSTR BlobName;
    DWORD DataLength;
    PVOID Data;
    //
    // Following this, packed in the buffer, is
    //
    // WCHAR BlobWriterId[ANYSIZE_ARRAY];
    // WCHAR BlobName[ANYSIZE_ARRAY];
    // BYTE Data[DataLength];
    //
    // The next structure in the buffer will be aligned on a 4-byte boundary.
    //
} SIGIDFILE_DATABLOB, *PSIGIDFILE_DATABLOB;


//
// Attachments. An attachment is uniquely identified within a sigidfile
// by a tag.
//
typedef struct _SIGIDFILE_ATTACHMENT_INFO {
    FILETIME DateTimeStamp;
    DWORD Size;
    WCHAR Location[MAX_PATH];
    WCHAR Description[SIGIDFILE_DESCRIPTION_MAX];
} SIGIDFILE_ATTACHMENT_INFO, *PSIGIDFILE_ATTACHMENT_INFO;


//
// This routine is for creating a new sigidfile. It cannot be used to
// open an existing file. When a new sigidfile is created, a reasonable
// default is created (ie, no blobs or attachments, empty solution data,
// etc). But the caller must provide "instance" type data when the
// sigidfile is created, such as the kanalyze environment, OS environment
// info, and crash instance data.
//
DWORD
SigIdFileCreate(
    IN LPCWSTR FileName,
    OUT HSIGIDFILE *Handle,
    IN PSIGIDFILE_KANALYZE_ENVIRONMENT KanalyzeEnvironment,
    IN PSIGIDFILE_CRASH_INSTANCE_DATA CrashInstanceData,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine is for opening an existing sigidfile.
//
DWORD
SigIdFileOpen(
    IN LPCWSTR FileName,
    OUT HSIGIDFILE *Handle,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine is for closing an open sigidfile. If may perform some
// housekeeping on the file so be sure to check the return code.
// The Handle is in/out because we overwrite the caller's variable to
// help reduce problems where someone tries to use a signature id file
// after it's been closed.
//
DWORD
SigIdFileClose(
    IN OUT HSIGIDFILE *Handle,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine is used to query kanalyze evironment information from
// a signature id file. Because the kanalyze environment data has variable
// length, the caller can call the routine without specifiying a buffer
// to determine how large a buffer must be to hold the data.
//
DWORD
SigIdFileQueryKanalyzeEnvironment(
    IN HSIGIDFILE Handle,
    OUT PSIGIDFILE_KANALYZE_ENVIRONMENT Environment,    OPTIONAL
    IN DWORD BufferSize,                                OPTIONAL
    OUT LPDWORD DataSize,                               OPTIONAL
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine is used to write crash canonical data into a sigidfile.
// Plug-ins use this to write canonical data once they've figured out
// the canonical form for the crash instance data. In general once
// canonical data has been set it cannot be overwritten (to encourage
// plug-ins to play nicely and coordinate) but a flag allows this behavior
// to be changed.
//
DWORD
SigIdFileSetCanonicalData(
    IN HSIGIDFILE Handle,
    IN PSIGIDFILE_CANONICAL_DATA CanonicalData,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

#define SIGIDFILE_CANONICAL_ALLOW_OVERWRITE  0x00000001

//
// This routine is used to read the current canonical data from the sigidfile.
// No flags are defined at this time.
//
DWORD
SigIdFileGetCanonicalData(
    IN HSIGIDFILE Handle,
    OUT PSIGIDFILE_CANONICAL_DATA CanonicalData,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine is used to read crash instance data (including OS/software
// environment information) from the signature id file. Note that there is
// no corresponding set function, because instance data is set only once,
// when the sigidfile is created. The returned data has variable length,
// so the caller can call the routine in such a way as to determine the
// required size of the buffer he must provide to read the data.
//
DWORD
SigIdFileGetCrashInstanceData(
    IN HSIGIDFILE Handle,
    OUT PSIGIDFILE_CRASH_INSTANCE_DATA Data,    OPTIONAL
    IN DWORD BufferSize,                        OPTIONAL
    OUT LPDWORD DataSize,                       OPTIONAL
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine is used to add a data blob into the sigidfile. A blob
// has a writer id (used to identify which plug-in wrote the data into
// the sigidfile), a name tag (which must be unique across all plug-ins),
// a size, and the free-form data itself.
//
DWORD
SigIdFileAddDataBlob(
    IN HSIGIDFILE Handle,
    IN LPCWSTR BlobWriterId,
    IN LPCWSTR BlobName,
    IN PVOID Data,
    IN DWORD DataSize,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

#define SIGIDFILE_BLOB_OVERWRITE    0x00000001  // overwrite if exists
#define SIGIDFILE_BLOB_APPEND       0x00000002  // append to existing data

//
// This routine is used to delete a blob from a sigidfile.
//
DWORD
SigIdFileDeleteDataBlob(
    IN HSIGIDFILE Handle,
    IN LPCWSTR BlobName,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine returns the data for one data blob. The caller need not know
// which plug-in actually wrote the blob, because the blob names are unique
// across all plug-ins. The caller must provide the storage and can call the
// routine in such a way as to get the required size, or merely to determine
// if a blob is actually present in the sigidfile.
//
DWORD
SigIdFileQueryDataBlobData(
    IN HSIGIDFILE Handle,
    IN LPCWSTR BlobName,
    OUT PVOID Data,             OPTIONAL
    IN DWORD BufferSize,        OPTIONAL
    OUT LPDWORD DataSize,       OPTIONAL
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine returns lists of data blobs currently in the sigidfile.
// It can be used to get all the blobs written by a particular plug-in, and/or
// perform wildcard matchings of blob names. The caller provides storage for
// the returned data, which is packed into the buffer. The caller can call
// the routine in such a way as to determine the size required for the buffer.
//
DWORD
SigIdFileGetDataBlobList(
    IN HSIGIDFILE Handle,
    IN LPCWSTR BlobWriterIdPattern, OPTIONAL
    IN LPCWSTR BlobNamePattern,     OPTIONAL
    OUT PSIGIDFILE_DATABLOB Blobs,  OPTIONAL
    IN DWORD BufferSize,            OPTIONAL
    OUT LPDWORD DataSize,           OPTIONAL
    OUT LPDWORD BlobCount,          OPTIONAL
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

#define SIGIDFILE_BLOB_GET_DATA 0x00000001  // return actual blob data

//
// This routine is used to set an attachment into the sigidfile.
// Ordinarily only one instance of an attachment (as identified by tag)
// is allowed, but this behavior can be overridden.
//
DWORD
SigIdFileAttachAttachment(
    IN HSIGIDFILE Handle,
    IN LPCWSTR Tag,
    IN PSIGIDFILE_ATTACHMENT_INFO Attachment,
    OUT LPDWORD Instance,                       OPTIONAL
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

#define SIGIDFILE_ATTACHMENT_REPLACE    0x00000001  // overwrite (based on tag+instance)
#define SIGIDFILE_ATTACHMENT_MULTIPLE   0x00000002  // allow multiple instances of a tag

//
// This routine is used to dissociate (remove) an attachment.
// If Flags includes SIGIDFILE_ATTACHMENT_MULTIPLE, then Instance is ignored
// and all attachments matching the given tag are removed.
// After removal, the instance number of remaining attachments with the
// given tag are reshuffled to keep them contiguous.
//
DWORD
SigIdFileDetachAttachment(
    IN HSIGIDFILE Handle,
    IN LPCWSTR Tag,
    IN DWORD Instance,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine queries the number of attachments that match a given tag.
// No flags are defined at this time.
//
DWORD
SigIdFileGetAttachmentTagInstanceCount(
    IN HSIGIDFILE Handle,
    IN LPCWSTR Tag,
    OUT LPDWORD InstanceCount,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine retrieves a single instance of an attachment matching
// a given tag. This routine does not actually try to look at the
// attachment; that's the caller's responsibility.
// No flags are defined at this time.
//
DWORD
SigIdFileGetAttachment(
    IN HSIGIDFILE Handle,
    IN LPCWSTR Tag,
    IN DWORD Instance,
    OUT PSIGIDFILE_ATTACHMENT_INFO Attachment,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine is used to write analysis text into the sigidfile.
// In some cases kanalyze can determine significant details about the crash,
// which can be placed in the database.
//
DWORD
SigIdFileWriteAnalysisText(
    IN HSIGIDFILE Handle,
    IN LPCWSTR Abstract,            OPTIONAL
    IN LPCWSTR ProblemDescription,
    IN LPCWSTR Keywords,            OPTIONAL
    IN LPCSTR Status
    );

//
// This routine is used to retrieve any analysis text in the sigidfile.
//
DWORD
SigIdFileGetAnalysisText(
    IN HSIGIDFILE Handle,
    IN OUT LPDWORD AbstractLength,
    OUT LPWSTR Abstract,
    IN OUT LPDWORD ProblemDescriptionLength,
    OUT LPWSTR ProblemDescription,
    IN OUT LPDWORD KeywordsLength,
    OUT LPWSTR Keywords,
    IN OUT LPDWORD StatusLength,
    OUT LPSTR Status
    );

//
// This routine sets the external record locators. Any existing record
// locators are silently deleted. If both Customer and ServiceRecord
// are NULL then the record locators are deleted.
//
DWORD
SigIdFileSetExternalLocators(
    IN HSIGIDFILE Handle,
    IN LPCWSTR Customer,        OPTIONAL
    IN LPCSTR ServiceRecord,    OPTIONAL
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

//
// This routine retrieves external locators previously set with
// SigIdFileSetExternalLocators.
//
DWORD
SigIdFileGetExternalLocators(
    IN HSIGIDFILE Handle,
    IN OUT LPDWORD CustomerLength,
    OUT LPWSTR Customer,
    IN OUT LPDWORD ServiceRecordLength,
    OUT LPSTR ServiceRecord,
    IN DWORD Flags,
    UINT_PTR ReservedMustBe0
    );

