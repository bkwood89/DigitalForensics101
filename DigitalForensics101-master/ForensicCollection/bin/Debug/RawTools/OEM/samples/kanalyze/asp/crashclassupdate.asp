<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    crashclassupdate.asp

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
    Connecter.Open(DSN)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>CrashClass Update </h1>
<%

    Command="select ClassID,AnalysisID,SolutionID,StopCode,StopCodeParameter1,"
    Command=Command+"StopCodeParameter2,StopCodeParameter3,StopCodeParameter4,"
    Command=Command+"NTBuild,Platform,Canonical,KeyWord1,KeyWord2,KeyWord3,KeyWord4,"
    Command=Command+"InstanceCount,FirstOccurrence,LastOccurrence from CrashClass "
    Command=Command+"where ClassID="+ClassID
    Set Data=Connecter.Execute(Command)

    Command="select AnalysisID,Abstract from Analysis"
    Set AnalysisData=Connecter.Execute(Command)

    Command="select SolutionID,Abstract from Solution"
    Set SolutionData=Connecter.Execute(Command)
%>
    <form action="crashclassupdateex.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>" method="post">
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
            <td><select name="AnalysisID">
                <% Do While not AnalysisData.EOF %>
                    <option <% If AnalysisData("AnalysisID")=Data("AnalysisID") Then %>
                                selected
                            <% End If %>
                            value="<% =AnalysisData("AnalysisID") %>"><% =AnalysisData("AnalysisID") %> : <% =Left(AnalysisData("Abstract"),80) %>
                <% AnalysisData.MoveNext
                Loop %>
                </select>
            </td>
        </tr>
        <tr>
            <td>SolutionID</td>
            <td><select name="SolutionID">
                <% Do While not SolutionData.EOF %>
                    <option <% If SolutionData("SolutionID")=Data("SolutionID") Then %>
                                selected
                            <% End If %>
                            value="<% =SolutionData("SolutionID") %>"><% =SolutionData("SolutionID") %> : <% =Left(SolutionData("Abstract"),80) %>
                <% SolutionData.MoveNext
                Loop %>
                </select>
            </td>
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
    <input type="submit" value="Update">
<%
    SolutionData.Close
    AnalysisData.Close
    Data.Close
    Connecter.Close
%>
</body>
</html>
