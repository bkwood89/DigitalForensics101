<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    analysisupdateex.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 18-NOV-1999

Revision History:

-->
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set AnalysisID=Request.QueryString("AnalysisID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)

    Command="update Analysis set "
    Command=Command+"Abstract='"+Left(Replace( Request.Form("Abstract"), "'", "''"),350)+"',"
    Command=Command+"ProblemDescription='"+Left(Replace( Request.Form("AnalysisDetails"), "'", "''"),3250)+"',"
    Command=Command+"Keywords='"+Left(Replace( Request.Form("Keywords"), "'", "''"),400)+"',"
    Command=Command+"Status='"+Left(Replace( Request.Form("Status"), "'", "''"),8)+"' "
    Command=Command+"where AnalysisID="+AnalysisID
    Set Data=Connecter.Execute(Command)

    Response.Redirect "analysis.asp?DSN="+DSN+"&ClassID="+ClassID+"&AnalysisID="+AnalysisID
%>
