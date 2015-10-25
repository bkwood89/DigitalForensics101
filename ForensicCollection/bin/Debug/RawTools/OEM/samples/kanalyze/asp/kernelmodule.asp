<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    kernelmodule.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 18-NOV-1999

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
    <h1>KernelModuleData</h1>
<%
    Command="select KernelModuleID,BaseName,Size,CheckSum,DateTime,"
    Command=Command+"SubSystemMajorVersion,SubSystemMinorVersion from "
    Command=Command+"KernelModuleData where KernelModuleID in "
    Command=Command+"(select KernelModuleID from KernelModule where "
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
            <td>KernelModuleID</td>
            <td><% =Data("KernelModuleID") %></td>
        </tr>
        <tr>
            <td>BaseName</td>
            <td><% =Data("BaseName") %></td>
        </tr>
        <tr>
            <td>Size</td>
            <td><% =Data("Size") %></td>
        </tr>
        <tr>
            <td>CheckSum</td>
            <td><% =Data("CheckSum") %></td>
        </tr>
        <tr>
            <td>DateTime</td>
            <td><% =Data("DateTime") %></td>
        </tr>
        <tr>
            <td>SubSystemMajorVersion</td>
            <td><% =Data("SubSystemMajorVersion") %></td>
        </tr>
        <tr>
            <td>SubSystemMinorVersion</td>
            <td><% =Data("SubSystemMinorVersion") %></td>
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
