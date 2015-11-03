/*++
/ KaCreateDb.sql
/ 
/ Abstract - This script creates the KaKnownIssue Database.
/
Author:

    Peter Hiross (v-peteh) & Dick Tanabe ( v-dickta ) 	September 20, 1999

Revision History:

    Dick Tanabe (v-dickta)        Oct 25, 1999   Increased Database MaxSize to 250MB and 
                                                                     LOG MaxSize to 65MB
--*/

PRINT 'Creating KaKnownIssue Database...'

USE master
GO

IF DB_ID('KaKnownIssue') IS NOT NULL
   RAISERROR( 'Known Issue Database already exits. Must Drop Database first',16,1 )
ELSE
BEGIN 
CREATE DATABASE KaKnownIssue
ON PRIMARY (
  Name= KaKnownIssue,
  FileName= 'C:\MSSQL7\Data\KaKnownIssue.mdf',
  Size= 10MB,
  MaxSize= 250MB,
  FileGrowth= 20%)
LOG ON (
  Name= KaKnownIssue_log,
  FileName= 'C:\MSSQL7\log\KaKnownIssue.ldf',
  Size= 3MB,
  MaxSize= 65MB,
  FileGrowth= 1MB )  
--
-- IF ok then display statistics on new database.
--

IF DB_ID('KaKnownIssue') IS NOT NULL
BEGIN
  PRINT (' ')
  EXEC sp_helpdb KaKnownIssue
END
END