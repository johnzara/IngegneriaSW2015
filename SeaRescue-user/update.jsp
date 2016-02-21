<%@ page import="pdtb.connessioni.Connessioni" %>
<%@ page import="pdtb.connessioni.Percorso" %>

<!--pagina per aggiornare il singleton-->
<%
Percorso percorso = Percorso.getInstance();
String toAdd = "";
toAdd=request.getParameter("daAggiungere");
percorso.aggiungiScelta(toAdd);
String site = "prima_schermata.jsp";
response.setStatus(response.SC_MOVED_TEMPORARILY);
response.setHeader("Location", site);
%>