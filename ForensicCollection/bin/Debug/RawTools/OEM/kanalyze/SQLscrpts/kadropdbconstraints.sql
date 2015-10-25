/*++
Copyright (c) 1999 Microsoft Corporation

Module Name:

    KaDropDBConstraints.sql

Abstract:

    This script is used to drop stored procedures, indexes and constraints 
    from the Kanalyze Known Issue Database.
	

Author:

    Dick Tanabe ( v-dickta ) 	September 20, 1999

Revision History:

   Dick Tanabe (v-dickta)        Oct 25, 1999    Modified DROP INDEX to check for IF EXISTS
   Dick Tanabe (v-dickta)        Oct 25, 1999    Added DROP CONSTRAINT for ClassID Foreign Key
                                                                     in CrashInstance Table
   Dick Tanabe (v-dickta)        Nov 03, 1999   Added drop index BaseName from KernelModuleData Table
--*/

Use KaKnownIssue
Go

PRINT ('Dropping stored procedures, indexes and constraints from the KaKnownIssue Database.')

IF OBJECT_ID('dbo.spKaDisableHistoryLogging') IS NOT NULL
   DROP PROCEDURE  spKaDisableHistoryLogging
Go

IF OBJECT_ID('dbo.spKaDisableAllConstraints') IS NOT NULL
   DROP PROCEDURE  spKaDisableAllConstraints
Go

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeIX')
    DROP INDEX CrashClass.StopCodeIX
Go

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeParameter1IX')
   DROP INDEX CrashClass.StopCodeParameter1IX
Go

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeParameter2IX')
   DROP INDEX CrashClass.StopCodeParameter2IX
Go

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeParameter3IX')
   DROP INDEX CrashClass.StopCodeParameter3IX
Go

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeParameter4IX')
   DROP INDEX CrashClass.StopCodeParameter4IX
Go

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'BaseNameIX')
   DROP INDEX KernelModuleData.BaseNameIX
Go

IF OBJECT_ID('dbo.ProcessorTypeProcessorVendorFK') IS NOT NULL
   ALTER TABLE dbo.ProcessorType 
   DROP CONSTRAINT ProcessorTypeProcessorVendorFK

IF OBJECT_ID('dbo.CrashClassAnalysisFK') IS NOT NULL
   ALTER TABLE dbo.CrashClass 
   DROP CONSTRAINT CrashClassAnalysisFK
Go

IF OBJECT_ID('dbo.CrashClassSolutionFK') IS NOT NULL
   ALTER TABLE dbo.CrashClass 
   DROP CONSTRAINT CrashClassSolutionFK
Go

IF OBJECT_ID('dbo.CrashInstanceCrashClassFK') IS NOT NULL
   ALTER TABLE dbo.CrashInstance
   DROP CONSTRAINT CrashInstanceCrashClassFK
Go

IF OBJECT_ID('dbo.CrashInstanceHWProfileFK') IS NOT NULL
   ALTER TABLE dbo.CrashInstance
   DROP CONSTRAINT CrashInstanceHWProfileFK
Go

IF OBJECT_ID('dbo.CrashInstanceOSProfileFK') IS NOT NULL
   ALTER TABLE dbo.CrashInstance
   DROP CONSTRAINT CrashInstanceOSProfileFK
Go

IF OBJECT_ID('dbo.KernelModuleKernelModuleDataFK') IS NOT NULL
   ALTER TABLE dbo.KernelModule
   DROP CONSTRAINT KernelModuleKernelModuleDataFK
Go

IF OBJECT_ID('dbo.KernelModuleCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.KernelModule
   DROP CONSTRAINT KernelModuleCrashInstanceFK
Go

IF OBJECT_ID('dbo.KanalyzeModuleCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.KanalyzeModule
   DROP CONSTRAINT  KanalyzeModuleCrashInstanceFK
Go

IF OBJECT_ID('dbo.KanalyzeModuleKanalyzeModuleDataFK') IS NOT NULL
   ALTER TABLE dbo.KanalyzeModule
   DROP CONSTRAINT KanalyzeModuleKanalyzeModuleDataFK 
Go

IF OBJECT_ID('dbo.ProgressTextAnalysisFK') IS NOT NULL
   ALTER TABLE dbo.ProgressText
   DROP CONSTRAINT  ProgressTextAnalysisFK
Go

IF OBJECT_ID('dbo.VariableCrashDataCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.VariableCrashData
   DROP CONSTRAINT VariableCrashDataCrashInstanceFK 
Go

IF OBJECT_ID('dbo.ExternalRecordLocatorCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.ExternalRecordLocator
   DROP CONSTRAINT ExternalRecordLocatorCrashInstanceFK 
Go

IF OBJECT_ID('dbo.AttachmentDataCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.AttachmentData
   DROP CONSTRAINT AttachmentDataCrashInstanceFK 
Go

IF OBJECT_ID('dbo.HintDataSolutionFK') IS NOT NULL
   ALTER TABLE dbo.HintData
   DROP CONSTRAINT  HintDataSolutionFK
Go

PRINT ('Done dropping Indexes and Constraints...')
