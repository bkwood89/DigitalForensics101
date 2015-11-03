<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    kanalyzemodule.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 26-NOV-1999

Revision History:

-->

<html>
<head>
<title>Kernel Memory Space Analyzer</title>
</head>
<body bgcolor=white>
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set ClassID=Request.QueryString("ClassID")
    Set InstanceID=Request.QueryString("InstanceID")
    Set DSN=Request.QueryString("DSN")

    Connecter.Open(DSN)
%>
    <a href="crashinstance.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>">Return to CrashInstance Table</a>
    <h1>KanalyzeModuleData</h1>
<%
    Command="select KanalyzeModuleID,BaseName,Type,AlternateName,"
    Command=Command+"MajorVersion,MinorVersion,Description from "
    Command=Command+"KanalyzeModuleData where KanalyzeModuleID in "
    Command=Command+"(select KanalyzeModuleID from KanalyzeModule where "
    Command=Command+"ClassID="+ClassID+" and InstanceID="+InstanceID
    Command=Command+") order by BaseName"
    Set Data=Connecter.Execute(Command)
%>
    ClassID:<% =ClassID %><br>
    InstanceID:<% =InstanceID %>
    <p>
    <% Do While not Data.EOF %>
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>KanalyzeModuleID</td>
            <td><% =Data("KanalyzeModuleID") %></td>
        </tr>
        <tr>
            <td>BaseName</td>
            <td><% =Data("BaseName") %></td>
        </tr>
        <tr>
            <td>Type</td>
            <td><% =Data("Type") %></td>
        </tr>
        <tr>
            <td>AlternateName</td>
            <td><% =Data("AlternateName") %></td>
        </tr>
        <tr>
            <td>MajorVersion</td>
            <td><% =Data("MajorVersion") %></td>
        </tr>
        <tr>
            <td>MinorVersion</td>
            <td><% =Data("MinorVersion") %></td>
        </tr>
        <tr>
            <td>Description</td>
            <td><% =Data("Description") %></td>
        </tr>
    </table>
    <hr>
    <% Data.MoveNext
    Loop

    Data.Close
    Connecter.Close
%>
</body>
</html>
