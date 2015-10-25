/*++
/ KaEnableDBHistoryLog.sql
/ 
/ Abstract - This script Enables History Logging for the tables in the KaKnownIssue Database.
/
Author:

    Peter Hiross (v-peteh) & Dick Tanabe ( v-dickta ) 	September 28, 1999

Revision History:
--*/

PRINT 'Enabling History Logging for KaKnownIssue Database...'

USE KaKnownIssue
GO

IF OBJECT_ID('dbo.tr_TrackAnalysisUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackAnalysisUpdates
Go

Create trigger tr_TrackAnalysisUpdates
    on dbo.Analysis
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'Analysis',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'Analysis',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackAssociateDBUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackAssociateDBUpdates
Go

Create trigger tr_TrackAssociateDBUpdates
    on dbo.AssociateDB
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'AssociateDB',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'AssociateDB',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackAttachmentDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackAttachmentDataUpdates
Go

Create trigger tr_TrackAttachmentDataUpdates
    on dbo.AttachmentData
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'AttachmentData',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'AttachmentData',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackCrashClassUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackCrashClassUpdates
Go

Create trigger tr_TrackCrashClassUpdates
    on dbo.CrashClass
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'CrashClass',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'CrashClass',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackCrashInstanceUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackCrashInstanceUpdates
Go

Create trigger tr_TrackCrashInstanceUpdates
    on dbo.CrashInstance
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'CrashInstance',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'CrashInstance',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackExternalRecordLocatorUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackExternalRecordLocatorUpdates
Go

Create trigger tr_TrackExternalRecordLocatorUpdates
    on dbo.ExternalRecordLocator
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'ExternalRecordLocator',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'ExternalRecordLocator',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackHintDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackHintDataUpdates
Go

Create trigger tr_TrackHintDataUpdates
    on dbo.HintData
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'HintData',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'HintData',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackHWProfileUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackHWProfileUpdates
Go

Create trigger tr_TrackHWProfileUpdates
    on dbo.HWProfile
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'HWProfile',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'HWProfile',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackKanalyzeModuleUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKanalyzeModuleUpdates
Go

Create trigger tr_TrackKanalyzeModuleUpdates
    on dbo.KanalyzeModule
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'KanalyzeModule',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'KanalyzeModule',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackKanalyzeModuleDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKanalyzeModuleDataUpdates
Go

Create trigger tr_TrackKanalyzeModuleDataUpdates
    on dbo.KanalyzeModuleData
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'KanalyzeModuleData',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'KanalyzeModuleData',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackKernelModuleUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKernelModuleUpdates
Go

Create trigger tr_TrackKernelModuleUpdates
    on dbo.KernelModule
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'KernelModule',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'KernelModule',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackKernelModuleDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackKernelModuleDataUpdates
Go

Create trigger tr_TrackKernelModuleDataUpdates
    on dbo.KernelModuleData
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'KernelModuleData',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'KernelModuleData',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackOSProfileUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackOSProfileUpdates
Go

Create trigger tr_TrackOSProfileUpdates
    on dbo.OSProfile
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'OSProfile',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'OSProfile',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackProgressTextUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackProgressTextUpdates
Go

Create trigger tr_TrackProgressTextUpdates
    on dbo.ProgressText
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'ProgressText',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'ProgressText',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackSolutionUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackSolutionUpdates
Go

Create trigger tr_TrackSolutionUpdates
    on dbo.Solution
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'Solution',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'Solution',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackStopCodeDescriptionUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackStopCodeDescriptionUpdates
Go

Create trigger tr_TrackStopCodeDescriptionUpdates
    on dbo.StopCodeDescription
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'StopCodeDescription',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'StopCodeDescription',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

IF OBJECT_ID('dbo.tr_TrackVariableCrashDataUpdates') IS NOT NULL
   DROP TRIGGER tr_TrackVariableCrashDataUpdates
Go

Create trigger tr_TrackVariableCrashDataUpdates
    on dbo.VariableCrashData
    for Insert, Update, Delete
as 
    Declare @InsertedCount Int
    Declare @DeletedCount Int
    Set @InsertedCount  = ( Select Count(*) From inserted )
    Set @DeletedCount   = ( Select Count(*) From deleted )
    If ( @InsertedCount > 0 ) Begin 
       Insert Into dbo.History
               ( Operation,
                 TableName,
                 UserName,
                 TimeStamp)
          Select Case
                    When ( @DeletedCount > 0 ) Then
                           'Update'
                    Else   'Insert'
                 End,
                 'VariableCrashData',
                 Current_User,
                 Current_TimeStamp
              From inserted
    End
    Else if ( @DeletedCount > 0 ) Begin
       Insert Into dbo.History
            ( Operation,
              TableName,
              UserName,
              TimeStamp)
          Select   'Delete',
	           'VariableCrashData',
                   Current_User,
                   Current_TimeStamp
              From deleted
    End
Go

PRINT ( 'Done Enabling History Logging ...' )