<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    progress.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 19-NOV-1999

Revision History:

-->

<html>
<head>
<title>Kernel Memory Space Analyzer</title>
</head>
<body bgcolor=white>
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set AnalysisID=Request.QueryString("AnalysisID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>ProgressText</h1>
<%

    Command="select ProgressTextID,DateTime,Annotation,Author"
    Command=Command+" from ProgressText where AnalysisID="+AnalysisID
    Set Data=Connecter.Execute(Command)

    If not Data.EOF Then

    Do While not Data.EOF %>
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>ProgressTextID</td>
            <td><% =Data("ProgressTextID") %></td>
        </tr>
        <tr>
            <td>AnalysisID</td>
            <td><% =AnalysisID %></td>
        </tr>
        <tr>
            <td>DateTime</td>
            <td><% =Data("DateTime") %></td>
        </tr>
        <tr>
            <td>Annotation</td>
            <td><% =Data("Annotation") %></td>
        </tr>
        <tr>
            <td>Author</td>
            <td><% =Data("Author") %></td>
        </tr>
    </table>
    <p>
    <a href="progressupdate.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&ProgressTextID=<% =Data("ProgressTextID") %>&AnalysisID=<% =AnalysisID%>">ProgressText Update</a>
    <hr>
<%
    Data.MoveNext
    Loop

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
