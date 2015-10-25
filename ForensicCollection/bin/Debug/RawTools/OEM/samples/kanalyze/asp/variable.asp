<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    variable.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 29-NOV-1999

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
    <h1>VariableCrashData</h1>
<%
    Command="select BlobName,BlobWriterID,DataLength from "
    Command=Command+"VariableCrashData where ClassID="+ClassID
    Command=Command+" and InstanceID="+InstanceID
    Set Data=Connecter.Execute(Command)

    If not Data.EOF Then
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
            <td>BlobName</td>
            <td><% =Data("BlobName") %></td>
        </tr>
        <tr>
            <td>BlobWriterID</td>
            <td><% =Data("BlobWriterID") %></td>
        </tr>
        <tr>
            <td>Data</td>
            <td>[image data]</td>
        </tr>
        <tr>
            <td>DataLength</td>
            <td><% =Data("DataLength") %></td>
        </tr>
    </table>
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
