/*++
Copyright (c) 1999 Microsoft Corporation

Module Name:

    KaDropDBTables.sql

Abstract:

    This script is used to drop tables from the 
    Kalayze's Known Issue Database. 

Author:

   Peter Hiross (v-peteh) & Dick Tanabe ( v-dickta ) September 20, 1999


Revision History:

    Dick Tanabe (v-dickta)          Nov 11, 1999   Added two new tables: ProcessorType and ProcessorVendor
--*/

Use KaKnownIssue
Go

PRINT ('Executing "KaDropDBTables.sql" - Drops tables from the KaKnownIssue Database.')


IF OBJECT_ID('dbo.ExternalRecordLocator') IS NOT NULL
   DROP TABLE ExternalRecordLocator
Go

IF OBJECT_ID('dbo.AssociateDB') IS NOT NULL
   DROP TABLE AssociateDB
Go

IF OBJECT_ID('dbo.KernelModule') IS NOT NULL
   DROP TABLE KernelModule
Go

IF OBJECT_ID('dbo.KernelModuleData') IS NOT NULL
   DROP TABLE KernelModuleData
Go

IF OBJECT_ID('dbo.KanalyzeModule') IS NOT NULL
   DROP TABLE KanalyzeModule
Go

IF OBJECT_ID('dbo.KanalyzeModuleData') IS NOT NULL
   DROP TABLE KanalyzeModuleData
Go

IF OBJECT_ID('dbo.ProgressText') IS NOT NULL
   DROP TABLE ProgressText
Go

IF OBJECT_ID('dbo.VariableCrashData') IS NOT NULL
   DROP TABLE VariableCrashData
Go

IF OBJECT_ID('dbo.AttachmentData') IS NOT NULL
   DROP TABLE AttachmentData
Go

IF OBJECT_ID('dbo.CrashInstance') IS NOT NULL
   DROP TABLE CrashInstance
Go

IF OBJECT_ID('dbo.CrashClass') IS NOT NULL
   DROP TABLE CrashClass
Go

IF OBJECT_ID('dbo.HintData') IS NOT NULL
   DROP TABLE HintData
Go

IF OBJECT_ID('dbo.Solution') IS NOT NULL
   DROP TABLE Solution
Go

IF OBJECT_ID('dbo.OSProfile') IS NOT NULL
   DROP TABLE OSProfile
Go

IF OBJECT_ID('dbo.HWProfile') IS NOT NULL
   DROP TABLE HWProfile
Go

IF OBJECT_ID('dbo.Analysis') IS NOT NULL
   DROP TABLE Analysis
Go

IF OBJECT_ID('dbo.StopCodeDescription') IS NOT NULL
   DROP TABLE StopCodeDescription
Go

IF OBJECT_ID('dbo.History') IS NOT NULL
   DROP TABLE History
Go

IF OBJECT_ID('dbo.ProcessorType') IS NOT NULL
   DROP TABLE ProcessorType
Go

IF OBJECT_ID('dbo.ProcessorVendor') IS NOT NULL
   DROP TABLE ProcessorVendor
Go

PRINT ('Done Dropping Tables from the KaKnownIssue database.')