/*++

Copyright (c) 1998 Microsoft Corporation

Module Name:

    kapublic.h

Abstract:

   StopCode plugin - Kernel Memory Space Analyzer.

Author:

     Basil Thomas (v-basilt) 30 Sep 1999

Revision History:

--*/

///////////////////////////////////////////////////////////////////////////
//
// Public definitions for plug-in "STOPCODE"
//
// Type                        Method
// --------------------------------------------------------------
// Analysis\Summary            M_STOPCODE_GET_SOLUTION_TEXT
//                             M_STOPCODE_GET_KI_BUG_CHECK_DRIVER
//                             M_STOPCODE_GET_POOL_INFO
//                             M_STOPCODE_GET_MODULE_NAME
//                             M_STOPCODE_GET_ROUTINE_NAME
//                             M_STOPCODE_GET_ROUTINE_OFFSET
//                             M_STOPCODE_GET_MODULE_OFFSET
//                             M_STOPCODE_GET_STACK_TRACE_INFO
//
/////////////////////////////////////////////////////////////////////////

#define STOP_CODE_PLUGIN_NAME L"STOPCODE"
#define RESULT_BRANCH         L"Analysis\\Summary"

typedef struct _STACK_INFO
{
    WCHAR   ModuleName[MAX_PATH]; /* module name*/
    WCHAR   SymbolName[MAX_PATH]; /* function name */
    UINT64  ModuleOffset;         /* Module offset */
    UINT64  SymbolOffset;         /* function offset */
    UINT32  cArguments;           /* number of arguments */
    UINT64  Arguments[4];         /* arguments */
}STACK_INFO, *PSTACK_INFO;


#define M_STOPCODE_GET_SOLUTION_TEXT            1
//
//UINT32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//    IN HKAPLUGIN  PlugInHandle,
//    IN KA_ITEM_ID ItemId,
//    IN UINT32     MethodCode,
//    OUT PWCHAR    SolutionText,
//    IO  DWORD     *Length
//    )
//
// Routine Description:
//
//     This routine returns a basic information of Analysis\Summary item.
//
// Arguments:
//
//     PlugInHandle - specify your plug-in handle.
//
//     ItemId - specify Analysis\Summary  item id.
//
//     MethodCode - specify M_STOPCODE_GET_SOLUTION_TEXT.
//
//     SolutionText - Pointer to the WCHAR string, can be null
//     Length       - Size of the buffer, if the SolutionText is null then returns 
//                    the size of the memory required to hold the SolutionText
//
// Return Value:
//
//     Win32 error code
//

#define M_STOPCODE_GET_KI_BUG_CHECK_DRIVER      2
//
//UINT32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//    IN HKAPLUGIN  PlugInHandle,
//    IN KA_ITEM_ID ItemId,
//    IN UINT32     MethodCode,
//    OUT PWCHAR    BugChcekDriverName
//    )
//
// Routine Description:
//
//     This routine returns a basic information of Analysis\Summary item.
//
// Arguments:
//
//     PlugInHandle - specify your plug-in handle.
//
//     ItemId - specify Analysis\Summary  item id.
//
//     MethodCode - specify M_STOPCODE_GET_KI_BUG_CHECK_DRIVER.
//
//     BugChcekDriverName - Pointer to the unicode string size of MAX_PATH
//                          returns the the string in the "KiBugCheckDriver"
//
// Return Value:
//
//     Win32 error code
//

#define M_STOPCODE_GET_POOL_INFO                3
//
//UINT32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//    IN HKAPLUGIN  PlugInHandle,
//    IN KA_ITEM_ID ItemId,
//    IN UINT32     MethodCode,
//    OUT PWCHAR    PoolInfo
//    )
//
// Routine Description:
//
//     This routine returns a basic information of Analysis\Summary item.
//
// Arguments:
//
//     PlugInHandle - specify your plug-in handle.
//
//     ItemId - specify Analysis\Summary  item id.
//
//     MethodCode - specify M_STOPCODE_GET_POOL_INFO.
//
//     PoolInfo  - Pointer to the unicode string size of MAX_PATH
//                 the pool info formatted as 
//                      ModuleName!Offset[PollLocation!Offset]:Tag
//
// Return Value:
//
//     Win32 error code
//

#define M_STOPCODE_GET_MODULE_NAME              4
//
//UINT32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//    IN HKAPLUGIN  PlugInHandle,
//    IN KA_ITEM_ID ItemId,
//    IN UINT32     MethodCode,
//    OUT PWCHAR    ModuleName
//    )
//
// Routine Description:
//
//     This routine returns a basic information of Analysis\Summary item.
//
// Arguments:
//
//     PlugInHandle - specify your plug-in handle.
//
//     ItemId - specify Analysis\Summary  item id.
//
//     MethodCode - specify M_STOPCODE_GET_MODULE_NAME.
//
//     ModuleName  - Pointer to the unicode string size of MAX_PATH
//                      Returnes the module which caused the excetion
//
// Return Value:
//
//     Win32 error code
//



#define M_STOPCODE_GET_ROUTINE_NAME             5
//
//UINT32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//    IN HKAPLUGIN  PlugInHandle,
//    IN KA_ITEM_ID ItemId,
//    IN UINT32     MethodCode,
//    OUT PWCHAR    RoutineName
//    )
//
// Routine Description:
//
//     This routine returns a basic information of Analysis\Summary item.
//
// Arguments:
//
//     PlugInHandle - specify your plug-in handle.
//
//     ItemId - specify Analysis\Summary  item id.
//
//     MethodCode - specify M_STOPCODE_GET_ROUTINE_NAME.
//
//     RoutineName  - Pointer to the unicode string size of MAX_PATH
//                      Returnes the routine which caused the excetion
//
// Return Value:
//
//     Win32 error code
//

#define M_STOPCODE_GET_ROUTINE_OFFSET           6
//
//UINT32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//    IN HKAPLUGIN  PlugInHandle,
//    IN KA_ITEM_ID ItemId,
//    IN UINT32     MethodCode,
//    OUT DWORD     *RoutineOffset
//    )
//
// Routine Description:
//
//     This routine returns a basic information of Analysis\Summary item.
//
// Arguments:
//
//     PlugInHandle - specify your plug-in handle.
//
//     ItemId - specify Analysis\Summary  item id.
//
//     MethodCode - specify M_STOPCODE_GET_ROUTINE_OFFSET.
//
//     RoutineOffset  - the offset with in the Routine, will be ZERO if the routine
//                       canot be identified        
//
// Return Value:
//
//     Win32 error code
//

#define M_STOPCODE_GET_MODULE_OFFSET            7
//
//UINT32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//    IN HKAPLUGIN  PlugInHandle,
//    IN KA_ITEM_ID ItemId,
//    IN UINT32     MethodCode,
//    OUT DWORD     *ModuleOffset
//    )
//
// Routine Description:
//
//     This routine returns a basic information of Analysis\Summary item.
//
// Arguments:
//
//     PlugInHandle - specify your plug-in handle.
//
//     ItemId - specify Analysis\Summary  item id.
//
//     MethodCode - specify M_STOPCODE_GET_MODULE_OFFSET.
//
//     ModuleOffset  - the offset with in the Module.
//
// Return Value:
//
//     Win32 error code
//

#define M_STOPCODE_GET_STACK_TRACE_INFO         8
//
//UINT32
//(KANALYZE_CALL_METHOD_ROUTINE)(
//    IN HKAPLUGIN  PlugInHandle,
//    IN KA_ITEM_ID ItemId,
//    IN UINT32     MethodCode,
//    OUT PSTACK_INFO   pStackInfo,
//    IO  DWORD     *NumberOfStackInfo
//    )
//
// Routine Description:
//
//     This routine returns a basic information of Analysis\Summary item.
//
// Arguments:
//
//     PlugInHandle - specify your plug-in handle.
//
//     ItemId - specify Analysis\Summary  item id.
//
//     MethodCode - specify M_STOPCODE_GET_MODULE_OFFSET.
//
//     pStackInfo  - array of StackInfo structure, can be null.
//     NumberOfStackInfo - the number of the elements in the array, if pStackInfo is
//                          null then returns the count of stack info
//  
// Return Value:
//
//     Win32 error code
//