/*++
Copyright (c) 1999 Microsoft Corporation

Module Name:

    KaPopDBObject.sql

Abstract:

    This script is used to create Kanalyze's Known Issues Database objects 
    and populates the database with static data items.
	

Author:

    Peter Hiross ( v-peteh ) 	Aug 17, 1999

Revision History:

    Dick Tanabe (v-dickta)        Sep 28, 1999  Revised script to drop triggers, create stored
                                                                     procedures, and populate static tables.
    Dick Tanabe (v-dickta)        Oct 25, 1999   Modified DROP INDEX to check for IF EXISTS
    Dick Tanabe (v-dickta)        Oct 25, 1999   Added ClassID as Foreign Key in CrashInstance Table
    Dick Tanabe (v-dickta)        Oct 25, 1999   Added DROP CONSTRAINT for ClassID Foreign Key
                                                                     in CrashInstance Table
    Dick Tanabe (v-dickta)        Oct 29, 1999   Support NULLable fields for mini dump functionality
    Dick Tanabe (v-dickta)        Nov 03, 1999   Add index BaseName to KernelModuleData Table
    Peter Hiross(v-peteh)         Nov 11, 1999   Added two new tables: ProcessorType and ProcessorVendor
                                                 populated these tables. Also changed CrashClass:Cannonical 
                                                 to an int (was bit)
    Dick Tanabe (v-dickta)        Dec 03, 1999  Revised script for case sensitivity, Raid Bug 585

--*/

PRINT ('Executing "KaPopDBObject.sql" - Populates the Known Issue Database.')
PRINT ('')
USE master
declare @errmsg varchar(256)
IF DB_ID('KaKnownIssue') IS NULL
BEGIN
   set @errmsg = 'Error. Known Issue Database does not exit and must be created first.
                  Execute the script "KaCreateDB.sql".'
   raiserror(@errmsg,16,1)
   RETURN
   -- Bugbug. We need a way to exit the script here. The problem arrises when 
   -- the script is interleaved with 'go' statements. can't use goto 'ErrorOut'
END
Go

Use KaKnownIssue
Go

PRINT('Dropping Constraints and Indexes from the KaKnownIssue Database...')

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeIX')
    DROP INDEX CrashClass.StopCodeIX
GO

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

PRINT ('Dropping tables from the KaKnownIssue Database.')

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


PRINT ('Dropping Triggers from the KaKnownIssue database.')

IF OBJECT_ID('dbo.tr_TrackAssociateDBUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackAssociateDBUpdates
Go

IF OBJECT_ID('dbo.tr_TrackAnalysisUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackAnalysisUpdates
Go

IF OBJECT_ID('dbo.tr_TrackSolutionUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackSolutionUpdates
Go

IF OBJECT_ID('dbo.tr_TrackCrashClassUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackCrashClassUpdates
Go

IF OBJECT_ID('dbo.tr_TrackCrashInstanceUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackCrashInstanceUpdates
Go

IF OBJECT_ID('dbo.tr_TrackKernelModuleDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKernelModuleDataUpdates
Go

IF OBJECT_ID('dbo.tr_TrackKernelModuleUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKernelModuleUpdates
Go

IF OBJECT_ID('dbo.tr_TrackKanalyzeModuleDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKanalyzeModuleDataUpdates
Go

IF OBJECT_ID('dbo.tr_TrackKanalyzeModuleUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKanalyzeModuleUpdates
Go

IF OBJECT_ID('dbo.tr_TrackExternalRecordLocatorUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackExternalRecordLocatorUpdates
Go

IF OBJECT_ID('dbo.tr_TrackProgressTextUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackProgressTextUpdates
Go

IF OBJECT_ID('dbo.tr_TrackVariableCrashDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackVariableCrashDataUpdates
Go

IF OBJECT_ID('dbo.tr_TrackAttachmentDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackAttachmentDataUpdates
Go

IF OBJECT_ID('dbo.tr_TrackHintDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackHintDataUpdates
Go

IF OBJECT_ID('dbo.tr_TrackOSProfileUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackOSProfileUpdates
Go

IF OBJECT_ID('dbo.tr_TrackHWProfileUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackHWProfileUpdates
Go

IF OBJECT_ID('dbo.tr_TrackStopCodeDescriptionUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackStopCodeDescriptionUpdates
Go

PRINT ('Done dropping Triggers from the KaKnownIssue database.')

PRINT ('Dropping Stored Procedures from the KaKnownIssue database.')

IF OBJECT_ID('dbo.spKaDisableHistoryLogging') IS NOT NULL
   DROP PROCEDURE  spKaDisableHistoryLogging
Go

IF OBJECT_ID('dbo.spKaDisableAllConstraints') IS NOT NULL
   DROP PROCEDURE  spKaDisableAllConstraints
Go

PRINT ('Done dropping Stored Procedures from the KaKnownIssue database.')

PRINT ('Creating the KaKnownIssue Database Tables.')

PRINT('     Creating Table: ProcessorVendor')
CREATE TABLE ProcessorVendor (
       VendorID             int IDENTITY(1,1) NOT NULL,
       VendorName           varchar(13) NOT NULL
)
Go

PRINT('     Creating Table: ProcessorVendor')
CREATE TABLE ProcessorType (
       ProcessorTypeID      int IDENTITY(1,1) NOT NULL,
       VendorID             int NOT NULL,
       Type                 char(8) NULL,
       Family               smallint NULL,
       Model                smallint NULL,
       Step                 smallint NULL
)
Go

PRINT('     Creating Table: AssociateDB')
CREATE TABLE AssociateDB (
       DatabaseID               int IDENTITY(1,1) NOT NULL,
       DatabaseName         nvarchar(128)      NOT NULL,
       Parent                      bit                        NULL,
       ConnectionData1      varchar(256)        NOT NULL,
       ConnectionData2      varchar(256)        NULL
)
Go

PRINT('     Creating Table: Analysis')
CREATE TABLE Analysis (
       AnalysisID                   int IDENTITY(1,1) NOT NULL,
       Abstract                      nvarchar(350)       NULL,
       ProblemDescription   nvarchar(3250)      NULL,
       Keywords                  nvarchar(400)        NULL,
       Status                        char(8)                   NULL
)
Go

PRINT('     Creating Table: Solution')
CREATE TABLE Solution (
       SolutionID                int IDENTITY(1,1) NOT NULL,
       Abstract                    nvarchar(350)      NOT NULL,
       SolutionDescription  nvarchar(3250)    NOT NULL,
       Keywords                 nvarchar(400)      NULL,
       LastUpdated             smalldatetime     NOT NULL
)
Go

PRINT('     Creating Table: CrashClass')
CREATE TABLE CrashClass (
       ClassID                       int IDENTITY(1,1) NOT NULL,
       SolutionID                    int                       NOT NULL,
       AnalysisID                    int                       NOT NULL,
       StopCode                     char(8)                NOT NULL,
       StopCodeParameter1   varchar(256)       NOT NULL,
       StopCodeParameter2   varchar(256)       NOT NULL,
       StopCodeParameter3   varchar(256)       NOT NULL,
       StopCodeParameter4   varchar(256)       NOT NULL,
       NTBuild                        smallint              NOT NULL,
       Platform                       char(10)              NOT NULL,
       Canonical                     int                      NULL,
       KeyWord1                    varchar(256)       NULL,
       KeyWord2                    varchar(256)       NULL,
       KeyWord3                    varchar(256)       NULL,
       KeyWord4                    varchar(256)       NULL,
       InstanceCount              int                      NULL,
       FirstOccurrence          smalldatetime     NULL,
       LastOccurrence          smalldatetime     NULL
)
Go

PRINT('     Creating Table: CrashInstance')
CREATE TABLE CrashInstance (
       ClassID                         int                       NOT NULL,
       InstanceID                    int IDENTITY(1,1) NOT NULL,
       HWProfileRecID           int                       NOT NULL,
       OSProfileRecID            int                       NOT NULL,
       StopCodeParameter1   varchar(16)         NOT NULL,
       StopCodeParameter2   varchar(16)         NOT NULL,
       StopCodeParameter3   varchar(16)         NOT NULL,
       StopCodeParameter4   varchar(16)         NOT NULL,
       KanalyzeMajorVersion  smallint             NOT NULL,
       KanalyzeMinorVersion  smallint             NOT NULL,
       CrashTimeDate             datetime            NULL
)
Go

PRINT('     Creating Table: KernelModuleData')
CREATE TABLE KernelModuleData (
       KernelModuleID             int IDENTITY(1,1) NOT NULL,
       BaseName                     nvarchar(256)  NOT NULL,
       Size                               int                   NOT NULL,
       CheckSum                     char(8)            NOT NULL,
       DateTime                       datetime         NULL,
       SubSystemMajorVersion smallint            NULL,
       SubSystemMinorVersion smallint            NULL
)
Go

PRINT('     Creating Table: KernelModule')
CREATE TABLE KernelModule (
       ClassID                     int              NOT NULL,
       InstanceID                int              NOT NULL,
       KernelModuleID       int              NOT NULL,
       LoadAddress            varchar(16) NOT NULL
)
Go

PRINT('     Creating Table: KanalyzeModuleData')
CREATE TABLE KanalyzeModuleData (
       KanalyzeModuleID     int IDENTITY(1,1) NOT NULL,
       BaseName                  nvarchar(256)     NOT NULL,
       Type                           char(8)                NOT NULL,
       AlternateName           nvarchar(50)       NOT NULL,
       MajorVersion              smallint              NOT NULL,
       MinorVersion              smallint              NOT NULL,
       Description                 nvarchar(256)     NULL
)
Go

PRINT('     Creating Table: KanlayzeModule')
CREATE TABLE KanalyzeModule (
       ClassID                      int NOT NULL,
       InstanceID                 int NOT NULL,
       KanalyzeModuleID    int NOT NULL
)
Go

PRINT('     Creating Table: ExternalRecordLocator')
CREATE TABLE ExternalRecordLocator (
       ClassID                int                  NOT NULL,
       InstanceID           int                  NOT NULL,
       Customer            nvarchar(100) NULL,
       ServiceRec         varchar(100)   NULL
) 
Go

PRINT('     Creating Table: ProgressText')
CREATE TABLE ProgressText (
       AnalysisID            int                       NOT NULL,
       ProgressTextID    int IDENTITY(1,1) NOT NULL,
       DateTime             smalldatetime    NOT NULL,
       Annotation           nvarchar(3800)   NOT NULL,
       Author                  nvarchar(75)      NULL
)
Go

PRINT('     Creating Table: VariableCrashData')
CREATE TABLE VariableCrashData (
       ClassID             int                   NOT NULL,
       InstanceID        int                   NOT NULL,
       BlobName        nvarchar(256)  NOT NULL,
       BlobWriterID    nvarchar(50)   NOT NULL,
       Data                 image             NOT NULL,
       DataLength      int                   NOT NULL
)
Go

PRINT('     Creating Table: AttachmentData')
CREATE TABLE AttachmentData (
       ClassID              int                       NOT NULL,
       InstanceID         int                       NOT NULL,
       ItemID               int IDENTITY(1,1) NOT NULL,
       Location           nvarchar(256)      NOT NULL,
       Size                  int                       NOT NULL,
       Description       nvarchar(256)      NULL,
       DateTime          smalldatetime    NOT NULL
)
Go

PRINT('     Creating Table: HintData')
CREATE TABLE HintData (
       DataID               int IDENTITY(1,1) NOT NULL,
       SolutionID         int                       NOT NULL,
       Data                  nvarchar(2500)    NOT NULL
)
Go

PRINT('     Creating Table: OSProfile')
CREATE TABLE OSProfile (
       OSProfileRecID           int IDENTITY(1,1) NOT NULL,
       OSCheckedBuild         bit                       NULL,
       OSSMPKernel             bit                       NULL,
       OSPAEKernel              bit                       NULL,
       OSBuild                       smallint              NOT NULL,
       OSServicePackLevel   smallint              NULL,
       ProductType                varchar(12)         NULL,
       QfeData                       nvarchar(256)     NULL,
       OccurrenceCount          int                      NOT NULL
)
Go

PRINT('     Creating Table: HWProfile')
CREATE TABLE HWProfile (
       HWProfileRecID     int IDENTITY(1,1) NOT NULL,
       Architecture            char(8)               NOT NULL,
       ProcessorType        char(8)               NOT NULL,
       ProcessorSpec        char(8)               NULL,
       ProcessorVendor    varchar(13)         NULL,
       ProcessorCount      smallint                 NOT NULL,
       OccurrenceCount     int                      NOT NULL
)
Go

PRINT('     Creating Table: StopCodeDescription')
CREATE TABLE StopCodeDescription (
       StopCode           char(8)       NOT NULL,
       Name                 varchar(80) NOT NULL
)
Go

PRINT('     Creating Table: History')
CREATE TABLE History (
       HistoryID                int IDENTITY(1,1) NOT NULL,
       DatabaseName      nvarchar(128)      NULL,
       UserName              nvarchar(50)        NOT NULL,
       TableName            nvarchar(60)        NOT NULL,
       Operation              nvarchar(20)        NOT NULL,
       TimeStamp           datetime              NOT NULL
)
Go

PRINT ('Done Creating the KaKnownIssue Database Tables...')

PRINT('Adding constraints and indexes to the KaKnownIssue Database....')

ALTER TABLE [dbo].[ProcessorType] WITH NOCHECK ADD 
	CONSTRAINT [ProcessorTypePK] PRIMARY KEY  CLUSTERED 
	(
		[ProcessorTypeID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ProcessorVendor] WITH NOCHECK ADD 
	CONSTRAINT [ProcessorVendorPK] PRIMARY KEY  CLUSTERED 
	(
		[VendorID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Analysis] WITH NOCHECK ADD 
	CONSTRAINT [AnalysisPK] PRIMARY KEY  CLUSTERED 
	(
		[AnalysisID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[AssociateDB] WITH NOCHECK ADD 
	CONSTRAINT [AssociateDBPK] PRIMARY KEY  CLUSTERED 
	(
		[DatabaseID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[AttachmentData] WITH NOCHECK ADD 
	CONSTRAINT [AttachmentDataPK] PRIMARY KEY  CLUSTERED 
	(
		[ClassID],
		[InstanceID],
		[ItemID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[CrashClass] WITH NOCHECK ADD 
	CONSTRAINT [CrashClassPK] PRIMARY KEY  CLUSTERED 
	(
		[ClassID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[CrashInstance] WITH NOCHECK ADD 
	CONSTRAINT [CrashInstancePK] PRIMARY KEY  CLUSTERED 
	(
		[ClassID],
		[InstanceID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[HintData] WITH NOCHECK ADD 
	CONSTRAINT [HintDataPK] PRIMARY KEY  CLUSTERED 
	(
		[DataID],
		[SolutionID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[History] WITH NOCHECK ADD 
	CONSTRAINT [HistoryPK] PRIMARY KEY  CLUSTERED 
	(
		[HistoryID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[HWProfile] WITH NOCHECK ADD 
	CONSTRAINT [HWProfilePK] PRIMARY KEY  CLUSTERED 
	(
		[HWProfileRecID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[KanalyzeModuleData] WITH NOCHECK ADD 
	CONSTRAINT [KanalyzeModuleDataPK] PRIMARY KEY  CLUSTERED 
	(
		[KanalyzeModuleID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[KernelModuleData] WITH NOCHECK ADD 
	CONSTRAINT [KernelModuleDataPK] PRIMARY KEY  CLUSTERED 
	(
		[KernelModuleID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[OSProfile] WITH NOCHECK ADD 
	CONSTRAINT [OSProfilePK] PRIMARY KEY  CLUSTERED 
	(
		[OSProfileRecID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ProgressText] WITH NOCHECK ADD 
	CONSTRAINT [ProgressTextPK] PRIMARY KEY  CLUSTERED 
	(
		[AnalysisID],
		[ProgressTextID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Solution] WITH NOCHECK ADD 
	CONSTRAINT [SolutionPK] PRIMARY KEY  CLUSTERED 
	(
		[SolutionID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[StopCodeDescription] WITH NOCHECK ADD 
	CONSTRAINT [StopCodeDescriptionPK] PRIMARY KEY  CLUSTERED 
	(
		[StopCode]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[VariableCrashData] WITH NOCHECK ADD 
	CONSTRAINT [VarialeCrashDataPK] PRIMARY KEY  CLUSTERED 
	(
		[ClassID],
		[InstanceID],
		[BlobName]
	)  ON [PRIMARY] 
GO

 CREATE  INDEX [StopCodeIX] ON [dbo].[CrashClass]([StopCode]) ON [PRIMARY]
GO

 CREATE  INDEX [StopCodeParameter1IX] ON [dbo].[CrashClass]([StopCodeParameter1]) ON [PRIMARY]
GO

 CREATE  INDEX [StopCodeParameter2IX] ON [dbo].[CrashClass]([StopCodeParameter2]) ON [PRIMARY]
GO

 CREATE  INDEX [StopCodeParameter3IX] ON [dbo].[CrashClass]([StopCodeParameter3]) ON [PRIMARY]
GO

 CREATE  INDEX [StopCodeParameter4IX] ON [dbo].[CrashClass]([StopCodeParameter4]) ON [PRIMARY]
GO

 CREATE  INDEX [BaseNameIX] ON [dbo].[KernelModuleData]([BaseName]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProcessorType] ADD 
	CONSTRAINT [ProcessorTypeProcessorVendorFK] FOREIGN KEY 
	(
		[VendorID]
	) REFERENCES [dbo].[ProcessorVendor] (
		[VendorID]
	)
GO

ALTER TABLE [dbo].[AttachmentData] ADD 
	CONSTRAINT [AttachmentDataCrashInstanceFK] FOREIGN KEY 
	(
		[ClassID],
		[InstanceID]
	) REFERENCES [dbo].[CrashInstance] (
		[ClassID],
		[InstanceID]
	)
GO

ALTER TABLE [dbo].[CrashClass] ADD 
	CONSTRAINT [CrashClassAnalysisFK] FOREIGN KEY 
	(
		[AnalysisID]
	) REFERENCES [dbo].[Analysis] (
		[AnalysisID]
	),
	CONSTRAINT [CrashClassSolutionFK] FOREIGN KEY 
	(
		[SolutionID]
	) REFERENCES [dbo].[Solution] (
		[SolutionID]
	)
GO

ALTER TABLE [dbo].[CrashInstance] ADD 
	CONSTRAINT [CrashInstanceCrashClassFK] FOREIGN KEY 
	(
		[ClassID]
	) REFERENCES [dbo].[CrashClass] (
		[ClassID]
	),
	CONSTRAINT [CrashInstanceHWProfileFK] FOREIGN KEY 
	(
		[HWProfileRecID]
	) REFERENCES [dbo].[HWProfile] (
		[HWProfileRecID]
	),
	CONSTRAINT [CrashInstanceOSProfileFK] FOREIGN KEY 
	(
		[OSProfileRecID]
	) REFERENCES [dbo].[OSProfile] (
		[OSProfileRecID]
	)
GO

ALTER TABLE [dbo].[ExternalRecordLocator] ADD 
	CONSTRAINT [ExternalRecordLocatorCrashInstanceFK] FOREIGN KEY 
	(
		[ClassID],
		[InstanceID]
	) REFERENCES [dbo].[CrashInstance] (
		[ClassID],
		[InstanceID]
	)
GO

ALTER TABLE [dbo].[HintData] ADD 
	CONSTRAINT [HintDataSolutionFK] FOREIGN KEY 
	(
		[SolutionID]
	) REFERENCES [dbo].[Solution] (
		[SolutionID]
	)
GO

ALTER TABLE [dbo].[KanalyzeModule] ADD 
	CONSTRAINT [KanalyzeModuleCrashInstanceFK] FOREIGN KEY 
	(
		[ClassID],
		[InstanceID]
	) REFERENCES [dbo].[CrashInstance] (
		[ClassID],
		[InstanceID]
	),
	CONSTRAINT [KanalyzeModuleKanalyzeModuleDataFK] FOREIGN KEY 
	(
		[KanalyzeModuleID]
	) REFERENCES [dbo].[KanalyzeModuleData] (
		[KanalyzeModuleID]
	)
GO

ALTER TABLE [dbo].[KernelModule] ADD 
	CONSTRAINT [KernelModuleCrashInstanceFK] FOREIGN KEY 
	(
		[ClassID],
		[InstanceID]
	) REFERENCES [dbo].[CrashInstance] (
		[ClassID],
		[InstanceID]
	),
	CONSTRAINT [KernelModuleKernelModuleDataFK] FOREIGN KEY 
	(
		[KernelModuleID]
	) REFERENCES [dbo].[KernelModuleData] (
		[KernelModuleID]
	)
GO

ALTER TABLE [dbo].[ProgressText] ADD 
	CONSTRAINT [ProgressTextAnalysisFK] FOREIGN KEY 
	(
		[AnalysisID]
	) REFERENCES [dbo].[Analysis] (
		[AnalysisID]
	)
GO

ALTER TABLE [dbo].[VariableCrashData] ADD 
	CONSTRAINT [VariableCrashDataCrashInstanceFK] FOREIGN KEY 
	(
		[ClassID],
		[InstanceID]
	) REFERENCES [dbo].[CrashInstance] (
		[ClassID],
		[InstanceID]
	)
GO

PRINT ('Done adding constraints and indexes to the KaKnownIssue Database...')

PRINT ('Defining Stored Procedures for the KaKnownIssue Database  ...')
Go

IF OBJECT_ID('dbo.spKaDisableHistoryLogging') IS NOT NULL
   DROP PROCEDURE  spKaDisableHistoryLogging
Go

Create Procedure spKaDisableHistoryLogging
As
Begin

PRINT (' Disable Triggers from the KaKnownIssue database.')

IF OBJECT_ID('dbo.tr_TrackAssociateDBUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackAssociateDBUpdates


IF OBJECT_ID('dbo.tr_TrackAnalysisUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackAnalysisUpdates


IF OBJECT_ID('dbo.tr_TrackSolutionUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackSolutionUpdates


IF OBJECT_ID('dbo.tr_TrackCrashClassUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackCrashClassUpdates


IF OBJECT_ID('dbo.tr_TrackCrashInstanceUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackCrashInstanceUpdates


IF OBJECT_ID('dbo.tr_TrackKernelModuleDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKernelModuleDataUpdates


IF OBJECT_ID('dbo.tr_TrackKernelModuleUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKernelModuleUpdates


IF OBJECT_ID('dbo.tr_TrackKanalyzeModuleDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKanalyzeModuleDataUpdates


IF OBJECT_ID('dbo.tr_TrackKanalyzeModuleUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKanalyzeModuleUpdates


IF OBJECT_ID('dbo.tr_TrackExternalRecordLocatorUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackExternalRecordLocatorUpdates


IF OBJECT_ID('dbo.tr_TrackProgressTextUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackProgressTextUpdates


IF OBJECT_ID('dbo.tr_TrackVariableCrashDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackVariableCrashDataUpdates


IF OBJECT_ID('dbo.tr_TrackAttachmentDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackAttachmentDataUpdates


IF OBJECT_ID('dbo.tr_TrackHintDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackHintDataUpdates


IF OBJECT_ID('dbo.tr_TrackOSProfileUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackOSProfileUpdates


IF OBJECT_ID('dbo.tr_TrackHWProfileUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackHWProfileUpdates


IF OBJECT_ID('dbo.tr_TrackStopCodeDescriptionUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackStopCodeDescriptionUpdates


PRINT (' Done disabling Triggers from the KaKnownIssue database.')

End
Go

IF OBJECT_ID('dbo.spKaDisableAllConstraints') IS NOT NULL
   DROP PROCEDURE  spKaDisableAllConstraints
Go

Create Procedure spKaDisableAllConstraints
As
Begin

PRINT (' Dropping All Constraints from the KaKnownIssue database.')

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeIX')
    DROP INDEX CrashClass.StopCodeIX

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeParameter1IX')
   DROP INDEX CrashClass.StopCodeParameter1IX

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeParameter2IX')
   DROP INDEX CrashClass.StopCodeParameter2IX

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeParameter3IX')
   DROP INDEX CrashClass.StopCodeParameter3IX

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'StopCodeParameter4IX')
   DROP INDEX CrashClass.StopCodeParameter4IX

IF EXISTS (SELECT name FROM sysindexes
            WHERE name = 'BaseNameIX')
   DROP INDEX KernelModuleData.BaseNameIX

IF OBJECT_ID('dbo.ProcessorTypeProcessorVendorFK') IS NOT NULL
   ALTER TABLE dbo.ProcessorType 
   DROP CONSTRAINT ProcessorTypeProcessorVendorFK

IF OBJECT_ID('dbo.CrashClassAnalysisFK') IS NOT NULL
   ALTER TABLE dbo.CrashClass 
   DROP CONSTRAINT CrashClassAnalysisFK

IF OBJECT_ID('dbo.CrashClassSolutionFK') IS NOT NULL
   ALTER TABLE dbo.CrashClass 
   DROP CONSTRAINT CrashClassSolutionFK

IF OBJECT_ID('dbo.CrashInstanceCrashClassFK') IS NOT NULL
   ALTER TABLE dbo.CrashInstance
   DROP CONSTRAINT CrashInstanceCrashClassFK

IF OBJECT_ID('dbo.CrashInstanceHWProfileFK') IS NOT NULL
   ALTER TABLE dbo.CrashInstance
   DROP CONSTRAINT CrashInstanceHWProfileFK

IF OBJECT_ID('dbo.CrashInstanceOSProfileFK') IS NOT NULL
   ALTER TABLE dbo.CrashInstance
   DROP CONSTRAINT CrashInstanceOSProfileFK

IF OBJECT_ID('dbo.KernelModuleKernelModuleDataFK') IS NOT NULL
   ALTER TABLE dbo.KernelModule
   DROP CONSTRAINT KernelModuleKernelModuleDataFK

IF OBJECT_ID('dbo.KernelModuleCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.KernelModule
   DROP CONSTRAINT KernelModuleCrashInstanceFK

IF OBJECT_ID('dbo.KanalyzeModuleCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.KanalyzeModule
   DROP CONSTRAINT  KanalyzeModuleCrashInstanceFK

IF OBJECT_ID('dbo.KanalyzeModuleKanalyzeModuleDataFK') IS NOT NULL
   ALTER TABLE dbo.KanalyzeModule
   DROP CONSTRAINT KanalyzeModuleKanalyzeModuleDataFK 

IF OBJECT_ID('dbo.ProgressTextAnalysisFK') IS NOT NULL
   ALTER TABLE dbo.ProgressText
   DROP CONSTRAINT  ProgressTextAnalysisFK

IF OBJECT_ID('dbo.VariableCrashDataCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.VariableCrashData
   DROP CONSTRAINT VariableCrashDataCrashInstanceFK 

IF OBJECT_ID('dbo.ExternalRecordLocatorCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.ExternalRecordLocator
   DROP CONSTRAINT ExternalRecordLocatorCrashInstanceFK 

IF OBJECT_ID('dbo.AttachmentDataCrashInstanceFK') IS NOT NULL
   ALTER TABLE dbo.AttachmentData
   DROP CONSTRAINT AttachmentDataCrashInstanceFK 

IF OBJECT_ID('dbo.HintDataSolutionFK') IS NOT NULL
   ALTER TABLE dbo.HintData
   DROP CONSTRAINT  HintDataSolutionFK

PRINT (' Done dropping All Constraints from the KaKnownIssue database.')

End
Go

PRINT ('Done defining Stored Procedures for the KaKnownIssue Database  ...')

PRINT ('Populating Static tables...')
SET NOCOUNT ON

PRINT ( 'Using KaKnownIssue Database...')

PRINT ( 'Populating The ProcessorVendor Table')
SET IDENTITY_INSERT ProcessorVendor ON
INSERT INTO ProcessorVendor(VendorID,VendorName) VALUES (1, 'GenuineIntel')
INSERT INTO ProcessorVendor(VendorID,VendorName) VALUES (2, 'AuthenticAMD')
INSERT INTO ProcessorVendor(VendorID,VendorName) VALUES (3, 'CyrixInstead')
INSERT INTO ProcessorVendor(VendorID,VendorName) VALUES (4, 'unknown')
SET IDENTITY_INSERT ProcessorVendor OFF
Go

PRINT ( 'Populating The ProcessorType Table')
SET IDENTITY_INSERT ProcessorType ON
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type )             VALUES(1,4,'unknown')
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(2,1,'80486',4,0)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(3,1,'80486',4,1)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(4,1,'80486',4,2)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(5,1,'80486',4,3)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(6,1,'80486',4,4)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(7,1,'80486',4,5)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(8,1,'80486',4,7)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(9,1,'80486',4,8)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(10,1,'Pentium',5,1)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(11,1,'Pentium',5,2)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(12,1,'Pentium',5,3)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(13,1,'P-MMX',5,4)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(14,1,'PPro',6,1)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(15,1,'PII',6,3)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(16,1,'PII',6,5)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(17,1,'PII',6,6)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(18,1,'PIII',6,7)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(19,2,'K5',5,0)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(20,2,'K5',5,1)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(21,2,'K5',5,2)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(22,2,'K5',5,3)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(23,2,'K6',5,6)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(24,2,'K6',5,7)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(25,2,'K6',6,7)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(26,2,'K6-2',5,8)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(27,2,'K6-2',6,8)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(28,2,'K6-3',5,9)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(29,2,'K6-3',6,9)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(30,2,'K7ES',6,0)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(31,2,'K7ES',7,0)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(32,3,'Athlon',6,1)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(33,3,'Athlon',7,1)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(34,3,'MediaGX',4,4)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(35,3,'6x86',5,2)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(36,3,'GXm',5,4)
INSERT INTO ProcessorType (ProcessorTypeID,VendorID,Type,Family,Model) VALUES(37,3,'6X86MX',6,0)
SET IDENTITY_INSERT ProcessorType OFF


PRINT ( 'Populating The StopCode Description Table') 

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '1', 'APC_INDEX_MISMATCH')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '2', 'DEVICE_QUEUE_NOT_BUSY')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '3', 'INVALID_AFFINITY_SET')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '4', 'INVALID_DATA_ACCESS_TRAP')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '5','INVALID_PROCESS_ATTACH_ATTEMPT')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '6','INVALID_PROCESS_DETACH_ATTEMPT')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '7', 'INVALID_SOFTWARE_INTERRUPT')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '8', 'IRQL_NOT_DISPATCH_LEVEL')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '9', 'IRQL_NOT_GREATER_OR_EQUAL')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( 'A', 'IRQL_NOT_LESS_OR_EQUAL') 

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( 'B', 'NO_EXCEPTION_HANDLING_SUPPORT')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( 'C', 'MAXIMUM_WAIT_OBJECTS_EXCEEDED')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( 'D', 'MUTEX_LEVEL_NUMBER_VIOLATION')  

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( 'E', 'NO_USER_MODE_CONTEXT')            

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( 'F', 'SPIN_LOCK_ALREADY_OWNED')         

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '10', 'SPIN_LOCK_NOT_OWNED')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '11', 'THREAD_NOT_MUTEX_OWNER')           

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '12','TRAP_CAUSE_UNKNOWN')               

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '13', 'EMPTY_THREAD_REAPER_LIST')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '14','CREATE_DELETE_LOCK_NOT_LOCKED' )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '15', 'LAST_CHANCE_CALLED_FROM_KMODE')    

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '16','CID_HANDLE_CREATION')              

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '17', 'CID_HANDLE_DELETION')              

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '18', 'REFERENCE_BY_POINTER')             

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '19', 'BAD_POOL_HEADER' )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '1A', 'MEMORY_MANAGEMENT')     

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '1B', 'PFN_SHARE_COUNT')                  

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '1C', 'PFN_REFERENCE_COUNT' )              

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '1D', 'NO_SPIN_LOCK_AVAILABLE'  )       

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '1E', 'KMODE_EXCEPTION_NOT_HANDLED' ) 

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '1F', 'SHARED_RESOURCE_CONV_ERROR')      

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '20', 'KERNEL_APC_PENDING_DURING_EXIT' )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '21', 'QUOTA_UNDERFLOW' )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '22', 'FILE_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '23', 'FAT_FILE_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '24', 'NTFS_FILE_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '25', 'NPFS_FILE_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '26', 'CDFS_FILE_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '27', 'RDR_FILE_SYSTEM '  )
                
INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '28', 'CORRUPT_ACCESS_TOKEN'  )
             
INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '29', 'SECURITY_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '2A ', 'INCONSISTENT_IRP'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '2B', 'PANIC_STACK_SWITCH'  )
               
INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '2C', 'PORT_DRIVER_INTERNAL'  )
            
INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '2D', 'SCSI_DISK_DRIVER_INTERNAL'  )
       
INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '2E', 'DATA_BUS_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '2F', 'INSTRUCTION_BUS_ERROR')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '30', 'SET_OF_INVALID_CONTEXT'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '31', 'PHASE0_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '32', 'PHASE1_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '33', 'UNEXPECTED_INITIALIZATION_CALL')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '34', 'CACHE_MANAGER')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '35', 'NO_MORE_IRP_STACK_LOCATIONS'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '36', 'DEVICE_REFERENCE_COUNT_NOT_ZERO'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '37', 'FLOPPY_INTERNAL_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '38', 'SERIAL_DRIVER_INTERNAL'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '39', 'SYSTEM_EXIT_OWNED_MUTEX'  )
    
INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '3A', 'SYSTEM_UNWIND_PREVIOUS_USER'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '3B', 'SYSTEM_SERVICE_EXCEPTION'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '3C', 'INTERRUPT_UNWIND_ATTEMPTED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '3D', 'INTERRUPT_EXCEPTION_NOT_HANDLED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '3E', 'MULTIPROCESSOR_CONFIGURATION_NOT_SUPPORTED'  ) 

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '3F', 'NO_MORE_SYSTEM_PTES'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '40', 'TARGET_MDL_TOO_SMALL'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '41', 'MUST_SUCCEED_POOL_EMPTY'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '42', 'ATDISK_DRIVER_INTERNAL'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '43', 'NO_SUCH_PARTITION'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '44', 'MULTIPLE_IRP_COMPLETE_REQUESTS'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '45', 'INSUFFICIENT_SYSTEM_MAP_REGS'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '46', 'DEREF_UNKNOWN_LOGON_SESSION'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '47', 'REF_UNKNOWN_LOGON_SESSION'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '48', 'CANCEL_STATE_IN_COMPLETED_IRP')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '4A', 'IRQL_GT_ZERO_AT_SYSTEM_SERVICE'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '4B', 'STREAMS_INTERNAL_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '4C', 'FATAL_UNHANDLED_HARD_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '4D', 'NO_PAGES_AVAILABLE'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '4E', 'PFN_LIST_CORRUPT'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '4F', 'NDIS_INTERNAL_ERROR'  )
            
INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '50', 'PAGE_FAULT_IN_NONPAGED_AREA')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '51', 'REGISTRY_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '52', 'MAILSLOT_FILE_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '53', 'NO_BOOT_DEVICE'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '54', 'LM_SERVER_INTERNAL_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '55', 'DATA_COHERENCY_EXCEPTION'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '56', 'INSTRUCTION_COHERENCY_EXCEPTION'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '57', 'XNS_INTERNAL_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '58', 'FTDISK_INTERNAL_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '59', 'PINBALL_FILE_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '5A', 'CRITICAL_SERVICE_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '5B', 'SET_ENV_VAR_FAILED')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '5C ', 'HAL_INITIALIZATION_FAILED' )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '5D', 'HEAP_INITIALIZATION_FAILED' )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '5E', 'OBJECT_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '5F', 'SECURITY_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '60', 'PROCESS_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '61', 'HAL1_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '62', 'OBJECT1_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '63', 'SECURITY1_INITIALIZATION_FAILED')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '64', 'SYMBOLIC_INITIALIZATION_FAILED')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '65', 'MEMORY1_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '66', 'CACHE_INITIALIZATION_FAILED')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '67', 'CONFIG_INITIALIZATION_FAILED')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '68', 'FILE_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '69', 'IO1_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '6A ', 'LPC_INITIALIZATION_FAILED')

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '6B', 'PROCESS1_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '6C', 'REFMON_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '6D', 'SESSION1_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '6E', 'SESSION2_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '6F', 'SESSION3_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '70', 'SESSION4_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '71', 'SESSION5_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '72', 'ASSIGN_DRIVE_LETTERS_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '73', 'CONFIG_LIST_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '74', 'BAD_SYSTEM_CONFIG_INFO'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '75', 'CANNOT_WRITE_CONFIGURATION'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '76', 'PROCESS_HAS_LOCKED_PAGES'  ) 

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '77', 'KERNEL_STACK_INPAGE_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '78', 'PHASE0_EXCEPTION'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '79', 'MISMATCHED_HAL'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '7A', 'KERNEL_DATA_INPAGE_ERROR'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '7B ', 'INACCESSIBLE_BOOT_DEVICE'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '7C ', 'BUGCODE_PSS_MESSAGE'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '7D', 'INSTALL_MORE_MEMORY'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '7E', 'WINDOWS_NT_BANNER'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '7F', 'UNEXPECTED_KERNEL_MODE_TRAP'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '80', 'NMI_HARDWARE_FAILURE'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '81', 'SPIN_LOCK_INIT_FAILURE'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '85', 'SETUP_FAILURE'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '8B', 'MBR_CHECKSUM_MISMATCH'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '8F', 'PP0_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '90', 'PP1_INITIALIZATION_FAILED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '92', 'UP_DRIVER_ON_MP_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '93', 'INVALID_KERNEL_HANDLE'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '94', 'KERNEL_STACK_LOCKED_AT_EXIT'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '96', 'INVALID_WORK_QUEUE_ITEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '97', 'BOUND_IMAGE_UNSUPPORTED'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '98', 'END_OF_NT_EVALUATION_PERIOD'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '99', 'INVALID_REGION_OR_SEGMENT'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '9a', 'SYSTEM_LICENSE_VIOLATION'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '9B', 'UDFS_FILE_SYSTEM'  )

INSERT INTO StopCodeDescription (StopCode, Name )
VALUES ( '9C', 'MACHINE_CHECK_EXCEPTION'  )
GO

PRINT ( 'Done Populating The StopCode Description Table...') 

PRINT ( 'Populating the Solution Table With No Solution Entry')

SET IDENTITY_INSERT Solution ON
INSERT INTO Solution (SolutionID, Abstract,SolutionDescription,LastUpdated)
VALUES ( 1, 'No solution available','None','1999-01-01 00:00:00')
SET IDENTITY_INSERT Solution OFF
GO

PRINT ( 'Done Populating The Solution Table With No Solution Entry...')

PRINT ( 'Populating The Analysis Table With No Analysis Entry')

SET IDENTITY_INSERT Analysis ON
INSERT INTO Analysis (AnalysisID, Abstract,ProblemDescription,Status)
VALUES ( 1, 'No analysis available','None','NOANLYS')
SET IDENTITY_INSERT Analysis OFF
GO

PRINT ( 'Done Populating The Analysis Table With No Analysis Entry...')
SET NOCOUNT OFF

PRINT ('Setting permissions on DB objects...')
--TBD

PRINT ('Done.')