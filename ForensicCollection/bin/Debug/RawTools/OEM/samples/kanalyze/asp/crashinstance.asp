<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    crashinstance.asp

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
    Set DSN=Request.QueryString("DSN")
    Set ClassID=Request.QueryString("ClassID")
    Set InstanceID=Request.QueryString("InstanceID")
    Connecter.Open(DSN)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>CrashInstance</h1>
<%
    Command="select ClassID,InstanceID,HWProfileRecID,OSProfileRecID,"
    Command=Command+"StopCodeParameter1,StopCodeParameter2,StopCodeParameter3,"
    Command=Command+"StopCodeParameter4,KanalyzeMajorVersion,KanalyzeMinorVersion,"
    Command=Command+"CrashTimeDate from CrashInstance where ClassID="+ClassID
    Command=Command+" order by InstanceID"
    Set Data=Connecter.Execute(Command)

    Do While not Data.EOF %>
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>ClassID</td>
            <td><% =ClassID %></td>
        </tr>
        <tr>
            <td>InstanceID</td>
            <% InstanceID=Data("InstanceID") %>
            <td><% =InstanceID %></td>
        </tr>
        <tr>
            <td>HWProfileRecID</td>
            <td><a href="hwprofile.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>&HWProfileRecID=<% =Data("HWProfileRecID") %>"><% =Data("HWProfileRecID") %></a></td>
        </tr>
        <tr>
            <td>OSProfileRecID</td>
            <td><a href="osprofile.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>&OSProfileRecID=<% =Data("OSProfileRecID") %>"><% =Data("OSProfileRecID") %></a></td>
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
            <td>KanalyzeMajorVersion</td>
            <td><% =Data("KanalyzeMajorVersion") %></td>
        </tr>
        <tr>
            <td>KanalyzeMinorVersion</td>
            <td><% =Data("KanalyzeMinorVersion") %></td>
        </tr>
        <tr>
            <td>CrashTimeDate</td>
            <td><% =Data("CrashTimeDate") %></td>
        </tr>
    </table>
    <p>
    <a href="kernelmodule.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>">KernelModule</a> /
    <a href="kanalyzemodule.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>">KanalyzeModule</a> /
    <a href="variable.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>">VariableCrashData</a> /
    <a href="attachment.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>">AttachmentData</a> /
    <a href="external.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&InstanceID=<% =InstanceID %>">ExternalRecordLocator</a>
    <hr>
    <% Data.MoveNext
    Loop

    Data.Close
    Connecter.Close
%>
</body>
</html>
