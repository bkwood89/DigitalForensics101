<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    external.asp

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
    <h1>ExternalRecordLocator</h1>
<%
    Command="select Customer,ServiceRec from ExternalRecordLocator where "
    Command=Command+"ClassID="+ClassID+" and InstanceID="+InstanceID
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
            <td>Customer</td>
            <td><% =Data("Customer") %></td>
        </tr>
        <tr>
            <td>ServiceRec</td>
            <td><% =Data("ServiceRec") %></td>
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
