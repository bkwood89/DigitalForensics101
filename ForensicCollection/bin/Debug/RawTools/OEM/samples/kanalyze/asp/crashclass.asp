<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    crashclass.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 18-NOV-1999

Revision History:

-->

<html>
<head>
<title>Kernel Memory Space Analyzer</title>
</head>
<body bgcolor="white">
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.Form("DSN")
    Set ClassID=Request.Form("ClassID")

    If DSN="" Then
        DSN=Request.QueryString("DSN")
    End If

    If ClassID="" Then
        ClassID=Request.QueryString("ClassID")
    End If

    If DSN="" Then
        DSN="KaKnownIssue"
    End If

    If ClassID="" Then
        ClassID="1"
    End If

    Connecter.Open(DSN)

    Command="select ClassID,AnalysisID,SolutionID,StopCode,StopCodeParameter1,"
    Command=Command+"StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,"
    Command=Command+"NTBuild,Platform,Canonical,KeyWord1,KeyWord2,KeyWord3,KeyWord4,"
    Command=Command+"InstanceCount,FirstOccurrence,LastOccurrence from CrashClass "
    Command=Command+"where ClassID="+ClassID
    Set Data=Connecter.Execute(Command)

    If not Data.EOF Then

        Command="select Abstract from Analysis where AnalysisID="&Data("AnalysisID")
        Set AnalysisData=Connecter.Execute(Command)

        Command="select Abstract from Solution where SolutionID="&Data("SolutionID")
        Set SolutionData=Connecter.Execute(Command)
%>
    <a href="index.asp?DSN=<% =DSN %>">Return to Index</a>
    <h1>CrashClass</h1>
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <% ClassID=Data("ClassID") %>
            <td>ClassID</td>
            <td><% =ClassID %></td>
        </tr>
        <tr>
            <td>AnalysisID</td>
            <td><a href="analysis.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&AnalysisID=<% =Data("AnalysisID") %>"><% =Data("AnalysisID") %></a> : <% =Left(AnalysisData("Abstract"),80) %></td>
        </tr>
        <tr>
            <td>SolutionID</td>
            <td><a href="solution.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&SolutionID=<% =Data("SolutionID") %>"><% =Data("SolutionID") %></a> : <% =Left(SolutionData("Abstract"),80) %></td>
        </tr>
        <tr>
            <td>StopCode</td>
            <td><% =Data("StopCode") %></td>
        </tr>
        <tr>
            <td>StopCodeParameter1</td>
            <td><% =Data("StopCodeParameter1") %></td>
        </tr>
        <tr>
            <td>StopCodeParameter2</td>
            <td><% =Data("StopCodeParameter2") %></td>
        </tr>
        <tr>
            <td>StopCodeParameter3</td>
            <td><% =Data("StopCodeParameter3") %></td>
        </tr>
        <tr>
            <td>StopCodeParameter4</td>
            <td><% =Data("StopCodeParameter4") %></td>
        </tr>
        <tr>
            <td>NTBuild</td>
            <td><% =Data("NTBuild") %></td>
        </tr>
        <tr>
            <td>Platform</td>
            <td><% =Data("Platform") %></td>
        </tr>
        <tr>
            <td>Canonical</td>
            <td><% =Data("Canonical") %></td>
        </tr>
        <tr>
            <td>Keyword1</td>
            <td><% =Data("Keyword1") %></td>
        </tr>
        <tr>
            <td>Keyword2</td>
            <td><% =Data("Keyword2") %></td>
        </tr>
        <tr>
            <td>Keyword3</td>
            <td><% =Data("Keyword3") %></td>
        </tr>
        <tr>
            <td>Keyword4</td>
            <td><% =Data("Keyword4") %></td>
        </tr>
        <tr>
            <td>InstanceCount</td>
            <td><% =Data("InstanceCount") %></td>
        </tr>
        <tr>
            <td>FirstOccurrence</td>
            <td><% =Data("FirstOccurrence") %></td>
        </tr>
        <tr>
            <td>LastOccurrence</td>
            <td><% =Data("LastOccurrence") %></td>
        </tr>
    </table>
    <p>
    <table>
        <tr>
            <td>View</td>
            <td>
                <a href="crashinstance.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">CrashInstance</a> /
                <a href="hintdata.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&SolutionID=<% =Data("SolutionID") %>">HintData</a> /
                <a href="progress.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&AnalysisID=<% =Data("AnalysisID") %>">ProgressText</a>
            </td>
        </tr>
        <tr>
            <td>Update</td>
            <td>
                <a href="crashclassupdate.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">CrashClass</a>
            </td>
        </tr>
        <tr>
            <td>Add</td>
            <td>
                <a href="solutioninsert.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Solution</a> /
                <a href="analysisinsert.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Analysis</a> /
                <a href="hintdatainsert.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&SolutionID=<% =Data("SolutionID") %>">HintData</a> /
                <a href="progressinsert.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&AnalysisID=<% =Data("AnalysisID") %>">ProgressText</a>
            </td>
        </tr>
    </table>
<%
        SolutionData.Close
        AnalysisData.Close

    Else
%>
    No data
<%
    End If
    Data.Close
    Connecter.Close
%>
</body>
</html>
