/*++
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    cleanup.sql

Abstract:

    This script clean up the KaKnownIssue Database.

Author:

    Akifumi Nagai(v-akinag) 15-DEC-1999

Revision History:

--*/

PRINT 'Clean Up KaKnownIssue Database...'

USE master
GO

-- change the Database Name. (1/2) --
IF DB_ID('KaKnownIssue') IS NULL
    RAISERROR( 'Error. Known Issue Database does not exist, so you must create this first.',16,1 )
ELSE
BEGIN
    -- change the Database Name. (2/2) --
    USE KaKnownIssue

    PRINT '--- HWProfile Table Clean Up ---'
    DECLARE 
       @HWProfileRecID   int,
       @HWProfileRecIDCP int,
       @Architecture     char(8),
       @ProcessorType    char(8),
       @ProcessorSpec    char(8),
       @ProcessorVendor  varchar(13),
       @ProcessorCount   smallint,
       @OccurrenceCount  int,
       @OccurrenceCountCP int,
       @OccurrenceCountNEW int

    DECLARE HWProfile CURSOR FOR
        SELECT * FROM HWProfile

    OPEN HWProfile
    FETCH NEXT FROM HWProfile INTO @HWProfileRecID,@Architecture,@ProcessorType,@ProcessorSpec,@ProcessorVendor,@ProcessorCount,@OccurrenceCount

    SET @OccurrenceCountNEW=@OccurrenceCount

    WHILE @@FETCH_STATUS=0
    BEGIN
        DECLARE HWProfileCP CURSOR FOR
            SELECT HWProfileRecID,OccurrenceCount FROM HWProfile WHERE
                HWProfileRecID<>@HWProfileRecID AND
                Architecture=@Architecture AND
                ProcessorType=@ProcessorType AND
                ProcessorSpec=@ProcessorSpec AND
                ProcessorVendor=@ProcessorVendor AND
                ProcessorCount=@ProcessorCount

        OPEN HWProfileCP
        FETCH NEXT FROM HWProfileCP INTO @HWProfileRecIDCP,@OccurrenceCountCP

        WHILE @@FETCH_STATUS=0
        BEGIN
            PRINT 'HWProfileRecID='+RTRIM(CONVERT(varchar(30),@HWProfileRecIDCP))
            UPDATE CrashInstance SET
                HWProfileRecID=@HWProfileRecID
                WHERE HWProfileRecID=@HWProfileRecIDCP
            SET @OccurrenceCountNEW=@OccurrenceCountCP+@OccurrenceCount
            UPDATE HWProfile SET
                OccurrenceCount=@OccurrenceCountNEW
                WHERE HWProfileRecID=@HWProfileRecID
            DELETE FROM HWProfile WHERE HWProfileRecID=@HWProfileRecIDCP
            FETCH NEXT FROM HWProfileCP INTO @HWProfileRecIDCP,@OccurrenceCountCP
        END
        CLOSE HWProfileCP
        DEALLOCATE HWProfileCP

        FETCH NEXT FROM HWProfile INTO @HWProfileRecID,@Architecture,@ProcessorType,@ProcessorSpec,@ProcessorVendor,@ProcessorCount,@OccurrenceCount
    END

    CLOSE HWProfile
    DEALLOCATE HWProfile

    PRINT '--- OSProfile Table Clean Up ---'
    DECLARE 
       @OSProfileRecID     int,
       @OSProfileRecIDCP   int,
       @OSCheckedBuild     bit,
       @OSSMPKernel        bit,
       @OSPAEKernel        bit,
       @OSBuild            smallint,
       @OSServicePackLevel smallint,
       @ProductType        varchar(12),
       @QfeData            nvarchar(256)

    DECLARE OSProfile CURSOR FOR
        SELECT * FROM OSProfile

    OPEN OSProfile
    FETCH NEXT FROM OSProfile INTO
        @OSProfileRecID ,
        @OSCheckedBuild ,
        @OSSMPKernel ,
        @OSPAEKernel ,
        @OSBuild ,
        @OSServicePackLevel ,
        @ProductType ,
        @QfeData ,
        @OccurrenceCount

    SET @OccurrenceCountNEW=@OccurrenceCount

    WHILE @@FETCH_STATUS=0
    BEGIN
        DECLARE OSProfileCP CURSOR FOR
            SELECT OSProfileRecID,OccurrenceCount FROM OSProfile WHERE
                OSProfileRecID <> @OSProfileRecID AND
                OSCheckedBuild = @OSCheckedBuild AND
                OSSMPKernel = @OSSMPKernel AND
                OSPAEKernel = @OSPAEKernel AND
                OSBuild = @OSBuild AND
                OSServicePackLevel = @OSServicePackLevel AND
                ProductType = @ProductType AND
                QfeData = @QfeData

        OPEN OSProfileCP
        FETCH NEXT FROM OSProfileCP INTO @OSProfileRecIDCP,@OccurrenceCountCP

        WHILE @@FETCH_STATUS=0
        BEGIN
            PRINT 'OSProfileRecID='+RTRIM(CONVERT(varchar(30),@OSProfileRecIDCP))
            UPDATE CrashInstance SET
                OSProfileRecID=@OSProfileRecID
                WHERE OSProfileRecID=@OSProfileRecIDCP
            SET @OccurrenceCountNEW=@OccurrenceCount+@OccurrenceCountCP
            UPDATE OSProfile SET
                OccurrenceCount=@OccurrenceCountNEW
                WHERE OSProfileRecID=@OSProfileRecID
            DELETE FROM OSProfile WHERE OSProfileRecID=@OSProfileRecIDCP
            FETCH NEXT FROM OSProfileCP INTO @OSProfileRecIDCP,@OccurrenceCountCP
        END
        CLOSE OSProfileCP
        DEALLOCATE OSProfileCP

        FETCH NEXT FROM OSProfile INTO
            @OSProfileRecID ,
            @OSCheckedBuild ,
            @OSSMPKernel ,
            @OSPAEKernel ,
            @OSBuild ,
            @OSServicePackLevel ,
            @ProductType ,
            @QfeData ,
            @OccurrenceCount
    END

    CLOSE OSProfile
    DEALLOCATE OSProfile

    PRINT '--- KernelModuleData Table Clean Up ---'
    DECLARE 
       @KernelModuleID        int ,
       @KernelModuleIDCP      int ,
       @BaseName              nvarchar(256) ,
       @Size                  int ,
       @CheckSum              char(8) ,
       @DateTime              datetime ,
       @SubSystemMajorVersion smallint ,
       @SubSystemMinorVersion smallint

    DECLARE KernelModuleData CURSOR FOR
        SELECT * FROM KernelModuleData

    OPEN KernelModuleData
    FETCH NEXT FROM KernelModuleData INTO
        @KernelModuleID ,
        @BaseName ,
        @Size ,
        @CheckSum ,
        @DateTime ,
        @SubSystemMajorVersion ,
        @SubSystemMinorVersion

    WHILE @@FETCH_STATUS=0
    BEGIN
        DECLARE KernelModuleDataeCP CURSOR FOR
            SELECT KernelModuleID FROM KernelModuleData WHERE
                KernelModuleID <> @KernelModuleID AND
                BaseName = @BaseName AND
                Size = @Size AND
                CheckSum = @CheckSum AND
                DateTime = @DateTime AND
                SubSystemMajorVersion = @SubSystemMajorVersion AND
                SubSystemMinorVersion = @SubSystemMinorVersion

        OPEN KernelModuleDataeCP
        FETCH NEXT FROM KernelModuleDataeCP INTO @KernelModuleIDCP

        WHILE @@FETCH_STATUS=0
        BEGIN
            PRINT 'KernelModuleID=' + RTRIM ( CONVERT ( varchar(30) , @KernelModuleIDCP ))
            UPDATE KernelModule SET
                KernelModuleID = @KernelModuleID
                WHERE KernelModuleID = @KernelModuleIDCP
            DELETE FROM KernelModuleData WHERE KernelModuleID = @KernelModuleIDCP
            FETCH NEXT FROM KernelModuleDataeCP INTO @KernelModuleIDCP
        END
        CLOSE KernelModuleDataeCP
        DEALLOCATE KernelModuleDataeCP

        FETCH NEXT FROM KernelModuleData INTO
            @KernelModuleID ,
            @BaseName ,
            @Size ,
            @CheckSum ,
            @DateTime ,
            @SubSystemMajorVersion ,
            @SubSystemMinorVersion
    END

    CLOSE KernelModuleData
    DEALLOCATE KernelModuleData

    PRINT '--- KanalyzeModuleData Table Clean Up ---'
    DECLARE 
       @KanalyzeModuleID   int ,
       @KanalyzeModuleIDCP int ,
       @Type               char(8) ,
       @AlternateName      nvarchar(50) ,
       @MajorVersion       smallint ,
       @MinorVersion       smallint ,
       @Description        nvarchar(256)

    DECLARE KanalyzeModuleData CURSOR FOR
        SELECT * FROM KanalyzeModuleData

    OPEN KanalyzeModuleData
    FETCH NEXT FROM KanalyzeModuleData INTO
        @KanalyzeModuleID ,
        @BaseName ,
        @Type ,
        @AlternateName ,
        @MajorVersion ,
        @MinorVersion ,
        @Description

    WHILE @@FETCH_STATUS=0
    BEGIN
        DECLARE KanalyzeModuleDataCP CURSOR FOR
            SELECT KanalyzeModuleID FROM KanalyzeModuleData WHERE
                KanalyzeModuleID <> @KanalyzeModuleID AND
                BaseName = @BaseName AND
                Type = @Type AND
                AlternateName = @AlternateName AND
                MajorVersion = @MajorVersion AND
                MinorVersion = @MinorVersion AND
                Description = @Description

        OPEN KanalyzeModuleDataCP
        FETCH NEXT FROM KanalyzeModuleDataCP INTO @KanalyzeModuleIDCP

        WHILE @@FETCH_STATUS=0
        BEGIN
            PRINT 'KanalyzeModuleID=' + RTRIM ( CONVERT ( varchar(30) , @KanalyzeModuleIDCP ))
            UPDATE KanalyzeModule SET
                KanalyzeModuleID = @KanalyzeModuleID
                WHERE KanalyzeModuleID = @KanalyzeModuleIDCP
            DELETE FROM KanalyzeModuleData WHERE KanalyzeModuleID = @KanalyzeModuleIDCP
            FETCH NEXT FROM KanalyzeModuleDataeCP INTO @KanalyzeModuleIDCP
        END
        CLOSE KanalyzeModuleDataCP
        DEALLOCATE KanalyzeModuleDataCP

        FETCH NEXT FROM KanalyzeModuleData INTO
            @KanalyzeModuleID ,
            @BaseName ,
            @Type ,
            @AlternateName ,
            @MajorVersion ,
            @MinorVersion ,
            @Description
    END

    CLOSE KanalyzeModuleData
    DEALLOCATE KanalyzeModuleData

    PRINT '--- CrashClass Table Clean Up ---'
    DECLARE 
       @ClassID            int ,
       @InstanceCount      int ,
       @FirstOccurrence    SmallDateTime ,
       @LastOccurrence     SmallDateTime ,
       @InstanceIDCP       int ,
       @CrashTimeDateCP    DateTime ,
       @SmallCrashTimeDateCP SmallDateTime ,
       @InstanceCountCP    int

    DECLARE CrashClass CURSOR FOR
        SELECT ClassID,InstanceCount,FirstOccurrence,LastOccurrence FROM CrashClass

    OPEN CrashClass
    FETCH NEXT FROM CrashClass INTO
        @ClassID ,
        @InstanceCount ,
        @FirstOccurrence ,
        @LastOccurrence

    WHILE @@FETCH_STATUS=0
    BEGIN
        DECLARE CrashInstanceCP CURSOR FOR
            SELECT InstanceID,CrashTimeDate FROM CrashInstance WHERE
                ClassID=@ClassID

        OPEN CrashInstanceCP
        FETCH NEXT FROM CrashInstanceCP INTO @InstanceIDCP,@CrashTimeDateCP

        SELECT @InstanceCountCP=COUNT(*) FROM CrashInstance WHERE ClassID=@ClassID

        IF @InstanceCount!=@InstanceCountCP
        BEGIN
            PRINT 'ClassID=' + RTRIM ( CONVERT ( varchar(30) , @ClassID ))
            UPDATE CrashClass SET
                InstanceCount = @InstanceCountCP
                WHERE ClassID=@ClassID

            WHILE @@FETCH_STATUS=0
            BEGIN
                SET @SmallCrashTimeDateCP = CONVERT(SmallDateTime,@CrashTimeDateCP)

                IF @SmallCrashTimeDateCP > @LastOccurrence
                BEGIN
                    UPDATE CrashClass SET
                        LastOccurrence = @SmallCrashTimeDateCP
                        WHERE ClassID = @ClassID
                    SET @LastOccurrence = @SmallCrashTimeDateCP
                END
                ELSE IF @SmallCrashTimeDateCP < @FirstOccurrence
                BEGIN
                    UPDATE CrashClass SET
                        FirstOccurrence = @SmallCrashTimeDateCP
                        WHERE ClassID=@ClassID
                    SET @FirstOccurrence = @SmallCrashTimeDateCP
                END

                IF @FirstOccurrence IS NULL AND @CrashTimeDateCP IS NOT NULL
                BEGIN
                    IF @SmallCrashTimeDateCP <= @LastOccurrence
                    BEGIN
                        UPDATE CrashClass SET
                            FirstOccurrence = @SmallCrashTimeDateCP
                            WHERE ClassID=@ClassID
                        SET @FirstOccurrence = @SmallCrashTimeDateCP
                    END
                    ELSE IF @SmallCrashTimeDateCP > @LastOccurrence
                    BEGIN
                        UPDATE CrashClass SET
                            FirstOccurrence = @LastOccurrence,
                            LastOccurrence = @SmallCrashTimeDateCP
                            WHERE ClassID=@ClassID
                        SET @FirstOccurrence = @LastOccurrence
                        SET @LastOccurrence = @SmallCrashTimeDateCP
                    END
                    ELSE
                    BEGIN
                        UPDATE CrashClass SET
                            FirstOccurrence = @SmallCrashTimeDateCP,
                            LastOccurrence = @SmallCrashTimeDateCP
                            WHERE ClassID=@ClassID
                        SET @FirstOccurrence = @SmallCrashTimeDateCP
                        SET @LastOccurrence = @SmallCrashTimeDateCP
                    END
                END

                IF @LastOccurrence IS NULL AND @CrashTimeDateCP IS NOT NULL
                BEGIN
                    IF @SmallCrashTimeDateCP >= @FirstOccurrence
                    BEGIN
                        UPDATE CrashClass SET
                            LastOccurrence = @SmallCrashTimeDateCP
                            WHERE ClassID=@ClassID
                        SET @LastOccurrence = @SmallCrashTimeDateCP
                    END
                    ELSE IF @SmallCrashTimeDateCP < @FirstOccurrence
                    BEGIN
                        UPDATE CrashClass SET
                            FirstOccurrence = @SmallCrashTimeDateCP,
                            LastOccurrence = @FirstOccurrence
                            WHERE ClassID=@ClassID
                        SET @FirstOccurrence = @SmallCrashTimeDateCP
                        SET @LastOccurrence = @FirstOccurrence
                    END
                END

                FETCH NEXT FROM CrashInstanceCP INTO @InstanceIDCP,@CrashTimeDateCP
            END
        END
        CLOSE CrashInstanceCP
        DEALLOCATE CrashInstanceCP

        FETCH NEXT FROM CrashClass INTO
            @ClassID ,
            @InstanceCount ,
            @FirstOccurrence ,
            @LastOccurrence
    END

    CLOSE CrashClass
    DEALLOCATE CrashClass

    PRINT 'Done.'
END
