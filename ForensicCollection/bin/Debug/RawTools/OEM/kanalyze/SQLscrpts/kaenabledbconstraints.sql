/*++
Copyright (c) 1999 Microsoft Corporation

Module Name:

    KaEnableDBConstraints.sql

Abstract:

    This script is used to add constraints and indexes to 
    the Kanalyze Known Issues Database.
	
Author:

   Peter Hiross ( v-peteh) & Dick Tanabe ( v-dickta ) 	September 27, 1999
   

Revision History:

   Dick Tanabe (v-dickta)        Oct 25, 1999    Added ClassID as Foreign Key in CrashInstance Table
   Dick Tanabe (v-dickta)        Nov 03, 1999   Added index BaseName to KernelModuleData Table
   Dick Tanabe (v-dickta)        Nov 11, 1999   Added two new tables: ProcessorType and ProcessorVendor
   Dick Tanabe (v-dickta)        Dec 03, 1999   Revised script for case sensitivity, Raid Bug 585

--*/

Use KaKnownIssue
Go

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

PRINT ('Done adding constraints and indexes to the KaKnownIssue Database.')

