<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    hintdatainsertex.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 19-NOV-1999

Revision History:

-->
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set ClassID=Request.QueryString("ClassID")
    Set SolutionID=Request.QueryString("SolutionID")
    Connecter.Open(DSN)

    Command="insert into HintData (SolutionID,Data) values("
    Command=Command+Request.Form("SolutionID")+","
    Command=Command+"'"+Left(Replace( Request.Form("Data"), "'", "''"),2500)+"')"
    Set Data=Connecter.Execute(Command)

    Response.Redirect "crashclass.asp?DSN="&DSN&"&ClassID="&ClassID
%>
