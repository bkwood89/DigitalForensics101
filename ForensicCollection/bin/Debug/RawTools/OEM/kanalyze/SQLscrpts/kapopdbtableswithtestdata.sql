/*++

Copyright (c) 1999 Microsoft Corporation

Module Name:

    KaPopTablesWithTestData.sql

Abstract:

    This script is used to populate the Tables with test data.

	
Author:

    Peter Hiross (v-peteh) & Dick Tanabe ( v-dickta ) 	September 27, 1999

Revision History:

    Dick Tanabe (v-dickta)        Sep 28, 1999  Revised script to drop triggers, create stored
                                                                     procedures, and populate static tables.
    Dick Tanabe (v-dickta)        Dec 03, 1999  Revised script for case sensitivity, Raid Bug 585

--*/
USE KaKnownIssue
Go

PRINT ( 'Using KaKnownIssue Database...')

SET NOCOUNT ON

PRINT ( 'Populating The Solution Table' )

SET IDENTITY_INSERT Solution ON

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 2, 'When the process ID (PID) of any given process exceeds 65,535 bytes, Win32k.sys generates the following blue screen error message: STOP 0x0000001e {0xc000005, 0xa1000aa7, 0x00000000, 0x00440194} NOTE: The first parameter will always be 0xc0000005 and the second parameter will always fall within the memory range of Win32k.sys.','Refer to Article ID Q224982 in the Microsoft Knowledge Database for the resolution to this problem.','1999-08-27 06:33:00')

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 3, 'The following Blue Screen may occur intermittently on a multiprocessor computer. 
STOP 0x0000000A (0x00000014, 0x00000002, 0x00000000, 0xf5a178ce)  IRQL_NOT_LESS_OR_EQUAL
Address f5a178ce has base at f5a10000 - NETBT.SYS 
NOTE: The first and second parameter will always be identical to the above mentioned. The fourth parameter can be different.','Refer to Article ID Q173881 in the Microsoft Knowledge Database for the resolution to this problem.','1999-04-10 12:05:00')

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 4, 'Srv.sys can generate Stop 0X0000001E (0xC0000005, 0xfcb6e8f7, 0x00000000, 0x0000004C)
KMODE_EXCEPTION_NOT_HANDLED Address fcb6e8f7 has base at fcb5d000 - SRV.SYS 
NOTE: The second parameter in parenthesis will depend on your system configuration and may be different but will fall in range with Srv.sys.','Refer to Article ID Q163855 in the Microsoft Knowledge Database for the resolution to this problem.','1999-04-10 15:24:00')

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 5,'A computer running Windows NT may stop with a blue screen Stop 0xA error in Netbt.sys when it attempts to resolve a name in the DNS namespace.When performing name resolution operations in some environments, Windows NT computers dereference a tracking object twice.','Refer to Article ID Q214429 in the Microsoft Knowledge Database for the resolution to this problem.','1999-08-27 21:03:00')

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 6,'Service Pack 3 on a Windows NT 4.0 RAS server using the Digiboard ISDN RAS board, the server will display a blue screen error message with the following STOP code: STOP 0x0000000A (0x0000048, 0x00000000, 0x000000002, 0xf8d54f88)
IRQL_NOT_LESS_OR_EQUAL: 0xf8d54f88 has base at 0xf8d50000NDISWAN.SYS. NOTE: The first parameteris the same each time.','Refer to Article ID Q174509 in the Microsoft Knowledge Database for the resolution to this problem.','1999-04-10 11:24:00')

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 7, 'Windows NT 4.0 Service Pack 4 may stop responding (hang) and display the following STOP error message on a blue screen: STOP 0x0000000a (0x00000006, 0x00000002, 0x00000000, 0xf1e63c2e) IRQL_NOT_LESS_OR_EQUAL. NOTE: Fourth parameter may be different depending on your computers configuration. TCP is sending 1 byte more than AFD is sending.','Refer to Article ID Q225212 in the Microsoft Knowledge Database for the resolution to this problem.','1999-08-27 11:33:00')

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 8, 'When you use Windows NT to access a file with an extremely long file name that is nested in a long path, the following blue screen STOP error message may occur: STOP 0x00000050 (0xff737000 0x00000001 0x00000001 0x00000000) Note: The first parameter will vary, but the last three should always be the same.','Refer to Article ID Q163620 in the Microsoft Knowledge Database for the resolution to this problem.','1999-02-06 13:21:00')

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 9, 'When Windows NT exits an application, a blue screen is generated with the STOP code 0x1E in Win32k.sys with the following parameters: STOP 0x0000001E (0xC0000005, 0x80118bf4, 0x00000000, 0x00000074). 
NOTE: On single processor systems, the parameters in parenthesis will exactly match those shown above.','Refer to Article ID Q159095 in the Microsoft Knowledge Database for the resolution to this problem.','1999-01-30 13:00:00')

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 10, 'After you log on to a computer running Windows NT Server or Workstation and  immediately shut down the system, you may receive a STOP 50 in Srv.sys. The parameters may look like the following: STOP 0x00000050 (0xf08c5f51, 0x00000000, 0x00000000, 0x00000000). First parameter will always be same value but value depends on where it is loaded.','Refer to Article ID Q167362 in the Microsoft Knowledge Database for the resolution to this problem.','1999-02-18 14:24:00') 

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 11, 'When you run Windows NT on a multiprocessor computer under heavy stress, you may receive the following STOP message: 
STOP 0x0000000A (0x00000000, 0x00000002, 0x00000000, 0x80150810) The exact address where the STOP occurs may vary, but it is always in the hardware abstraction layer (HAL.)','Refer to Article ID Q165816 in the Microsoft Knowledge Database for the resolution to this problem.','1999-02-13 10:23:00')

INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 12, 'Running on multiprocessor computers that start and close GUIs frequently may cause either of the following blue screen error messages to be displayed: STOP 0x0000001e (0xc0000005, 0xa00f7538, 0x00000000, 0x00000008) KMODE EXCEPTION_NOT HANDLED -or- STOP 0x0000000a(0x00000004, 0x0000001c, 0x00000000, 0x801175db) IRQL NOT LESS OR EQUAL.','Refer to Article ID Q175687 in the Microsoft Knowledge Database for the resolution to this problem.','1999-08-27 11:21:00')

SET IDENTITY_INSERT Solution OFF
GO

PRINT ( 'Done Populating The Solution Table ...')

PRINT ( 'Populating The HintData Table' )

SET IDENTITY_INSERT HintData ON

INSERT INTO HintData(DataID,SolutionID,Data)
VALUES ( 1,2,'KernelModuleData.BaseName=ntoskrnl.exe')

SET IDENTITY_INSERT HintData OFF
GO

PRINT ( 'Done Populating The HintData Table ...')

PRINT ( 'Populating The Analysis Table' )

SET IDENTITY_INSERT Analysis ON

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 2, 'Win32k.sys generates Stop 1E when the process ID (PID) of any given process exceeds 65,535 bytes.','When the process ID (PID) of any given process exceeds 65,535 bytes, Win32k.sys generates the following blue screen error message: 

   STOP 0x0000001e {0xc000005, 0xa1000aa7, 0x00000000, 0x00440194}

NOTE: The first parameter will always be 0xc0000005 and the second parameter will always fall within the memory range of Win32k.sys.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 3, 'Netbt.sys generates Stop 0A when a multiprocessor computer  configured with a LMHOSTS file  was parsing it in an attempt to resolve a NetBIOS name.','The following Blue Screen may occur intermittently on a multiprocessor computer. 

STOP 0x0000000A (0x00000014, 0x00000002, 0x00000000, 0xf5a178ce)
IRQL_NOT_LESS_OR_EQUAL
Address f5a178ce has base at f5a10000 - NETBT.SYS 

NOTE: The first and second parameter will always be identical to the above mentioned. The fourth parameter can be different. The Stop message reports the failure in Netbt.sys.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 4, 'Srv.sys generates Stop 1E when using downlevel (LAN Man 1.0 or earlier) clients on the network.','A computer running Windows NT 4.0 Server can display a blue screen error message when using downlevel (LAN Man 1.0 or earlier) clients on the network. 

Stop 0X0000001E (0xC0000005, 0xfcb6e8f7, 0x00000000, 0x0000004C)
KMODE_EXCEPTION_NOT_HANDLED*** Address fcb6e8f7 has base at fcb5d000 - SRV.SYS 
NOTE: The second parameter in parenthesis will depend on your system configuration and may be different but will fall in range with Srv.sys.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 5, 'When performing name resolution operations in some environments, Windows NT computers dereference a tracking object twice causing a Stop 0A in Netbt.sys','A computer running Windows NT may stop with a blue screen Stop 0xA error in Netbt.sys when it attempts to resolve a name in the DNS namespace.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 6, 'Ndiwan.sys generates a Stop 0A after installing Service Pack 3 on a Windows NT 4.0 RAS server using the Digiboard ISDN RAS board.','After you install Service Pack 3 on a Windows NT 4.0 RAS server using the Digiboard ISDN RAS board, the server will display a blue screen error message with the following STOP code: 

STOP 0x0000000A (0x0000048, 0x00000000, 0x000000002, 0xf8d54f88)
IRQL_NOT_LESS_OR_EQUAL: 0xf8d54f88 has base at 0xf8d50000
NDISWAN.SYS. 

NOTE: The first parameter will be the same each time.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 7, 'Tcpip.sys may cause system to hang and generate a Stop 0A.  This problem occurs because TCP is sending 1 byte more than AFD is sending, which causes the error message to be displayed.','A computer running Windows NT 4.0 Service Pack 4 may stop responding (hang) and display the following STOP error message on a blue screen: 

STOP 0x0000000a (0x00000006, 0x00000002, 0x00000000, 0xf1e63c2e) IRQL_NOT_LESS_OR_EQUAL 

NOTE: The fourth parameter may be different depending on your computers configuration.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 8, 'Rdr.sys generates a Stop 50 because  it does not check the path name before sending a Query_Information server message block (SMB).','When you use Windows NT to access a file with an extremely long file name that is nested in a long path, 
the Redirector (Rdr.sys) does not check the path name before sending a Query_Information server message block (SMB). The following blue screen STOP error message may occur: 

STOP 0x00000050 (0xff737000 0x00000001 0x00000001 0x00000000) 
Note: The first parameter will vary, but the last three should always be the same.	','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 9, 'When Windows NT exits an application, a blue screen is generated with the STOP code 0x1E in Win32k.sys.  Setting API function CallWndProc from the context of a service can cause the blue screen when applications are closed.','When Windows NT exits an application, a blue screen with the following STOP code and parameters is generated: 

STOP 0x0000001E (0xC0000005, 0x80118bf4, 0x00000000, 0x00000074). 
NOTE: On single processor systems, the parameters in parenthesis will exactly match those shown above.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 10, 'Srv.sys can cause STOP: 0x00000050 after you log on to a computer running Windows NT Server or Workstation and then immediately shut down the system.','After you log on to a computer running Windows NT Server or Workstation and then immediately shutting down the system, you may receive a STOP: 0x00000050 in Srv.sys. The parameters may look like the following: 

STOP 0x00000050 (0xf08c5f51, 0x00000000, 0x00000000, 0x00000000). 
NOTE: The first parameter will always have the same value, but that value depends on where Srv.sys loads on the system.

A shutdown handler was registered by Srv.sys, which runs after srv.sys has already been unloaded from the system. Because Srv.sys has been unloaded, you will see a STOP 0x50. This may generally happen on multiprocessor computers with more than two network adapters installed in the system.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 11, 'Hal.sys can generate a Stop 0A when running Windows NT on a Multiprocessor system under heavy stress.','When you run Windows NT on a multiprocessor computer under heavy stress, you may receive the following STOP message: 

STOP 0x0000000A (0x00000000, 0x00000002, 0x00000000, 0x80150810) 
The exact address where the STOP occurs may vary, but it is always in the hardware abstraction layer (HAL.) 

This STOP is caused by a timing problem in the kernel that occurs when two processes are executing that are operating on the same memory structures, such as multiple disk reads or writes. Due to a compiler optimization that caused two operations to be executed in the wrong order, one of the processes attempts to use a pointer it thinks has been initialized correctly, when in fact it has not. 

This error can only occur on a multiprocessor computer and has been observed most frequently on NCR multiprocessor systems, however it could occur on any multiprocessor computer.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 12, 'Stop 0A  is generated by Win32k.sys on multiprocessor computers that start and close GUIs frequently.',
'Programs runing on multiprocessor computers that start and close GUIs frequently may cause the following STOP blue screen error message to be displayed: 

STOP 0x0000000a(0x00000004, 0x0000001c, 0x00000000, 0x801175db)
IRQL_NOT_LESS_OR_EQUAL 

On some multiprocessor computers, programs with multiple threads that use the CreateProcess() or CreateProcessAsUser() API calls to start processes do not start because of desktop heap leaks. This inability to start results in a User32.dll or Kernel32.dll file initialization error when the desktop heap is exhausted.

This problem occurs because the thread object reference count brakes. The thread object reference count brakes because of a threadlockobject instruction within Win32k.sys that was not multiprocessor safe. This causes programs to quit abnormally. Because of the abnormal way in which the program quits, the desktop heap leaked until new processes could not be started. In some other instances, when a program quits abnormally, a blue screen error mess  age may be displayed.','CNFRMSOL')

INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 13, 'Stop 1E  is generated by Win32k.sys on multiprocessor computers that start and close GUIs frequently.','Programs runing on multiprocessor computers that start and close GUIs frequently may cause the following STOP blue screen error message to be displayed: 

STOP 0x0000001e (0xc0000005, 0xa00f7538, 0x00000000, 0x00000008)
KMODE_EXCEPTION_NOT_HANDLED  

On some multiprocessor computers, programs with multiple threads that use the CreateProcess() or CreateProcessAsUser() API calls to start processes do not start because of desktop heap leaks. This inability to start results in a User32.dll or Kernel32.dll file initialization error when the desktop heap is exhausted.

This problem occurs because the thread object reference count brakes. The thread object reference count brakes because of a threadlockobject instruction within Win32k.sys that was not multiprocessor safe. This causes programs to quit abnormally. Because of the abnormal way in which the program quits, the desktop heap leaked until new processes could not be started. In some other instances, when a program quits abnormally, a blue screen err  or message may be displayed.','CNFRMSOL')

SET IDENTITY_INSERT Analysis OFF
GO

PRINT ( 'Done Populating The Analysis Table ...' )

PRINT ('Populating The Progress Text Table' )

SET IDENTITY_INSERT ProgressText ON

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 2,1,'1999-08-31 22:17:00','Initial Anlysis','Analyst 1')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 2,2,'1999-09-06 22:25:00','Progress Update','Analyst 2')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 3,3,'1999-08-26 06:46:00','Initial Analysis','Analyst 5')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES (4,4,'1999-08-27 22:43:00','Initial Analysis','Analyst 1')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 5,5,'1999-08-28 12:56:00','Initial Analysis','Analyst 3')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 6,6,'1999-08-27 22:45:00','Initial Analysis','Analyst 4')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 7,7,'1999-09-01 08:52:00','Initial Analysis','Analyst 2')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 8,8,'1999-08-23 10:01:00','Initial Analysis','Analyst 5')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES (9,9,'1999-02-21 10:42:00','Initial Analysis','Analyst 3')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 10,10,'1999-03-16 02:31:00','Initial Analysis','Analyst 1')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 11,11,'1999-08-25 02:35:00','Initial Analysis','Analyst 4')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 12,12,'1999-08-24 14:36:00','Initial Analysis','Analyst 2')

INSERT INTO ProgressText (AnalysisID,ProgressTextID,DateTime,Annotation,Author)
VALUES ( 13,13,'1999-08-23 13:15:00','Initial Analysis','Analyst 5')

SET IDENTITY_INSERT ProgressText OFF
GO

PRINT ('Done Populating The Progress Text Table ...')

PRINT ('Populating the Crash Class Table...')

SET IDENTITY_INSERT CrashClass ON

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (1,2,2,'0000001E','c0000005','Win32k.sys','00000000','00440194',1381,'x86',1,'Win32k.sys',1,'1999-08-31 21:36:00','1999-08-31 21:36:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (2,3,3,'0000000A','00000014','00000002','00000000','Netbt.sys!000078ce',1381,'x86',1,'Netbt.sys',1,'1999-08-26 06:24:00','1999-08-26 06:24:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (3,4,4,'0000001E','c0000005','Srv.sys!118f7','00000000','0000004c',1381,'x86',1,'Srv.sys',1,'1999-08-27 22:13:00','1999-08-27 22:13:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (4,5,5,'0000000A','0000003c','00000002','00000000','Netbt.sys',1381,'x86',1,'Netbt.sys',1,'1999-08-28 12:35:00','1999-08-28 12:35:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (5,6,6,'0000000A','00000048','00000000','00000002','Ndiswan.sys!00004f88',1381,'x86',1,'Ndiswan.sys',1,'1999-08-27 10:33:00','1999-08-27 10:33:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (6,7,7,'0000000A','00000006','00000002','00000000','Tcpip.sys',1381,'x86',1,'Tcpip.sys',1,'1999-09-01 08:22:00','1999-09-01 08:22:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (7,8,8,'00000050','Rdr.sys','00000001','00000001','00000000',1381,'x86 ',1,'Rdr.sys',1,'1999-08-23 09:23:00','1999-08-23 09:23:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (8,9,9,'0000001E','00000005','Win32k.sys','00000000','00000074',1381,'x86',1,'Win32k.sys',1,'1999-02-21 07:31:00','1999-02-21 07:31:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (9,10,10,'00000050','Srv.sys','00000000','00000000','00000000',1381,'x86',1,'Srv.sys',1,'1999-03-16 01:06:00','1999-03-16 01:06:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (10,11,11,'0000000A','00000000','00000002','00000000','Hal.sys',1381,'x86',1,'Hal.sys',1,'1999-08-25 01:43:00','1999-08-25 01:43:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (11,12,12,'0000000A','00000004','0000001c','00000000','Win32k.sys',1381,'x86',1,'Win32k.sys',1,'1999-08-24 13:14:00','1999-08-24 13:14:00')

INSERT INTO CrashClass (ClassID, SolutionID,AnalysisID,StopCode,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,NTBuild,Platform,Canonical,KeyWord1,InstanceCount,FirstOccurrence,LastOccurrence)
VALUES (12,12,13,'0000001E','00000005','Win32k.sys','00000000','00000008',1381,'x86',1,'Win32k.sys',1,'1999-08-23 12:21:00','1999-08-23 12:21:00')

SET IDENTITY_INSERT CrashClass OFF
GO

PRINT ('Done Populating the Crash Class table...')

PRINT ( 'Populating the HWProfile Table' )

SET IDENTITY_INSERT HWProfile ON

INSERT INTO HWProfile (HWProfileRecID, Architecture,ProcessorType,ProcessorSpec,ProcessorVendor,ProcessorCount,OccurrenceCount)
VALUES ( 1, 'x86','PII','00030001','GenuineIntel',1,5)

INSERT INTO HWProfile (HWProfileRecID, Architecture,ProcessorType,ProcessorSpec,ProcessorVendor,ProcessorCount,OccurrenceCount)
VALUES ( 2, 'x86','PII','00030002','GenuineIntel',2,5)

INSERT INTO HWProfile (HWProfileRecID, Architecture,ProcessorType,ProcessorSpec,ProcessorVendor,ProcessorCount,OccurrenceCount)
VALUES ( 3, 'x86','PII','00030003','GenuineIntel',1,2)

SET IDENTITY_INSERT HWProfile OFF
GO

PRINT ( 'Done Populating The HWProfile Table ...' )

PRINT ( 'Populating The OSProfile Table' )

SET IDENTITY_INSERT OSProfile ON

INSERT INTO OSProfile (OSProfileRecID,OSCheckedBuild,OSSMPKernel,OSPAEKernel,OSBuild,OSServicePackLevel,ProductType,OccurrenceCount)
VALUES ( 1, 0,0,0,1381,4,'unknown',3)

INSERT INTO OSProfile (OSProfileRecID,OSCheckedBuild,OSSMPKernel,OSPAEKernel,OSBuild,OSServicePackLevel,ProductType,OccurrenceCount)
VALUES ( 2, 0,0,0,1381,3,'unknown',6)

INSERT INTO OSProfile (OSProfileRecID,OSCheckedBuild,OSSMPKernel,OSPAEKernel,OSBuild,OSServicePackLevel,ProductType,OccurrenceCount)
VALUES ( 3, 0,0,0,1381,2,'unknown',3)

SET IDENTITY_INSERT OSProfile OFF
GO

PRINT ('Done Populating The OS Profile Table ...')

PRINT ('Populating the Crash Instance Table')

SET IDENTITY_INSERT CrashInstance ON

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (1,1,1,1,'00000000c0000005','00000000a1000aa7','0000000000000000','0000000000440194',3,1,'1999-08-31 21:35:56.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (2,2,2,2,'0000000000000014','0000000000000002','0000000000000000','00000000f5a178ce',3,1,'1999-08-26 06:23:45.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (3,3,1,2,'00000000c0000005','00000000fcb6e8f7','0000000000000000','000000000000004c',3,1,'1999-08-27 22:12:34.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (4,4,1,1,'000000000000003c','0000000000000002','0000000000000000','00000000f2152260',3,1,'1999-08-28 12:35:01.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (5,5,3,2,'0000000000000048','0000000000000000','0000000000000002','00000000f8d54f88',3,1,'1999-08-27 10:32:39.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (6,6,1,1,'0000000000000006','0000000000000002','0000000000000000','00000000f1e63c2e',3,1,'1999-09-01 08:21:45.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (7,7,3,2,'00000000ff737000','0000000000000001','0000000000000001','0000000000000000',3,1,'1999-08-23 09:22:45.000')
INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (8,8,1,3,'00000000c0000005','0000000080118bf4','0000000000000000','0000000000000074',3,1,'1999-02-21 07:31:05.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (9,9,2,3,'00000000f08c5f51','0000000000000000','0000000000000000','0000000000000000',3,1,'1999-03-16 01:05:45.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (10,10,2,3,'0000000000000000','0000000000000002','0000000000000000','0000000080150810',	3,1,'1999-08-25 01:43:00.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (11,11,2,2,'0000000000000004','000000000000001c','0000000000000000','00000000801175db',3,1,'1999-08-24 13:14:21.000')

INSERT INTO CrashInstance (ClassID, InstanceID,HWProfileRecID,OSProfileRecID,StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,CrashTimeDate)
VALUES (12,12,2,2,'0000000000000005','00000000a00f7538','0000000000000000','0000000000000008',3,1,'1999-08-23 12:21:02.000')

SET IDENTITY_INSERT CrashInstance OFF
GO

PRINT ('Done Populating the Crash Instance Table...')

PRINT ( 'Populating The Kernel Module Data Table' ) 

SET IDENTITY_INSERT KernelModuleData ON

INSERT INTO KernelModuleData (KernelModuleID,BaseName,Size,CheckSum,DateTime,SubSystemMajorVersion,SubSystemMinorVersion)
VALUES (1,'ntoskrnl.exe',1544,'c10008f3','1998-06-27 02:11:44.000',4,3)

INSERT INTO KernelModuleData (KernelModuleID,BaseName,Size,CheckSum,DateTime,SubSystemMajorVersion,SubSystemMinorVersion)
VALUES (2,'netbt.sys',132,'00d7f021','1998-06-23 02:22:15.000',4,3)

INSERT INTO KernelModuleData (KernelModuleID,BaseName,Size,CheckSum,DateTime,SubSystemMajorVersion,SubSystemMinorVersion)
VALUES (3,'srv.sys',232,'00d7f021','1998-06-18 01:21:09.000',4,3)

INSERT INTO KernelModuleData (KernelModuleID,BaseName,Size,CheckSum,DateTime,SubSystemMajorVersion,SubSystemMinorVersion)
VALUES (4,'ndiswan.sys',143,'011fd326','1998-06-23 03:24:40.000',4,3)

INSERT INTO KernelModuleData (KernelModuleID,BaseName,Size,CheckSum,DateTime,SubSystemMajorVersion,SubSystemMinorVersion)
VALUES (5,'tcpip.sys',279,'0018c8a8','1998-06-03 03:23:24.000',4,3)

INSERT INTO KernelModuleData (KernelModuleID,BaseName,Size,CheckSum,DateTime,SubSystemMajorVersion,SubSystemMinorVersion)
VALUES (6,'rdr.sys',142,'002e3cf7','1998-06-25 00:50:23.000',4,3)

INSERT INTO KernelModuleData (KernelModuleID,BaseName,Size,CheckSum,DateTime,SubSystemMajorVersion,SubSystemMinorVersion)
VALUES (7,'win32k.sys',1673,'a102c43', '1998-03-27 02:14:41.000',4,2)

INSERT INTO KernelModuleData (KernelModuleID,BaseName,Size,CheckSum,DateTime,SubSystemMajorVersion,SubSystemMinorVersion)
VALUES (8,'win32k.sys',1694,'a102c65', '1998-06-24 13:21:57.000',4,3)

INSERT INTO KernelModuleData (KernelModuleID,BaseName,Size,CheckSum,DateTime,SubSystemMajorVersion,SubSystemMinorVersion)
VALUES (9,'hal.sys',89,'000c3e40','1998-03-23 09:46:27.000',4,2)

SET IDENTITY_INSERT KernelModuleData OFF
GO

PRINT ( 'Done Populating The Kernel Module Data Table ...' )

PRINT ( 'Populating The Kernel Module Table' )

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (1,1,8,'0000000080400000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (2,2,2,'00000000bfd53000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (3,3,3,'00000000bf1b5000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (4,4,2,'00000000bfd53000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (5,5,4,'00000000bfe9a000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (6,6,5,'00000000bfd76000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (7,7,6,'00000000bfd2f000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (8,8,7,'00000000a0000000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (9,9,3,'00000000bf1b5000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (10,10,9,'0000000080062000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (11,11,8,'0000000080400000')

INSERT INTO KernelModule (ClassID, InstanceID,KernelModuleID,LoadAddress)
VALUES (12,12,8,'0000000080400000')
GO

PRINT ( 'Done Populating the Kernel Module Table ...' )

PRINT ( 'Populating The kanayze Moudle Data Table' )

SET IDENTITY_INSERT KanalyzeModuleData ON

INSERT INTO KanalyzeModuleData (KanalyzeModuleID,BaseName,Type,AlternateName,MajorVersion,MinorVersion,Description)
VALUES (1,'memory.dll','analysis','memory plugin',3,1,'Process kernel mode memory layout and root containers')

INSERT INTO KanalyzeModuleData (KanalyzeModuleID,BaseName,Type,AlternateName,MajorVersion,MinorVersion,Description)
VALUES (2,'module.dll','analysis','module plugin',3,1,'Process kernel mode module data')

INSERT INTO KanalyzeModuleData (KanalyzeModuleID,BaseName,Type,AlternateName,MajorVersion,MinorVersion,Description)
VALUES (3,'eobject.dll','analysis','eobject plugin',3,1,'Process executive object data')

INSERT INTO KanalyzeModuleData (KanalyzeModuleID,BaseName,Type,AlternateName,MajorVersion,MinorVersion,Description)
VALUES (4,'kaio.dll','analysis','io plugin',3,1,'Process I/O system data')

INSERT INTO KanalyzeModuleData (KanalyzeModuleID,BaseName,Type,AlternateName,MajorVersion,MinorVersion,Description)
VALUES (5,'kobject.dll','analysis','kobject plugin',3,1,'Process kernel objects and related structures')

INSERT INTO KanalyzeModuleData (KanalyzeModuleID,BaseName,Type,AlternateName,MajorVersion,MinorVersion,Description)
VALUES (6,'objtbl.dll','analysis','objtbl plugin',3,1,'Process object table data')

INSERT INTO KanalyzeModuleData (KanalyzeModuleID,BaseName,Type,AlternateName,MajorVersion,MinorVersion,Description)
VALUES (7,'pool.dll','analysis','pool plugin',3,1,'Process pool memory data')

INSERT INTO KanalyzeModuleData (KanalyzeModuleID,BaseName,Type,AlternateName,MajorVersion,MinorVersion,Description)
VALUES (8,'engine.exe','engine','kanalyze engine',3,1,'Core kanalyze executable')

INSERT INTO KanalyzeModuleData (KanalyzeModuleID,BaseName,Type,AlternateName,MajorVersion,MinorVersion,Description)
VALUES (9,'strace.dll','analysis','strace plugin',3,1,'Process stack trace')

SET IDENTITY_INSERT KanalyzeModuleData OFF

PRINT ( 'Done Populating the Kanalyze Module Data Table...' )

PRINT ( 'Populating the Kanalyze Module Table' )

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 1,1,2)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 2,2,3)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 3,3,1)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 4,4,5)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 5,5,4)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 6,6,5)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 7,7,9)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 8,8,7)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 9,9,6)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 10,10,1)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES ( 11,11,3)

INSERT INTO KanalyzeModule (ClassID, InstanceID,KanalyzeModuleID)
VALUES (12,12,3)
GO

PRINT ('Done Populating the Kanalyze Moudle Table ...')

PRINT ('Populating the AttachmentData Table...')

SET IDENTITY_INSERT AttachmentData ON

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 1,1,1,'//kktools3',54,'Test Data1','1999-08-31 21:54:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 2,2,2,'//kktools3',121,'Test Data2','1999-08-26 06:46:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 3,3,3,'//kktools3',220,'Test Data3','1999-08-27 22:30:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 4,4,4,'//kktools3',128,'Test Data4','1999-08-28 12:46:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 5,5,5,'//kktools3',228,'Test Data5','1999-08-27 10:45:0')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 6,6,6,'//kktools3',128,'Test Data6','1999-09-01 08:41:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 7,7,7,'//kktools3',198,'Test Data7','1999-08-23 09:31:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 8,8,8,'//kktools3',156,'Test Data8','1999-02-21 10:52:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 9,9,9,'//kktools3',228,'Test Data9','1999-03-16 02:34:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 10,10,10,'//kktools3',127,'Test Data10','1999-08-25 02:45:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 11,11,11,'//kktools3',221,'Test Data11','1999-08-24 14:16:00')

INSERT INTO AttachmentData (ClassID,InstanceID,ItemID,Location,Size,Description,DateTime)
VALUES ( 12,12,12,'//kktools3',128,'Test Data12','1999-08-23 13:11:00')

SET IDENTITY_INSERT AttachmentData OFF
GO

PRINT ('DONE Populating the AttachmentData table...')

PRINT ('Populating The Associate DB Table' )

SET IDENTITY_INSERT AssociateDB ON

INSERT INTO AssociateDB (DatabaseID,DatabaseName,Parent,ConnectionData1,ConnectionData2)
VALUES ( 1,'KaKnownIssue',0,'v-akinag05 KaKnownIssue_MS sa pw sqloledb','v-akinag06 KaKnownIssue_CPQ sa pw msdasql' )

SET IDENTITY_INSERT AssociateDB OFF
GO

PRINT ( 'Done Populating The Associate DB Table ...' )

PRINT ( 'Populating The External Record Locator Table' )

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 1,1,'US West','USW-083199-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 2,2,'Fujitsu','FUJI-082699-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 3,3,'MCI','MCI-082799-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 4,4,'Compaq','CPQ-082899-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 5,5,'CityBank','CITB-082799-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 6,6,'Toshiba','TOSH-090199-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 7,7,'Hitachi','HITA-082399-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 8,8,'NTT Data','NTTD-022199-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 9,9,'NEC','NEC-031699-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES (10,10,'Boeing','BA-082599-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 11,11,'US West','USW-082499-1')

INSERT INTO ExternalRecordLocator(ClassID,InstanceID,Customer,ServiceRec)
VALUES ( 12,12,'MCI','MCI-082399-11')
GO

SET NOCOUNT OFF

PRINT ( 'Done Populating The Extermal Record Locator Table...' )

PRINT ( 'Done Populating Tables With Test Data...' )