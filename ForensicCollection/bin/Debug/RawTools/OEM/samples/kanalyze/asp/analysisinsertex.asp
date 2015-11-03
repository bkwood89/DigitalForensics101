<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    analysisinsertex.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 18-NOV-1999

Revision History:

-->
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)

    Command="insert into Analysis (Abstract,ProblemDescription,Keywords,Status) values("
    Command=Command+"'"+Left(Replace( Request.Form("Abstract"), "'", "''"),350)+"',"
    Command=Command+"'"+Left(Replace( Request.Form("AnalysisDetails"), "'", "''"),3250)+"',"
    Command=Command+"'"+Left(Replace( Request.Form("Keywords"), "'", "''"),400)+"',"
    Command=Command+"'"+Left(Replace( Request.Form("Status"), "'", "''"),8)+"')"

    Set Data=Connecter.Execute(Command)

    Command="select AnalysisID from Analysis where AnalysisID in "
    Command=Command+"(select max(AnalysisID) from Analysis)"
    Set Data=Connecter.Execute(Command)

    AnalysisID=Data("AnalysisID")

    Command="update CrashClass set AnalysisID="&AnalysisID
    Command=Command&" where ClassID="&ClassID
    Set Data=Connecter.Execute(Command)

    Response.Redirect "crashclass.asp?DSN="&DSN&"&ClassID="&ClassID
%>
