<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    hintdata.asp

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
    Set SolutionID=Request.QueryString("SolutionID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>HintData</h1>
<%
    Command="select DataID,Data"
    Command=Command+" from HintData where SolutionID="+SolutionID
    Set Data=Connecter.Execute(Command)

    If not Data.EOF Then

    Do While not Data.EOF %>
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>DataID</td>
            <td><% =Data("DataID") %></td>
        </tr>
        <tr>
            <td>SolutionID</td>
            <td><% =SolutionID %></td>
        </tr>
        <tr>
            <td>Data</td>
            <td><% =Data("Data") %></td>
        </tr>
    </table>
    <p>
    <a href="hintdataupdate.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&DataID=<% =Data("DataID") %>&SolutionID=<% =SolutionID %>">HintData Update</a>
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
